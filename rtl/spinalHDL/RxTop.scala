package spinal.demo.workSpace
import spinal.core._
import spinal.demo.ofdm.{DataRestore, OFDMRX}
import spinal.demo.phy.DDR3IO
import spinal.demo.workSpace.RxTop.axi4Stream
import spinal.lib._
import spinal.lib.bus.amba4.axis._
import spinal.lib.bus.bmb.BmbParameter
import spinal.lib.memory.sdram.dfi.interface._

case class RxTop(
                  axi4s: Axi4StreamConfig,
                  bmbp: BmbParameter,
                  ddrIoDfiConfig: DfiConfig,
                  dfiConfig: DfiConfig,
                  wrLength: Int,
                  rdLength: Int,
                  dacWidth: Int,
                  configWidth: Int,
                  localMac: BigInt = BigInt("665544332211", 16),
                  destIp: BigInt = BigInt("c0a80141", 16)
                ) extends Component {

  val io = new Bundle {
    val sysRstN = in Bool()
    val sys_clk = in Bool()
    val rgmii = master(Rgmii())
    val ddr3 = new DDR3IO(ddrIoDfiConfig)
    val adcData = in Bits(16 bits)
    val adcClk = out Bool()
//    val txEnd = out Bool ()
//    val adcClk = out Bool ()
//    val adcData = out Bits (dacWidth bits)
//    val inputDataEn = in Bool()
//    val inputDataR = in SInt(8 bits)
//    val inputDataI = in SInt(8 bits)
//    val inputSymbol = in UInt(8 bits)
//    val axisIn = slave(Axi4Stream(axi4s))
//    val rxEnd = in Bool()
  }
  noIoPrefix()
  io.flatten.foreach(bt => {
    if (bt.getName().contains("rstN")) bt.setName(bt.getName().replace("N", "_n"))
    if (bt.getName().contains("Ctl")) bt.setName(bt.getName().replace("Ctl", "_ctl"))
  })
  io.sysRstN.setName("sys_rst_n")
  val myClockDomain = ClockDomain(clock = io.sys_clk, reset = io.sysRstN, config = ClockDomainConfig(resetActiveLevel = LOW))
  val myClockArea = new ClockingArea(myClockDomain){
    val pllClk = pll_clk().setName("pll_clk")
  }
  val workClk = myClockArea.pllClk.io.clk.out1
  val dev2Clk = myClockArea.pllClk.io.clk.out3
  val dev4Clk = myClockArea.pllClk.io.clk.out4
  val workClk90 = myClockArea.pllClk.io.clk.out2
  val workClk270 = myClockArea.pllClk.io.clk.out5
  val Clk20M = myClockArea.pllClk.io.clk.out6
  val rstN = io.sysRstN & myClockArea.pllClk.io.locked
  io.adcClk := Clk20M
  val workClockDomain = ClockDomain(clock = workClk, reset = rstN, config = ClockDomainConfig(resetActiveLevel = LOW))
  val bmbClockDomain = ClockDomain(clock = dev4Clk, reset = rstN, config = ClockDomainConfig(resetActiveLevel = LOW))
  val adcClockDomain = ClockDomain(clock = Clk20M, reset = rstN, config = ClockDomainConfig(resetActiveLevel = LOW))
  val workClockArea = new ClockingArea(workClockDomain) {

    val ofdm_rx = OFDMRX(axi4s, adcClockDomain)
    ofdm_rx.io.adcData := io.adcData
//    val dataRestore = DataRestore(axi4s)
//    dataRestore.io.inputDataEn <> io.inputDataEn
//    dataRestore.io.inputDataR <> io.inputDataR
//    dataRestore.io.inputDataI <> io.inputDataI
//    dataRestore.io.inputSymbol <> io.inputSymbol

    val axisRxRateCtrl = AxisRxRateCtrl(axi4s,wrLength + 28)
    axisRxRateCtrl.io.rxEnd.ready <> ofdm_rx.io.axisOut.last
    axisRxRateCtrl.io.axiIn << ofdm_rx.io.axisOut

    val harMatchEth = HarMatch(axi4s)
    harMatchEth.io.signalIn << axisRxRateCtrl.io.signalOut

    val ethMacRx = eth_mac_rx_r(axi4s, bmbp.access.lengthWidth)
    ethMacRx.io.logicClk <> workClk
    ethMacRx.io.gtxClk90 <> workClk
    ethMacRx.io.gtxClk <> workClk270
    ethMacRx.io.rstN <> rstN
    ethMacRx.io.port.eth.rx.axis << harMatchEth.io.signalOut.map(_.axis)
    ethMacRx.io.port.eth.rx.hdr << harMatchEth.io.hdr

    val rxHdr = ethMacRx.io.port.udp.rx.hdr.m2sPipe()
    val lengthIn = RegNextWhen(ethMacRx.io.port.udp.rx.length, rxHdr.fire)
    rxHdr.ready.set()
    val wrEnd = Reg(Bool()).init(False)

    val ddr3AxisTxIf =
      Ddr3AxisTxInterface(
        tx_rx = false,
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
    ddr3AxisTxIf.io.axisWr << ethMacRx.io.port.udp.rx.axis
    ddr3AxisTxIf.io.lengthIn <> lengthIn
    ddr3AxisTxIf.io.writeEnd.ready <> (wrEnd & ethMacRx.io.port.udp.rx.axis.lastFire)
    ddr3AxisTxIf.io.ddr3 <> io.ddr3
    wrEnd.setWhen(harMatchEth.io.signalOut.lastPiece).clearWhen(ddr3AxisTxIf.io.writeEnd.valid)

    val axisTxEth = AxisTxEth(axi4s, rdLength + 28)
    axisTxEth.io.axiIn << ddr3AxisTxIf.io.signalRd.map(_.axis)
    axisTxEth.io.txCtrl >> ddr3AxisTxIf.io.txCtrl
    axisTxEth.io.start := ddr3AxisTxIf.io.writeEnd.valid
    axisTxEth.io.rxEnd := ddr3AxisTxIf.io.signalRd.lastPiece
//    axisTxRateCtrl.io.txEnd <> io.txEnd

    val harMatch = AxisHarMatch(axi4s)
    harMatch.io.axiIn << axisTxEth.io.axiOut

    val ethMacTx = eth_mac_rx_t(axi4s, bmbp.access.lengthWidth)
    ethMacTx.io.logicClk <> workClk
    ethMacTx.io.gtxClk90 <> workClk
    ethMacTx.io.gtxClk <> workClk270
    ethMacTx.io.rstN <> rstN
    ethMacTx.io.port.udp.tx.hdr << harMatch.io.hdr
    ethMacTx.io.port.udp.tx.axis << harMatch.io.axiOut
    ethMacTx.io.port.udp.tx.destIp := B(destIp).resized
    ethMacTx.io.port.udp.tx.length <>  ddr3AxisTxIf.io.lengthOut
    ethMacTx.io.rgmii.rxc <> io.rgmii.rxc
    ethMacTx.io.rgmii.rxd <> io.rgmii.rxd
    ethMacTx.io.rgmii.rxCtl <> io.rgmii.rxCtl
    ethMacTx.io.rgmii.txc <> io.rgmii.txc
    ethMacTx.io.rgmii.txd <> io.rgmii.txd
    ethMacTx.io.rgmii.txCtl <> io.rgmii.txCtl
    ethMacTx.io.rgmii.rstN <> io.rgmii.rstN

  }
}

object RxTop {
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
    SpinalConfig(targetDirectory = "verilog/rx", oneFilePerComponent = true).generateVerilog(
      RxTop(
        axi4s = axi4Stream,
        bmbp = bmbParameter,
        ddrIoDfiConfig = ddrIoDfiConfig,
        dfiConfig = dfiConfig,
        wrLength = 512,
        rdLength = 1024,
        dacWidth = 16,
        configWidth = 21,
        destIp = BigInt("c0a80141", 16)
        )
      )
  }
}
