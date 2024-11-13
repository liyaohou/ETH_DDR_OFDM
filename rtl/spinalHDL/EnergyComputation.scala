package spinal.demo.ofdm
import spinal.core._
import spinal.core.sim._
case class EnergyComputation() extends Component {
  val io = new Bundle {
    val AveLongTrainingEnable = in Bool ()
    val AveLongTrainingRe = in SInt (8 bits)
    val AveLongTrainingIm = in SInt (8 bits)
    val EnergyEnable = out Bool ()
    val Energy = out UInt(10 bits)
  }
  val AveLongTrainingReModulus = Reg(SInt(2*widthOf(io.AveLongTrainingRe) bits)).init(0)
  val AveLongTrainingImModulus = Reg(SInt(2*widthOf(io.AveLongTrainingIm) bits)).init(0)
  io.EnergyEnable := RegNext(io.AveLongTrainingEnable).init(False)
  when(io.EnergyEnable) {
    AveLongTrainingReModulus := io.AveLongTrainingRe * io.AveLongTrainingRe
    AveLongTrainingImModulus := io.AveLongTrainingIm * io.AveLongTrainingIm
  } otherwise {
    AveLongTrainingReModulus.clearAll()
    AveLongTrainingImModulus.clearAll()
  }
  val sum = AveLongTrainingReModulus +^ AveLongTrainingImModulus
  io.Energy := (sum(sum.high) ## sum(14 downto(6))).asUInt
}
object EnergyComputation {
  def main(args: Array[String]): Unit = {
    SpinalConfig(
      targetDirectory = "verilog/ofdm",
      oneFilePerComponent = false,
      defaultConfigForClockDomains = ClockDomainConfig(resetActiveLevel = LOW)
    ).generateVerilog(EnergyComputation())
  }
}
object EnergyComputationSim{
  def main(args: Array[String]): Unit = {
    SimConfig.withVcdWave.compile(EnergyComputation()).doSimUntilVoid{ dut =>
      import dut._
      clockDomain.forkStimulus(10000)
      def inputOne(last: Boolean) = {
        io.AveLongTrainingEnable #= true
        clockDomain.waitSampling()
        if(last)io.AveLongTrainingEnable #= false
        io.AveLongTrainingRe.randomize()
        io.AveLongTrainingIm.randomize()
        if(last)clockDomain.waitSampling()
        //        io.DataInEnable #= false
        if(last)io.AveLongTrainingRe #= 0
        if(last)io.AveLongTrainingIm #= 0
      }
      def input(num: Int) = {
        for(i <- 0 until(num)){
          inputOne(i==num-1)
          //          if(i != num-1)clockDomain.waitSampling(util.Random.nextInt(5))
        }
      }
      io.AveLongTrainingEnable #= false
      io.AveLongTrainingRe #= 0
      io.AveLongTrainingIm #= 0
      clockDomain.waitSampling(100)
      input(64)
      clockDomain.waitSampling(100)
      simSuccess()
    }
  }
}
