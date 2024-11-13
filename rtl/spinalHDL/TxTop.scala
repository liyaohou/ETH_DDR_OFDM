package spinal.demo.workSpace
import spinal.core._
import spinal.demo.phy.DDR3IO
import spinal.lib._
import spinal.lib.bus.amba4.axis.Axi4StreamConfig
import spinal.lib.bus.bmb.BmbParameter
import spinal.lib.memory.sdram.dfi.interface._

case class TxTop(
    axi4s: Axi4StreamConfig,
    bmbp: BmbParameter,
    ddrIoDfiConfig: DfiConfig,
    dfiConfig: DfiConfig,
    wrLength: Int,
    rdLength: Int,
    dacWidth: Int,
    configWidth: Int,
    destIp: BigInt = BigInt("c0a80180", 16)
) extends Component {

  val io = new Bundle {
    val sysClk = in Bool()
    val sysRstN = in Bool()
    val rgmii = master(Rgmii())
    val ddr3 = new DDR3IO(ddrIoDfiConfig)
//    val dac =  master(Stream(Fragment(Bits(dacWidth bits))))
//    val txEnd = out Bool ()
    val dacClk = out Bool ()
    val dacWrt = out Bool ()
    val dacData = out Bits (dacWidth bits)
  }
  noIoPrefix()
  io.flatten.foreach(bt => {
    if (bt.getName().contains("rstN")) bt.setName(bt.getName().replace("N", "_n"))
    if (bt.getName().contains("Ctl")) bt.setName(bt.getName().replace("Ctl", "_ctl"))
  })
  io.sysRstN.setName("sys_rst_n")
  io.sysClk.setName("sys_clk")
  val myClockDomain = ClockDomain(clock = io.sysClk, reset = io.sysRstN, config = ClockDomainConfig(resetActiveLevel = LOW))
  val myClockArea = new ClockingArea(myClockDomain){
    val pllClk = pll_clk().setName("pll_clk")
  }
  //  pllClk.io.clk.in1 := io.rgmii.rxc
  val workClk = myClockArea.pllClk.io.clk.out1
  val workClk90 = myClockArea.pllClk.io.clk.out2
  val dev2Clk = myClockArea.pllClk.io.clk.out3
  val dev4Clk = myClockArea.pllClk.io.clk.out4
  val workClk270 = myClockArea.pllClk.io.clk.out5
  val Clk20M = myClockArea.pllClk.io.clk.out6
  val rstN = io.sysRstN & myClockArea.pllClk.io.locked
  io.dacClk := Clk20M
  io.dacWrt := Clk20M
  val workClockDomain = ClockDomain(clock = workClk, reset = rstN, config = ClockDomainConfig(resetActiveLevel = LOW))
  val bmbClockDomain = ClockDomain(clock = dev4Clk, reset = rstN, config = ClockDomainConfig(resetActiveLevel = LOW))
  val workClockArea = new ClockingArea(workClockDomain) {

    val ethMacRx = eth_mac_tx_r(axi4s, bmbp.access.lengthWidth)
    ethMacRx.io.logicClk <> workClk
    ethMacRx.io.gtxClk90 <> workClk
    ethMacRx.io.gtxClk <> workClk270
    ethMacRx.io.rstN <> rstN
    ethMacRx.io.rgmii.rxc <> io.rgmii.rxc
    ethMacRx.io.rgmii.rxd <> io.rgmii.rxd
    ethMacRx.io.rgmii.rxCtl <> io.rgmii.rxCtl
    ethMacRx.io.rgmii.txc <> io.rgmii.txc
    ethMacRx.io.rgmii.txd <> io.rgmii.txd
    ethMacRx.io.rgmii.txCtl <> io.rgmii.txCtl
    ethMacRx.io.rgmii.rstN <> io.rgmii.rstN

    val configRx = ConfigRx(axi4s, 21, 10)
    configRx.io.udpAxisIn << ethMacRx.io.port.udp.rx.axis
    configRx.io.lengthIn := ethMacRx.io.port.udp.rx.length
    configRx.io.rxHdr << ethMacRx.io.port.udp.rx.hdr.m2sPipe()

    val ddr3AxisTxIf =
      Ddr3AxisTxInterface(
        tx_rx = true,
        axi4s,
        bmbp,
        wrLength = wrLength,
        rdLength = rdLength,
        ddrIoDfiConfig = ddrIoDfiConfig,
        dfiConfig = dfiConfig,
        bmbClockDomain = bmbClockDomain
      )
    ddr3AxisTxIf.io.clk1 := dev4Clk
    ddr3AxisTxIf.io.clk2 := workClk
    ddr3AxisTxIf.io.clk3 := workClk90
    ddr3AxisTxIf.io.clk4 := dev2Clk
    ddr3AxisTxIf.io.axisWr << configRx.io.udpAxisOut
    ddr3AxisTxIf.io.lengthIn <> configRx.io.lengthOut
    ddr3AxisTxIf.io.writeEnd.ready <> configRx.io.end
    ddr3AxisTxIf.io.ddr3 <> io.ddr3

    val ethMacTx = eth_mac_tx_t(axi4s, bmbp.access.lengthWidth)
    ethMacTx.io.logicClk <> workClk
    ethMacTx.io.gtxClk90 <> workClk
    ethMacTx.io.gtxClk <> workClk270
    ethMacTx.io.rstN <> rstN
    ethMacTx.io.port.udp.tx.destIp := B(destIp).resized
    ethMacTx.io.port.udp.tx.length <>  ddr3AxisTxIf.io.lengthOut

    val harMatch = HarMatch(axi4s)
    harMatch.io.signalIn << ddr3AxisTxIf.io.signalRd
    harMatch.io.signalOut.map(_.axis) >> ethMacTx.io.port.udp.tx.axis
    harMatch.io.hdr >> ethMacTx.io.port.udp.tx.hdr

    val axisTxRateCtrl = AxisTxRateCtrl(axi4s, rdLength + 28)
    axisTxRateCtrl.io.axiIn << ethMacTx.io.port.eth.tx.axis
    axisTxRateCtrl.io.txCtrl >> ddr3AxisTxIf.io.txCtrl
    axisTxRateCtrl.io.start := ddr3AxisTxIf.io.writeEnd.valid
    axisTxRateCtrl.io.rxEnd := harMatch.io.signalOut.lastPiece
//    axisTxRateCtrl.io.txEnd <> io.txEnd

    val ofdmTx = ofdm_tx(21, 16, 8)
    ofdmTx.io.clk_20m <> Clk20M
    ofdmTx.io.mcu.mac << axisTxRateCtrl.io.axiOut.translateWith(axisTxRateCtrl.io.axiOut.data)
    ofdmTx.io.mcu.config << axisTxRateCtrl.io.config.translateWith(configRx.io.config)
    ofdmTx.io.mcu.configStart := axisTxRateCtrl.io.cfgStart
//    ofdmTx.io.dac.payload(15 downto(9)) ## ofdmTx.io.dac.payload(7 downto(1)) <> io.dacData
    ofdmTx.io.dac.payload <> io.dacData
    ofdmTx.io.dac.ready.set()
    ofdmTx.io.txEnd <> axisTxRateCtrl.io.txEnd
//    ofdmTx.io.txEnd.set()
//    val axisTxRateCounter = CounterFreeRun(BigInt(4))
//    val ready = Reg(Bool())
//    ready.clearWhen( axisTxRateCtrl.io.axiOut.valid).setWhen(axisTxRateCounter.willOverflow)
//    axisTxRateCtrl.io.axiOut.ready := ready
//    axisTxRateCtrl.io.config.ready.set()
//    io.dacClk := io.rgmii.rxc
//    io.dacData.clearAll()
  }
}

