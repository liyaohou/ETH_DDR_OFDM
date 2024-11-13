package spinal.demo.ofdm
import spinal.core._
import spinal.core.sim._
import spinal.demo.workSpace._
case class Channel_Equalizer() extends Component {
  val io = new Bundle {
    val DataInEnable = in Bool ()
    val DataInRe = in SInt (8 bits)
    val DataInIm = in SInt (8 bits)
    val DataInSymbol = in UInt (8 bits)
    val DataOutEnable = out Bool ()
    val DataOutRe = out SInt (10 bits)
    val DataOutIm = out SInt (10 bits)
    val DataOutSymbol = out UInt (8 bits)
    val EnergyEnable = out Bool ()
    val Energy = out UInt (10 bits)
  }
  noIoPrefix()
  val ltp_picking = LTP_Picking()
  ltp_picking.io.DataInEnable <> io.DataInEnable
  ltp_picking.io.DataInRe <> io.DataInRe
  ltp_picking.io.DataInIm <> io.DataInIm
  ltp_picking.io.DataInSymbol <> io.DataInSymbol

  val channelEstimating = ChannelEstimating()
  channelEstimating.io.AveLongTrainingEnable <> ltp_picking.io.AveLongTrainingEnable
  channelEstimating.io.AveLongTrainingRe <> ltp_picking.io.AveLongTrainingRe
  channelEstimating.io.AveLongTrainingIm <> ltp_picking.io.AveLongTrainingIm

  val energyComputation = EnergyComputation()
  energyComputation.io.AveLongTrainingEnable <> ltp_picking.io.AveLongTrainingEnable
  energyComputation.io.AveLongTrainingRe <> ltp_picking.io.AveLongTrainingRe
  energyComputation.io.AveLongTrainingIm <> ltp_picking.io.AveLongTrainingIm
  energyComputation.io.EnergyEnable <> io.EnergyEnable
  energyComputation.io.Energy <> io.Energy

  val channelCompensation = ChannelCompensation()
  channelCompensation.io.ChannelCoefEnable <> channelEstimating.io.ChannelCoefEnable
  channelCompensation.io.ChannelCoefRe <> channelEstimating.io.ChannelCoefRe
  channelCompensation.io.ChannelCoefIm <> channelEstimating.io.ChannelCoefIm
  channelCompensation.io.DataInEnable <> ltp_picking.io.DataOutEnable
  channelCompensation.io.DataInRe <> ltp_picking.io.DataOutRe
  channelCompensation.io.DataInIm <> ltp_picking.io.DataOutIm
  channelCompensation.io.DataInSymbol <> ltp_picking.io.DataOutSymbol
  channelCompensation.io.DataOutEnable <> io.DataOutEnable
  channelCompensation.io.DataOutRe <> io.DataOutRe
  channelCompensation.io.DataOutIm <> io.DataOutIm
  channelCompensation.io.DataOutSymbol <> io.DataOutSymbol
}

object Channel_Equalizer {
  def main(args: Array[String]): Unit = {
    SpinalConfig(
      targetDirectory = "verilog/ofdm",
      oneFilePerComponent = false,
      defaultConfigForClockDomains = ClockDomainConfig(resetActiveLevel = LOW)
    ).generateVerilog(Channel_Equalizer())
  }
}
object Channel_EqualizerSim {
  def main(args: Array[String]): Unit = {
    SimConfig.withVcdWave.compile(Channel_Equalizer()).doSimUntilVoid{dut =>
      import dut._
      clockDomain.forkStimulus(10000)
      def inputOne(last: Boolean) = {
//        io.DataInEnable #= true
//        clockDomain.waitSampling()
//        if(last)io.DataInEnable #= false
//        io.DataInRe.randomize()
//        io.DataInIm.randomize()
//        if(last)clockDomain.waitSampling()
//        //        io.DataInEnable #= false
//        if(last)io.DataInRe #= 0
//        if(last)io.DataInIm #= 0
        io.DataInEnable #= true
        io.DataInRe.randomize()
        io.DataInIm.randomize()
        clockDomain.waitSampling()
        io.DataInEnable #= false
        clockDomain.waitSampling(7)
      }
      def input(num: Int) = {
        for(i <- 0 until(num)){
          inputOne(i==num-1)
          //          if(i != num-1)clockDomain.waitSampling(util.Random.nextInt(5))
        }
      }
      io.DataInEnable #= false
      io.DataInRe #= 0
      io.DataInIm #= 0
      io.DataInSymbol #= 0
      clockDomain.waitSampling(100)
      io.DataInSymbol #= 1
      input(64)
      for(i <- 2 to(7)){
        io.DataInSymbol #= i
        clockDomain.waitSampling(160)
        input(64)
      }
//      input(64)
//      io.DataInSymbol #= 2
//      clockDomain.waitSampling(4)
//      input(64)
//      io.DataInSymbol #= 3
//      clockDomain.waitSampling(4)
//      input(64)
//      io.DataInSymbol #= 4
//      clockDomain.waitSampling(4)
//      input(64)
//      io.DataInSymbol #= 5
//      clockDomain.waitSampling(4)
//      input(64)
//      io.DataInSymbol #= 6
//      clockDomain.waitSampling(4)
//      input(64)
//      io.DataInSymbol #= 7
//      clockDomain.waitSampling(4)
//      input(64)
      clockDomain.waitSampling(4)
      clockDomain.waitSampling(20)
      simSuccess()
    }
  }
}
