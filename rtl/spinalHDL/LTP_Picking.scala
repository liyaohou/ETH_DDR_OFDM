package spinal.demo.workSpace
import spinal.core._
import spinal.core.sim._
import spinal.lib._
import spinal.lib.bus.amba4.axis._
import spinal.lib.sim._

case class LTP_Picking() extends Component {
  val io = new Bundle {
    val DataInEnable = in Bool ()
    val DataOutEnable = out Bool ()
    val AveLongTrainingEnable = out Bool ()
    val DataInSymbol = in UInt (8 bits)
    val DataOutSymbol = out UInt (8 bits)
    val DataInRe = in SInt (8 bits)
    val DataInIm = in SInt (8 bits)
    val DataOutRe = out SInt (8 bits)
    val DataOutIm = out SInt (8 bits)
    val AveLongTrainingRe = out SInt (8 bits)
    val AveLongTrainingIm = out SInt (8 bits)
  }
  noIoPrefix()
//  ClockDomain.current.clock.setName("CLK")
//  ClockDomain.current.reset.setName("Rst_n")

  class Context extends Bundle {
    val Re = cloneOf(io.DataInRe)
    val Im = cloneOf(io.DataInIm)
  }
  val DataInStream = Stream(new Context)
  val DataInEnableNext = RegNext(io.DataInEnable).init(False)
  class DataInStreamFifoLTP_Picking extends StreamFifo(new Context, 64)
  val fifo = new DataInStreamFifoLTP_Picking
  DataInStream.valid := DataInEnableNext & io.DataInSymbol === 1
  DataInStream.Re := io.DataInRe
  DataInStream.Im := io.DataInIm

  fifo.io.push << DataInStream
  fifo.io.pop.ready := DataInEnableNext & io.DataInSymbol === 2
  io.AveLongTrainingRe.clearAll()
  io.AveLongTrainingIm.clearAll()
//  io.AveLongTrainingEnable.clear()
  when(fifo.io.pop.fire) {
    io.AveLongTrainingRe := (fifo.io.pop.Re +^ io.DataInRe).setName("ReSum") >> 1
    io.AveLongTrainingIm := (fifo.io.pop.Im +^ io.DataInIm).setName("ImSum") >> 1
  }
  io.AveLongTrainingEnable := io.DataInEnable & io.DataInSymbol === 2
//  val assignCond = io.DataInEnable & io.DataInSymbol >= 3
//  io.DataOutEnable := io.DataInEnable & io.DataInSymbol >= 3
//  io.DataOutSymbol := Mux(io.DataInSymbol >= 3, io.DataInSymbol, U(0))
//  io.DataOutRe := Mux(assignCond, io.DataInRe, S(0))
//  io.DataOutIm := Mux(assignCond, io.DataInIm, S(0))
  val assignCond = DataInEnableNext & io.DataInSymbol >= 3
  io.DataOutEnable := io.DataInEnable & io.DataInSymbol >= 3
  io.DataOutSymbol := Mux(io.DataInSymbol >= 3, io.DataInSymbol, U(0))
  io.DataOutRe := Mux(assignCond, io.DataInRe, S(0))
  io.DataOutIm := Mux(assignCond, io.DataInIm, S(0))
//  io.DataOutRe := RegNextWhen(io.DataInRe, assignCond).init(0)
//  io.DataOutIm := RegNextWhen(io.DataInIm, assignCond).init(0)
}
object LTP_Picking {
  def main(args: Array[String]): Unit = {
    SpinalConfig(
      targetDirectory = "verilog/ofdm",
      oneFilePerComponent = false,
      defaultConfigForClockDomains = ClockDomainConfig(resetActiveLevel = LOW)
    ).generateVerilog(LTP_Picking())
  }
}
object LTP_PickingSim {
  def main(args: Array[String]): Unit = {
    SimConfig.withVcdWave.compile(LTP_Picking()).doSimUntilVoid{dut =>
      import dut._
      clockDomain.forkStimulus(10000)
      def inputOne(last: Boolean) = {
        io.DataInEnable #= true
        clockDomain.waitSampling()
        if(last)io.DataInEnable #= false
        io.DataInRe.randomize()
        io.DataInIm.randomize()
        if(last)clockDomain.waitSampling()
//        io.DataInEnable #= false
        if(last)io.DataInRe #= 0
        if(last)io.DataInIm #= 0
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
      io.DataInSymbol #= 2
      clockDomain.waitSampling(4)
      input(64)
      io.DataInSymbol #= 3
      clockDomain.waitSampling(4)
      input(64)
      io.DataInSymbol #= 4
      clockDomain.waitSampling(4)
      input(64)
      io.DataInSymbol #= 5
      clockDomain.waitSampling(4)
      input(64)
      io.DataInSymbol #= 6
      clockDomain.waitSampling(4)
      input(64)
      io.DataInSymbol #= 7
      clockDomain.waitSampling(4)
      input(64)
      clockDomain.waitSampling(4)
      clockDomain.waitSampling(20)
      simSuccess()
    }
  }
}
