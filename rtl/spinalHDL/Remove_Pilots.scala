package spinal.demo.ofdm
import spinal.core._
import spinal.core.sim._
import spinal.lib._
case class Remove_Pilots ()extends Component{
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
  class Context extends Bundle {
    val Re = SInt(10 bits)
    val Im = SInt(10 bits)
//    val Symbol = UInt(8 bits)
  }
  val inputFlow = Flow(new Context)
  inputFlow.valid := io.inputDataEn
  inputFlow.Re := io.inputDataR
  inputFlow.Im := io.inputDataI
//  inputFlow.Symbol := io.inputSymbol
  class DataInStreamFifoRemove_Pilots extends StreamFifo(new Context, 64)
  val fifo = new DataInStreamFifoRemove_Pilots
  val inputStream = inputFlow.toStream
  val addr = Reg(UInt(6 bits)).init(0)
  val hit = (addr <= 5)##(addr === 11)##(addr === 25)##(addr === 32)##(addr === 39)##(addr === 53)##(addr >= 59)
    fifo.io.push << inputStream.throwWhen(hit.orR)
    when(inputStream.fire){
      addr := addr + 1
    }otherwise()
    fifo.io.pop.ready.set()
    io.outputDataEn := RegNext(fifo.io.pop.valid).init(False)
    io.outputDataR := RegNext(fifo.io.pop.Re).init(0)
    io.outputDataI := RegNext(fifo.io.pop.Im).init(0)
    io.outputSymbol := RegNextWhen(io.inputSymbol, addr === 0).init(0)
}

case class EnergyRemove_Pilots ()extends Component{
  val io = new Bundle{
    val EnergyInEn = in Bool ()
    val EnergyIn = in UInt(10 bits)
    val EnergyOutEn = out Bool ()
    val EnergyOut = out UInt(10 bits)
  }
  noIoPrefix()
  class Context extends Bundle {
    val Energy = cloneOf(io.EnergyIn)
  }
  val inputFlow = Flow(new Context)
  inputFlow.valid := io.EnergyInEn
  inputFlow.Energy := io.EnergyIn
  class EnergyStreamFifoRemove_Pilots extends StreamFifo(new Context, 64)
  val fifo = new EnergyStreamFifoRemove_Pilots
  val inputStream = inputFlow.toStream
  val addr = Reg(UInt(6 bits)).init(0)
  val hit = (addr <= 5)##(addr === 11)##(addr === 25)##(addr === 32)##(addr === 39)##(addr === 53)##(addr >= 59)
  fifo.io.push << inputStream.throwWhen(hit.orR)
  when(inputStream.fire){
    addr := addr + 1
  }otherwise()
  fifo.io.pop.ready.set()
  io.EnergyOutEn := RegNext(fifo.io.pop.valid).init(False)
  io.EnergyOut := RegNext(fifo.io.pop.Energy).init(0)
}
object Remove_Pilots {
  def main(args: Array[String]): Unit = {
    SpinalConfig(
      targetDirectory = "verilog/ofdm",
      oneFilePerComponent = false,
      defaultConfigForClockDomains = ClockDomainConfig(resetActiveLevel = LOW)
      ).generateVerilog(Remove_Pilots())
  }
}

object Remove_PilotsSim {
  def main(args: Array[String]): Unit = {
    SimConfig.withVcdWave.compile(Remove_Pilots()).doSimUntilVoid{dut =>
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