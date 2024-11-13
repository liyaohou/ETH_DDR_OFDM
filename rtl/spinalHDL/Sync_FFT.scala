package spinal.demo.ofdm
import spinal.core._
case class Sync_FFT ()extends BlackBox {
  val io = new Bundle{
    val Clk = in Bool()
    val Rst_n = in Bool()
    val bitInR = in SInt(8 bits)
    val bitInI = in SInt(8 bits)
    val fft_dout = new Bundle{
      val re = out SInt(8 bits)
      val im = out SInt(8 bits)
      val vld = out Bool()
      val index = out UInt(8 bits)
    }
    val DataSymbol = out UInt(8 bits)
  }
  noIoPrefix()
  mapClockDomain(clock = io.Clk, reset = io.Rst_n, resetActiveLevel = LOW)
  private def renameIO(): Unit = {
    io.flatten.foreach(bt => {bt.setName(bt.getName() + "_0")})
  }
  addPrePopTask(() => renameIO())
}
