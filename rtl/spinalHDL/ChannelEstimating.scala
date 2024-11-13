package spinal.demo.ofdm
import spinal.core._
import spinal.core.sim._
import spinal.lib._
case class ChannelEstimating () extends Component{
  val io = new Bundle{
    val AveLongTrainingEnable = in Bool()
    val AveLongTrainingRe = in SInt(8 bits)
    val AveLongTrainingIm = in SInt(8 bits)
    val ChannelCoefEnable = out Bool()
    val ChannelCoefRe = out SInt(8 bits)
    val ChannelCoefIm = out SInt(8 bits)
  }
  noIoPrefix()
//  ClockDomain.current.clock.setName("CLK")
//  ClockDomain.current.reset.setName("Rst_n")
  val LTSMem = Mem(SInt(2 bits), Array(    S(0, 2 bits),  S(1, 2 bits),  S(-1, 2 bits), S(-1, 2 bits)
                                         , S(1, 2 bits),  S(1, 2 bits),  S(-1, 2 bits), S(1, 2 bits)
                                         , S(-1, 2 bits), S(1, 2 bits),  S(-1, 2 bits), S(-1, 2 bits)
                                         , S(-1, 2 bits), S(-1, 2 bits), S(-1, 2 bits), S(1, 2 bits)
                                         , S(1, 2 bits),  S(-1, 2 bits), S(-1, 2 bits), S(1, 2 bits)
                                         , S(-1, 2 bits), S(1, 2 bits),  S(-1, 2 bits), S(1, 2 bits)
                                         , S(1, 2 bits),  S(1, 2 bits),  S(1, 2 bits),  S(0, 2 bits)
                                         , S(0, 2 bits),  S(0, 2 bits),  S(0, 2 bits),  S(0, 2 bits)
                                         , S(0, 2 bits),  S(0, 2 bits),  S(0, 2 bits),  S(0, 2 bits)
                                         , S(0, 2 bits),  S(0, 2 bits),  S(1, 2 bits),  S(1, 2 bits)
                                         , S(-1, 2 bits), S(-1, 2 bits), S(1, 2 bits),  S(1, 2 bits)
                                         , S(-1, 2 bits), S(1, 2 bits),  S(-1, 2 bits), S(1, 2 bits)
                                         , S(1, 2 bits),  S(1, 2 bits),  S(1, 2 bits),  S(1, 2 bits)
                                         , S(1, 2 bits),  S(-1, 2 bits), S(-1, 2 bits), S(1, 2 bits)
                                         , S(1, 2 bits),  S(-1, 2 bits), S(1, 2 bits),  S(-1, 2 bits)
                                         , S(1, 2 bits),  S(1, 2 bits),  S(1, 2 bits),  S(1, 2 bits)
                                         )
                   )
  val addr = Reg(UInt(6 bits)).init(0)
  val TempCoefRe = cloneOf(io.ChannelCoefRe)
  val TempCoefIm = cloneOf(io.ChannelCoefIm)
  TempCoefRe.clearAll()
  TempCoefIm.clearAll()
  when(RegNext(io.AveLongTrainingEnable).init(False)){
    addr := addr + 1
    switch(LTSMem.readSync(addr)){
      is(S(0, 2 bits)){
        TempCoefRe := S(0, widthOf(io.ChannelCoefRe) bits)
        TempCoefIm := S(0, widthOf(io.ChannelCoefIm) bits)
      }
      is(S(1, 2 bits)){
        TempCoefRe := io.AveLongTrainingRe
        TempCoefIm := -io.AveLongTrainingIm
      }
      default{
        TempCoefRe := -io.AveLongTrainingRe
        TempCoefIm := io.AveLongTrainingIm
      }
    }
  }
  io.ChannelCoefEnable := RegNext(io.AveLongTrainingEnable).init(False)
  io.ChannelCoefRe := RegNext(TempCoefRe).init(0)
  io.ChannelCoefIm := RegNext(TempCoefIm).init(0)
}
object ChannelEstimating {
  def main(args: Array[String]): Unit = {
    SpinalConfig(
      targetDirectory = "verilog/ofdm",
      oneFilePerComponent = false,
      defaultConfigForClockDomains = ClockDomainConfig(resetActiveLevel = LOW)
      ).generateVerilog(ChannelEstimating())
  }
}
object ChannelEstimatingSim {
  def main(args: Array[String]): Unit = {
    SimConfig.withVcdWave.compile(ChannelEstimating()).doSimUntilVoid { dut =>
      import dut._
      io.AveLongTrainingEnable #= false
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