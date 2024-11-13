package spinal.demo.ofdm
import spinal.core._
import spinal.core.sim._
case class Threshold_Adjusting ()extends Component{
  val io = new Bundle{
    val EnergyInEn = in Bool ()
    val Energy = in UInt(10 bits)
    val EnergyOutEn = out Bool ()
    val EnergyPos = out SInt(14 bits)
    val EnergyNeg = out SInt(14 bits)
  }
  noIoPrefix()
  val energyOrder_Rechanged = EnergyOrder_Rechanged()
  energyOrder_Rechanged.io.EnergyInEn := RegNext(io.EnergyInEn).init(False)
  energyOrder_Rechanged.io.EnergyIn := io.Energy

  val energyRemove_Pilots = EnergyRemove_Pilots()
  energyRemove_Pilots.io.EnergyInEn := energyOrder_Rechanged.io.EnergyOutEn
  energyRemove_Pilots.io.EnergyIn := energyOrder_Rechanged.io.EnergyOut
  val TempEn = energyRemove_Pilots.io.EnergyOutEn
  val EnergyPos_2 = energyRemove_Pilots.io.EnergyOut >> 1
  val EnergyPos_8 = energyRemove_Pilots.io.EnergyOut >> 3
  val TempPos = (EnergyPos_2 + EnergyPos_8).resize(widthOf(io.EnergyPos)).asSInt
  val TempNeg = -TempPos
  io.EnergyOutEn := RegNext(TempEn).init(False)
  io.EnergyPos := RegNext(TempPos).init(0)
  io.EnergyNeg := RegNext(TempNeg).init(0)
}
object Threshold_Adjusting {
  def main(args: Array[String]): Unit = {
    SpinalConfig(
      targetDirectory = "verilog/ofdm",
      oneFilePerComponent = false,
      defaultConfigForClockDomains = ClockDomainConfig(resetActiveLevel = LOW)
      ).generateVerilog(Threshold_Adjusting())
  }
}
object Threshold_AdjustingSim {
  def main(args: Array[String]): Unit = {
    SimConfig.withVcdWave.compile(Threshold_Adjusting()).doSimUntilVoid{dut =>
      import dut._
      clockDomain.forkStimulus(10000)
      fork {
        dut.clockDomain.assertReset()
        sleep(500000)
        dut.clockDomain.deassertReset()
        sleep(10000)
      }
      def inputOne(last: Boolean) = {
        io.EnergyInEn #= true
        io.Energy.randomize()
        clockDomain.waitSampling()
        io.EnergyInEn #= false
        clockDomain.waitSampling(7)
      }
      def input(num: Int) = {
        for(i <- 0 until(num)){
          inputOne(i==num-1)
        }
      }
      io.EnergyInEn #= false
      io.Energy #= 0
      clockDomain.waitSampling(100)
      input(64)
//      for(i <- 2 to(7)){
//        clockDomain.waitSampling(160)
//        input(64)
//      }
      clockDomain.waitSampling(4)
      clockDomain.waitSampling(100)
      simSuccess()
    }
  }
}