package spinal.demo.workSpace

import spinal.core._
case class pll_clk() extends BlackBox {
  val io = new Bundle {
    val resetn = in Bool ()
    val locked = out Bool ()
    val clk = new Bundle {
      val in1 = in Bool ()
      val out1 = out Bool ()
      val out2 = out Bool ()
      val out3 = out Bool ()
      val out4 = out Bool ()
      val out5 = out Bool ()
      val out6 = out Bool ()
    }
  }
  noIoPrefix()
  mapClockDomain(clock = io.clk.in1, reset = io.resetn, resetActiveLevel = LOW)
}
