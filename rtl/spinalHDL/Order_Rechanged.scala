package spinal.demo.ofdm
import spinal.core._
import spinal.core.sim._
import spinal.lib._
import spinal.lib.fsm._
case class Order_Rechanged ()extends Component{
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
  }
  val inputFlow = Flow(new Context)
  inputFlow.valid := io.inputDataEn
  inputFlow.Re := io.inputDataR
  inputFlow.Im := io.inputDataI
  class DataInStreamFifoOrder_Rechanged extends StreamFifo(new Context, 64)
  val fifoFront = new DataInStreamFifoOrder_Rechanged
  val fifoBehind = new DataInStreamFifoOrder_Rechanged
  val inputStream = inputFlow.toStream
  val wrAddr = Counter(0 until(64)).init(0)
  val rdAddr = Counter(0 until(64)).init(0)

  val behindWr = inputStream.valid & wrAddr >= 32
  val frontWr  = inputStream.valid & wrAddr < 32
  val dMux = OHToUInt(Vec(frontWr, behindWr))
  val streamDmux = StreamDemux(inputStream, dMux, 2)
  fifoFront.io.push << streamDmux(0)
  fifoBehind.io.push << streamDmux(1)
  when(inputStream.fire){
    wrAddr.increment()
  }otherwise()

  val behindRd = rdAddr < 32
  val frontRd  = !behindRd
  val mux = OHToUInt(Vec(behindRd,frontRd))
  val streamMux = StreamMux(mux,Vec(fifoBehind.io.pop, fifoFront.io.pop))
  when(streamMux.fire){
    rdAddr.increment()
  }
  streamMux.ready.set()
  io.outputDataEn := RegNext(streamMux.valid).init(False)
  io.outputDataR := RegNext(streamMux.Re).init(0)
  io.outputDataI := RegNext(streamMux.Im).init(0)
  io.outputSymbol := RegNextWhen(io.inputSymbol, rdAddr === 0).init(0)
}


case class EnergyOrder_Rechanged ()extends Component{
  val io = new Bundle{
    val EnergyInEn = in Bool()
    val EnergyIn = in UInt(10 bits)
    val EnergyOutEn = out Bool()
    val EnergyOut = out UInt(10 bits)
  }
  noIoPrefix()
  class Context extends Bundle {
    val Energy = cloneOf(io.EnergyIn)
  }
  val inputFlow = Flow(new Context)
  inputFlow.valid := io.EnergyInEn
  inputFlow.Energy := io.EnergyIn
  class EnergyStreamFifoOrder_Rechanged extends StreamFifo(new Context, 64)
  val fifoFront = new EnergyStreamFifoOrder_Rechanged
  val fifoBehind = new EnergyStreamFifoOrder_Rechanged
  val inputStream = inputFlow.toStream
  val wrAddr = Counter(0 until(64)).init(0)
  val rdAddr = Counter(0 until(64)).init(0)

  val behindWr = inputStream.valid & wrAddr >= 32
  val frontWr  = inputStream.valid & wrAddr < 32
  val dMux = OHToUInt(Vec(frontWr, behindWr))
  val streamDmux = StreamDemux(inputStream, dMux, 2)
  fifoFront.io.push << streamDmux(0)
  fifoBehind.io.push << streamDmux(1)
  when(inputStream.fire){
    wrAddr.increment()
  }otherwise()

  val behindRd = rdAddr < 32
  val frontRd  = !behindRd
  val mux = OHToUInt(Vec(behindRd,frontRd))
  val streamMux = StreamMux(mux,Vec(fifoBehind.io.pop, fifoFront.io.pop))
  when(streamMux.fire){
    rdAddr.increment()
  }
  streamMux.ready.set()
  io.EnergyOutEn := RegNext(streamMux.valid).init(False)
  io.EnergyOut := RegNext(streamMux.Energy).init(0)
}
object Order_Rechanged {
  def main(args: Array[String]): Unit = {
    SpinalConfig(
      targetDirectory = "verilog/ofdm",
      oneFilePerComponent = false,
      defaultConfigForClockDomains = ClockDomainConfig(resetActiveLevel = LOW)
      ).generateVerilog(Order_Rechanged())
  }
}

object Order_RechangedSim {
  def main(args: Array[String]): Unit = {
    SimConfig.withVcdWave.compile(Order_Rechanged()).doSimUntilVoid{dut =>
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