object TxTop {
  val axi4Stream = Axi4StreamConfig(
    dataWidth = 1,
    userWidth = 1,
    useLast = true,
    useUser = true
  )
  val bmbParameter = BmbParameter(
    addressWidth = 29,
    dataWidth = 32,
    sourceWidth = 0,
    contextWidth = 4,
    lengthWidth = 10,
    alignment = BmbParameter.BurstAlignement.BYTE
  )
  val sdramtime = SdramTiming(
    generation = 3,
    RFC = 260,
    RAS = 38,
    RP = 15,
    RCD = 15,
    WTR = 8,
    WTP = 0,
    RTP = 8,
    RRD = 6,
    REF = 64000,
    FAW = 35
  )
  val sdram = SdramConfig(
    SdramGeneration.MYDDR,
    bankWidth = 3,
    columnWidth = 10,
    rowWidth = 15,
    dataWidth = 16,
    ddrMHZ = 31,
    ddrWrLat = 6,
    ddrRdLat = 6,
    sdramtime = sdramtime
  )
  val timeConfig = DfiTimeConfig(
    tPhyWrLat = sdram.tPhyWrlat,
    tPhyWrData = 0,
    tPhyWrCsGap = 3,
    tRddataEn = sdram.tRddataEn - 1,
    tPhyRdlat = 5,
    tPhyRdCsGap = 3,
    tPhyRdCslat = 0,
    tPhyWrCsLat = 0
  )
  val dfiConfig: DfiConfig = DfiConfig(
    frequencyRatio = 1,
    chipSelectNumber = 1,
    bgWidth = 0,
    cidWidth = 0,
    dataSlice = 1,
    cmdPhase = 0,
    signalConfig = new DDRSignalConfig(),
    timeConfig = timeConfig,
    sdram = sdram
  )
  val ddrIoDfiConfig: DfiConfig = DfiConfig(
    frequencyRatio = dfiConfig.frequencyRatio,
    chipSelectNumber = dfiConfig.chipSelectNumber,
    bgWidth = dfiConfig.bgWidth,
    cidWidth = dfiConfig.cidWidth,
    dataSlice = dfiConfig.dataSlice,
    cmdPhase = dfiConfig.cmdPhase,
    signalConfig = {
      val signalConfig = new DDRSignalConfig() {
        override def useOdt: Boolean = true
        override def useResetN: Boolean = true
        override def useRddataDnv = true
      }
      signalConfig
    },
    timeConfig = timeConfig,
    sdram = sdram
  )
  def main(args: Array[String]): Unit = {
    SpinalConfig(targetDirectory = "verilog/ddr", oneFilePerComponent = true).generateVerilog(
      TxTop(
        axi4s = axi4Stream,
        bmbp = bmbParameter,
        ddrIoDfiConfig = ddrIoDfiConfig,
        dfiConfig = dfiConfig,
        wrLength = 512,
        rdLength = 1024,
        dacWidth = 16,
        configWidth = 21,
        destIp = BigInt("c0a80180", 16)
      )
    )
  }
}
