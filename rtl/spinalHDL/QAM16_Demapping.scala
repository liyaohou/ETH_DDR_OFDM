package spinal.demo.ofdm
import spinal.core._
import spinal.core.sim._
import spinal.lib._
case class QAM16_Demapping ()extends Component{
  val io = new Bundle{
    val EnergyInEn = in Bool ()
    val EnergyPos = in SInt(14 bits)
    val EnergyNeg = in SInt(14 bits)
    val inputDataEn = in Bool()
    val inputDataR = in SInt(10 bits)
    val inputDataI = in SInt(10 bits)
    val inputSymbol = in UInt(8 bits)
    val outputDataEn = out Bool()
    val outDataDemod = out Bits(4 bits)
    val outputSymbol = out UInt(8 bits)
  }
  noIoPrefix()
  class Context extends Bundle {
    val Pos = cloneOf(io.EnergyPos)
    val Neg = cloneOf(io.EnergyNeg)
  }
  val DataInStream = Flow(new Context)
  class mem_QAM16_Demapping extends Mem(new Context, 64)
  val mem = new mem_QAM16_Demapping
  DataInStream.valid := io.EnergyInEn
  DataInStream.Pos := io.EnergyPos
  DataInStream.Neg := io.EnergyNeg
  val wrAddr = Counter(0 until 48).init(0)
  val rdAddr = Counter(0 until 48).init(0)
  val memRdPos = mem.readSync(rdAddr).Pos
  val memRdNeg = mem.readSync(rdAddr).Neg
  when(DataInStream.valid){
    mem.write(wrAddr, DataInStream.payload)
    wrAddr.increment()
  }otherwise()
  when(io.inputDataEn){
    rdAddr.increment()
  }otherwise()
  val AdjustI_0_P = io.inputDataR > 0
  val AdjustI_E_P = io.inputDataR <= memRdPos
  val AdjustI_E_N = io.inputDataR >= memRdNeg
  val AdjustQ_0_P = io.inputDataI > 0
  val AdjustQ_E_P = io.inputDataI <= memRdPos
  val AdjustQ_E_N = io.inputDataI >= memRdNeg
  val TempOut = cloneOf(io.outDataDemod)
  TempOut(3 downto(2)) := (AdjustI_0_P ? AdjustI_E_P | AdjustI_E_N) ## AdjustI_0_P
  TempOut(1 downto(0)) := (AdjustQ_0_P ? AdjustQ_E_P | AdjustQ_E_N) ## AdjustQ_0_P
  io.outputDataEn := RegNext(io.inputDataEn).init(False)
  io.outDataDemod := RegNext(TempOut).init(0)
  io.outputSymbol := RegNext(io.inputSymbol).init(0)
}
object QAM16_Demapping {
  def main(args: Array[String]): Unit = {
    SpinalConfig(
      targetDirectory = "verilog/ofdm",
      oneFilePerComponent = false,
      defaultConfigForClockDomains = ClockDomainConfig(resetActiveLevel = LOW)
      ).generateVerilog(QAM16_Demapping())
  }
}
object QAM16_DemappingSim {
  def main(args: Array[String]): Unit = {
    SimConfig.withVcdWave.compile(QAM16_Demapping()).doSimUntilVoid{dut =>
      import dut._
      clockDomain.forkStimulus(10000)
      fork {
        dut.clockDomain.assertReset()
        sleep(500000)
        dut.clockDomain.deassertReset()
        sleep(10000)
      }
      def inputOne(last: Boolean) = {
        io.inputDataEn #= true
        io.inputDataR.randomize()
        io.inputDataI.randomize()
        clockDomain.waitSampling()
        io.inputDataEn #= false
        clockDomain.waitSampling(7)
      }
      def input(num: Int) = {
        for(i <- 0 until(num)){
          inputOne(i==num-1)
        }
      }
      def inputOne_E(last: Boolean) = {
        io.EnergyInEn #= true
        io.EnergyPos.randomize()
        io.EnergyNeg.randomize()
        clockDomain.waitSampling()
        io.EnergyInEn #= false
        clockDomain.waitSampling(7)
      }
      def input_E(num: Int) = {
        for(i <- 0 until(num)){
          inputOne_E(i==num-1)
        }
      }
      io.EnergyInEn #= false
      io.EnergyPos #= 0
      io.EnergyNeg #= 0
      io.inputDataEn #= false
      io.inputDataR #= 0
      io.inputDataI #= 0
      io.inputSymbol #= 0
      clockDomain.waitSampling(100)
      io.inputSymbol #= 0
      input_E(48)
            for(i <- 3 to(10)){
              io.inputSymbol #= i
              clockDomain.waitSampling(160)
              input(48)
            }
      clockDomain.waitSampling(4)
      clockDomain.waitSampling(100)
      simSuccess()
    }
  }
}