package spinal.demo.ofdm
import spinal.core._
import spinal.lib._
case class Decode ()extends BlackBox{
  val io = new Bundle{
    val clk = in Bool()
    val rst_n = in Bool()
    val deintv2 = slave(Stream(Bits(1 bits)))
    val deintv2_din_symb_cnt = in UInt(8 bits)
    val deintv2_din_Map_Type = in UInt(2 bits)
    val descram = master(Stream(Bits(1 bits)))
    val descram_dout_last = out Bool()
    val descram_dout_symb_cnt = out UInt(8 bits)
  }
  noIoPrefix()
  mapClockDomain(clock = io.clk, reset = io.rst_n , resetActiveLevel = LOW)
  private def renameIO(): Unit = {
    io.flatten.foreach(bt => {
      if(bt.dirString == "in") bt.setName(bt.getName().replace("valid", "din_vld"))
      if(bt.dirString == "in") bt.setName(bt.getName().replace("ready", "din_rdy"))
      if(bt.dirString == "in") bt.setName(bt.getName().replace("payload", "din").replace("_fragment", ""))
      if(bt.dirString == "out") bt.setName(bt.getName().replace("valid", "dout_vld"))
      if(bt.dirString == "out") bt.setName(bt.getName().replace("ready", "dout_rdy"))
      if(bt.dirString == "out") bt.setName(bt.getName().replace("payload", "dout").replace("_fragment", ""))
    })
  }
  addPrePopTask(() => renameIO())

}
