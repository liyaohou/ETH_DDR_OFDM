package spinal.demo.ofdm

import spinal.core._
import spinal.core.sim._
import spinal.lib.bus.amba4.axis.{Axi4Stream, Axi4StreamConfig}
import spinal.lib._
import spinal.lib.bus.bmb._

case class StreamCC(axi4Stream: Axi4StreamConfig) extends Component {
  val io = new Bundle{
    val clk1 = in Bool()
    val clk2 = in Bool()
    val rstN1 = in Bool()
    val rstN2 = in Bool()
    val s_axis = slave(Axi4Stream(axi4Stream))
    val m_axis = master(Axi4Stream(axi4Stream))
  }
  noIoPrefix()
  val fifo = new StreamFifoCC(Axi4Stream.Axi4StreamBundle(axi4Stream), 1024, ClockDomain(io.clk1,io.rstN1,config = ClockDomainConfig(resetActiveLevel = LOW)), ClockDomain(io.clk2,io.rstN2,config = ClockDomainConfig(resetActiveLevel = LOW)))
  fifo.io.push << io.s_axis
  fifo.io.pop >> io.m_axis
}
object StreamCC {
  def main(args: Array[String]): Unit = {
    val axi4Stream = Axi4StreamConfig(
      dataWidth = 4,
      userWidth = 2,
      useLast = true,
      useUser = true
      )
    SpinalConfig(
      targetDirectory = "verilog/ofdm",
      oneFilePerComponent = false,
      defaultConfigForClockDomains = ClockDomainConfig(resetActiveLevel = LOW)
      ).generateVerilog(new StreamFifo(Axi4Stream.Axi4StreamBundle(axi4Stream), 1024))
  }
}
case class StreamSToP256() extends Component {
  val io = new Bundle{
//    val clk1 = in Bool()
//    val clk2 = in Bool()
//    val rstN1 = in Bool()
//    val rstN2 = in Bool()
    val s_axis = slave(Stream(Bits(1 bits)))
    val m_axis = master(Stream(Bits(2 bits)))
    val occupancy = out UInt(9 bits)
    val availability = out UInt(9 bits)
  }
  noIoPrefix()
  class StreamSToP256Fifo extends StreamFifo(Bits(2 bits), 256)
  val fifo = new StreamSToP256Fifo
  val adapter = StreamWidthAdapter(io.s_axis, fifo.io.push)
  io.m_axis << fifo.io.pop
  io.occupancy <> fifo.io.occupancy
  io.availability <> fifo.io.availability
}

object StreamSToP256 {
  def main(args: Array[String]): Unit = {
    val axi4Stream = Axi4StreamConfig(
      dataWidth = 2,
      userWidth = 1,
      useLast = true,
      useUser = true
      )
    SpinalConfig(
      targetDirectory = "verilog/ofdm",
      oneFilePerComponent = false,
      defaultConfigForClockDomains = ClockDomainConfig(resetActiveLevel = LOW)
      ).generateVerilog(StreamSToP256())
  }
}

object StreamSToP256Sim{
  def main(args: Array[String]): Unit = {
    SimConfig.withVcdWave.compile(StreamSToP256()).doSimUntilVoid{dut =>
      import dut._
      clockDomain.forkStimulus(10000)
      def input(len: Int): Unit = {
        for(i <- 0 until len){
          io.s_axis.valid #= true
          io.s_axis.payload.randomize()
          clockDomain.waitSampling()
          waitUntil(io.s_axis.ready.toBoolean)
          io.s_axis.valid #= false
          io.s_axis.payload #= 0
        }
      }
      io.s_axis.valid #= false
      io.s_axis.payload #= 0
      io.m_axis.ready #= false
      clockDomain.waitSampling(100)
      io.m_axis.ready #= true
      input(1024)
      clockDomain.waitSampling(100)
      simSuccess()
    }
  }
}

case class StreamPToS256() extends Component {
  val io = new Bundle{
    //    val clk1 = in Bool()
    //    val clk2 = in Bool()
    //    val rstN1 = in Bool()
    //    val rstN2 = in Bool()
    val s_axis = slave(Stream(Bits(2 bits)))
    val m_axis = master(Stream(Bits(1 bits)))
    val occupancy = out UInt(9 bits)
    val availability = out UInt(9 bits)
  }
  noIoPrefix()
  class StreamSToP256Fifo extends StreamFifo(Bits(2 bits), 256)
  val fifo = new StreamSToP256Fifo
  val adapter = StreamWidthAdapter(fifo.io.pop, io.m_axis)
  io.s_axis >> fifo.io.push
  io.occupancy <> fifo.io.occupancy
  io.availability <> fifo.io.availability
}

object StreamPToS256 {
  def main(args: Array[String]): Unit = {
    val axi4Stream = Axi4StreamConfig(
      dataWidth = 2,
      userWidth = 1,
      useLast = true,
      useUser = true
      )
    SpinalConfig(
      targetDirectory = "verilog/ofdm",
      oneFilePerComponent = false,
      defaultConfigForClockDomains = ClockDomainConfig(resetActiveLevel = LOW)
      ).generateVerilog(StreamPToS256())
  }
}

object StreamPToS256Sim{
  def main(args: Array[String]): Unit = {
    SimConfig.withVcdWave.compile(StreamPToS256()).doSimUntilVoid{dut =>
      import dut._
      clockDomain.forkStimulus(10000)
      def input(len: Int): Unit = {
        for(i <- 0 until len){
          io.s_axis.valid #= true
          io.s_axis.payload.randomize()
          clockDomain.waitSampling()
          waitUntil(io.s_axis.ready.toBoolean)
          io.s_axis.valid #= false
          io.s_axis.payload #= 0
        }
      }
      io.s_axis.valid #= false
      io.s_axis.payload #= 0
      io.m_axis.ready #= false
      clockDomain.waitSampling(100)
      io.m_axis.ready #= true
      input(1024)
      clockDomain.waitSampling(100)
      simSuccess()
    }
  }
}

object StreamDecodeFifo {
  def main(args: Array[String]): Unit = {
    val axi4Stream = Axi4StreamConfig(
      dataWidth = 2,
      userWidth = 1,
      useLast = true,
      useUser = true
      )
    SpinalConfig(
      targetDirectory = "verilog/ofdm",
      oneFilePerComponent = false,
      defaultConfigForClockDomains = ClockDomainConfig(resetActiveLevel = LOW)
      ).generateVerilog(new StreamFifo(Fragment(Bits(8 bits)), 256))
  }
}