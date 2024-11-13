package spinal.demo.ofdm
import spinal.core._
import spinal.core.sim._
import spinal.lib._
case class Pilots_Picking ()extends Component{
  class Context extends Bundle {
    val Re = SInt(10 bits)
    val Im = SInt(10 bits)
//    val Symbol = UInt(8 bits)
  }
  class ContextWithIndex extends Bundle {
    val Re = SInt(10 bits)
    val Im = SInt(10 bits)
    val Index = UInt(4 bits)
  }
  val io = new Bundle{
    val inputDataEn = in Bool()
    val inputDataR = in SInt(10 bits)
    val inputDataI = in SInt(10 bits)
    val inputSymbol = in UInt(8 bits)
    val outputDataEn = out Bool()
    val outputDataR = out SInt(10 bits)
    val outputDataI = out SInt(10 bits)
    val outputSymbol = out UInt(8 bits)
    val pilot = master(Stream(Fragment(new ContextWithIndex)))
  }
  noIoPrefix()
  val inputFlow = Flow(new Context)
  inputFlow.valid := RegNext(io.inputDataEn).init(False)
  inputFlow.Re := io.inputDataR
  inputFlow.Im := io.inputDataI
//  inputFlow.Symbol := io.inputSymbol
  class DataInStreamFifoPilots_Picking extends StreamFifo(new Context, 64)
  val fifo = new DataInStreamFifoPilots_Picking
  val inputStream = inputFlow.toStream
  val addr = Reg(UInt(6 bits)).init(0)
  val hit = Vec((addr === 7), (addr === 21), (addr === 43), (addr === 57))
  fifo.io.push << inputStream
  when(inputStream.fire){
    addr := addr + 1
  }otherwise()
  val tempPilot = cloneOf(io.pilot)
  tempPilot.valid := hit.orR & inputStream.valid
  tempPilot.Re := inputStream.Re
  tempPilot.Im := inputStream.Im
  tempPilot.Index := hit.asBits.asUInt
  tempPilot.last := hit(3) & inputStream.valid
  tempPilot.stage() >> io.pilot
  fifo.io.pop.ready.set()
  io.outputDataEn :=  RegNext(fifo.io.pop.valid).init(False)
  io.outputDataR := RegNext(fifo.io.pop.Re).init(0)
  io.outputDataI := RegNext(fifo.io.pop.Im).init(0)
//  io.outputSymbol := RegNext(fifo.io.pop.Symbol).init(0)
  io.outputSymbol := RegNextWhen(io.inputSymbol, addr === 0).init(0)
}
object Pilots_Picking {
  def main(args: Array[String]): Unit = {
    SpinalConfig(
      targetDirectory = "verilog/ofdm",
      oneFilePerComponent = false,
      defaultConfigForClockDomains = ClockDomainConfig(resetActiveLevel = LOW)
      ).generateVerilog(Pilots_Picking())
  }
}

object Pilots_PickingSim {
  def main(args: Array[String]): Unit = {
    SimConfig.withVcdWave.compile(Pilots_Picking()).doSimUntilVoid{dut =>
      import dut._
      clockDomain.forkStimulus(10000)
      def inputOne(last: Boolean) = {
        //        io.inputDataEn #= true
        //        clockDomain.waitSampling()
        //        if(last)io.inputDataEn #= false
        //        io.inputDataR.randomize()
        //        io.inputDataI.randomize()
        //        if(last)clockDomain.waitSampling()
        //        //        io.inputDataEn #= false
        //        if(last)io.inputDataR #= 0
        //        if(last)io.inputDataI #= 0
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
          //          if(i != num-1)clockDomain.waitSampling(util.Random.nextInt(5))
        }
      }
      io.pilot.ready #= true
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
      //      io.inputSymbol #= 2
      //      clockDomain.waitSampling(160)
      //      input(64)
      //      io.inputSymbol #= 3
      //      clockDomain.waitSampling(4)
      //      input(64)
      //      io.inputSymbol #= 4
      //      clockDomain.waitSampling(4)
      //      input(64)
      //      io.inputSymbol #= 5
      //      clockDomain.waitSampling(4)
      //      input(64)
      //      io.inputSymbol #= 6
      //      clockDomain.waitSampling(4)
      //      input(64)
      //      io.inputSymbol #= 7
      //      clockDomain.waitSampling(4)
      //      input(64)
      clockDomain.waitSampling(4)
      clockDomain.waitSampling(20)
      simSuccess()
    }
  }
}