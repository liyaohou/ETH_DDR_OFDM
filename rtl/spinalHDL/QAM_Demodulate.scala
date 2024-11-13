package spinal.demo.ofdm
import spinal.core._
import spinal.core.sim._
import spinal.lib._
case class QAM_Demodulate ()extends Component{
  val io = new Bundle{
    val EnergyInEn = in Bool ()
    val Energy = in UInt(10 bits)
    val inputDataEn = in Bool()
    val inputDataR = in SInt(10 bits)
    val inputDataI = in SInt(10 bits)
    val inputSymbol = in UInt(8 bits)
    val outputData = master(Stream(Bits(1 bits)))
    val outputSymbol = out UInt(8 bits)
  }

  val threshold_Adjusting = Threshold_Adjusting()
  threshold_Adjusting.io.EnergyInEn <> io.EnergyInEn
  threshold_Adjusting.io.Energy <> io.Energy

  val qam16_Demapping = QAM16_Demapping()
  qam16_Demapping.io.EnergyInEn <> threshold_Adjusting.io.EnergyOutEn
  qam16_Demapping.io.EnergyPos <> threshold_Adjusting.io.EnergyPos
  qam16_Demapping.io.EnergyNeg <> threshold_Adjusting.io.EnergyNeg
  qam16_Demapping.io.inputDataEn <> io.inputDataEn
  qam16_Demapping.io.inputDataR <> io.inputDataR
  qam16_Demapping.io.inputDataI <> io.inputDataI
  qam16_Demapping.io.inputSymbol <> io.inputSymbol

  class StreamFifoQAM_Demodulate extends StreamFifo(Bits(4 bits), 64)
  val fifo = new StreamFifoQAM_Demodulate
  fifo.io.push.valid := qam16_Demapping.io.outputDataEn
  fifo.io.push.payload := qam16_Demapping.io.outDataDemod

  val streamWidth = StreamWidthAdapter(fifo.io.pop, io.outputData)

  io.outputSymbol := RegNextWhen(qam16_Demapping.io.outputSymbol, !io.outputData.fire).init(0)

}
object QAM_Demodulate {
  def main(args: Array[String]): Unit = {
    SpinalConfig(
      targetDirectory = "verilog/ofdm",
      oneFilePerComponent = false,
      defaultConfigForClockDomains = ClockDomainConfig(resetActiveLevel = LOW)
      ).generateVerilog(QAM_Demodulate())
  }
}

object QAM_DemodulateSim {
  def main(args: Array[String]): Unit = {
    SimConfig.withVcdWave.compile(QAM_Demodulate()).doSimUntilVoid{dut =>
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
        io.Energy.randomize()
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
      io.Energy #= 0
      io.inputDataEn #= false
      io.inputDataR #= 0
      io.inputDataI #= 0
      io.inputSymbol #= 0
      clockDomain.waitSampling(100)
      io.inputSymbol #= 0
      input_E(64)
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