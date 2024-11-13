package spinal.demo.ofdm
import spinal.core._
import spinal.core.sim._
case class Interim_function ()extends Component{
  val io = new Bundle{
    val inputDataEn = in Bool()
    val inputDataR = in SInt(10 bits)
    val inputDataI = in SInt(10 bits)
    val inputSymbol = in UInt(8 bits)
    val outputDataEn = out Bool()
    val outputDataR = out SInt(10 bits)
    val outputDataI = out SInt(10 bits)
    val outputSymbol = out UInt(8 bits)
  }
  noIoPrefix()
  val pilots_Picking = Pilots_Picking()
  pilots_Picking.io.inputDataEn <> io.inputDataEn
  pilots_Picking.io.inputDataR  <> io.inputDataR
  pilots_Picking.io.inputDataI  <> io.inputDataI
  pilots_Picking.io.inputSymbol <> io.inputSymbol
  pilots_Picking.io.pilot.ready.set()

  val order_Rechanged = Order_Rechanged()
  order_Rechanged.io.inputDataEn <> pilots_Picking.io.outputDataEn
  order_Rechanged.io.inputDataR  <> pilots_Picking.io.outputDataR
  order_Rechanged.io.inputDataI  <> pilots_Picking.io.outputDataI
  order_Rechanged.io.inputSymbol <> pilots_Picking.io.outputSymbol

  val remove_Pilots = Remove_Pilots()
  remove_Pilots.io.inputDataEn <> order_Rechanged.io.outputDataEn
  remove_Pilots.io.inputDataR  <> order_Rechanged.io.outputDataR
  remove_Pilots.io.inputDataI  <> order_Rechanged.io.outputDataI
  remove_Pilots.io.inputSymbol <> order_Rechanged.io.outputSymbol
  remove_Pilots.io.outputDataEn <> io.outputDataEn
  remove_Pilots.io.outputDataR  <> io.outputDataR
  remove_Pilots.io.outputDataI  <> io.outputDataI
  remove_Pilots.io.outputSymbol <> io.outputSymbol
}
object Interim_function {
  def main(args: Array[String]): Unit = {
    SpinalConfig(
      targetDirectory = "verilog/ofdm",
      oneFilePerComponent = false,
      defaultConfigForClockDomains = ClockDomainConfig(resetActiveLevel = LOW)
      ).generateVerilog(Interim_function())
  }
}

object Interim_functionSim {
  def main(args: Array[String]): Unit = {
    SimConfig.withVcdWave.compile(Interim_function()).doSimUntilVoid{dut =>
      import dut._
      clockDomain.forkStimulus(10000)
      fork {
        dut.clockDomain.assertReset()
        sleep(50000)
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
      io.inputDataEn #= false
      io.inputDataR #= 0
      io.inputDataI #= 0
      io.inputSymbol #= 0
      clockDomain.waitSampling(100)
      io.inputSymbol #= 1
      input(64)
      for(i <- 2 to(7)){
        io.inputSymbol #= i
        clockDomain.waitSampling(160)
        input(64)
      }
      clockDomain.waitSampling(4)
      clockDomain.waitSampling(20)
      simSuccess()
    }
  }
}
