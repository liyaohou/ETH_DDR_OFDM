package spinal.demo.workSpace
import spinal.core._
import spinal.demo.phy.{BmbDfiDdr3, DDR3IO}
import spinal.lib._
import spinal.lib.bus.amba4.axis._
import spinal.lib.bus.bmb._
import spinal.lib.memory.sdram.dfi.interface._
case class Ddr3AxisTxInterface(
    tx_rx: Boolean,
    axis: Axi4StreamConfig,
    bmbp: BmbParameter,
    wrLength: Int,
    rdLength: Int,
    ddrIoDfiConfig: DfiConfig,
    dfiConfig: DfiConfig,
    bmbClockDomain: ClockDomain
) extends Component {

  val io = new Bundle {
    val clk1 = in Bool ()
    val clk2 = in Bool ()
    val clk3 = in Bool ()
    val clk4 = in Bool ()
    val axisWr = slave(Axi4Stream(axis))
    val lengthIn = in Bits (bmbp.access.lengthWidth bits)
    val lengthOut = out Bits (bmbp.access.lengthWidth bits)
    val signalRd = master(Stream(Payload(axis)))
    val txCtrl = slave(Stream(NoData()))
    val writeEnd = master(Stream(NoData()))
    val ddr3InitDone = out Bool ()
    val ddr3 = new DDR3IO(ddrIoDfiConfig)
  }

  val axi4StreamToBmb = Axi4StreamToBmb(tx_rx, axis, bmbp, wrLength, rdLength, bmbClockDomain)
  axi4StreamToBmb.io.axiIn << io.axisWr
  axi4StreamToBmb.io.lengthIn <> io.lengthIn
  axi4StreamToBmb.io.lengthOut <> io.lengthOut
  axi4StreamToBmb.io.writeEnd.ready := io.writeEnd.ready // tag
  axi4StreamToBmb.io.signalOut >> io.signalRd
  axi4StreamToBmb.io.rdCtr << io.txCtrl
  axi4StreamToBmb.io.writeEnd.valid <> io.writeEnd.valid

  val bmbClockArea = new ClockingArea(bmbClockDomain) {
    val bmbDfiDdr3 = BmbDfiDdr3(bmbp, ddrIoDfiConfig, dfiConfig)
    bmbDfiDdr3.io.bmb << axi4StreamToBmb.io.bmb
    bmbDfiDdr3.io.clk1 <> io.clk1.setName("work_clk")
    bmbDfiDdr3.io.clk2 <> io.clk2.setName("ddr_clk")
    bmbDfiDdr3.io.clk3 <> io.clk3.setName("ddr90_clk")
    bmbDfiDdr3.io.clk4 <> io.clk4.setName("ref_clk")
    bmbDfiDdr3.io.initDone <> io.ddr3InitDone
    bmbDfiDdr3.io.ddr3 <> io.ddr3
  }
}

object Ddr3AxisTxInterface {
  val axi4Stream = Axi4StreamConfig(
    dataWidth = 1,
    userWidth = 1,
    useLast = true,
    useUser = true
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
    ddrMHZ = 100,
    ddrWrLat = 6,
    ddrRdLat = 6,
    sdramtime = sdramtime
  )
  val timeConfig = DfiTimeConfig(
    tPhyWrLat = sdram.tPhyWrlat,
    tPhyWrData = 0,
    tPhyWrCsGap = 3,
    tRddataEn = sdram.tRddataEn,
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
  val bmbParameter = BmbParameter(
    addressWidth = 29,
    dataWidth = 32,
    sourceWidth = 0,
    contextWidth = 4,
    lengthWidth = 10,
    alignment = BmbParameter.BurstAlignement.BYTE
  )
  val bmbClk = Bool()
  val bmbRstN = Bool()
  val bmbClockDomain = ClockDomain(
    clock = bmbClk,
    reset = bmbRstN
  )
  def main(args: Array[String]): Unit = {
    SpinalConfig(targetDirectory = "verilog/rtl", oneFilePerComponent = false).generateVerilog(
      Ddr3AxisTxInterface(true, axi4Stream, bmbParameter, 1024, 64, ddrIoDfiConfig, dfiConfig, bmbClockDomain)
    )
  }
}
