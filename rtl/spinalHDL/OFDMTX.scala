package spinal.demo.workSpace
import spinal.core._
import spinal.lib._
case class ofdm_tx(configWidth: Int, dacWidth: Int, dataWidth: Int) extends BlackBox {

  val io = new Bundle {
    val clk_125m = in Bool()
    val clk_20m = in Bool()
    val rstN = in Bool()
    val mcu = new Bundle {
      val config = slave(Stream(Bits(configWidth bits)))
      val configStart = in Bool()
      val mac = slave(Stream(Bits(dataWidth bits)))
    }
    val dac = master(Stream(Fragment(Bits(dacWidth bits))))
    val dacIndex = out Bits(9 bits)
    val txEnd = in Bool()
  }
//  io.rstN.setName("locked")
  io.dacIndex.setName("dac_dout_Index")
  io.mcu.configStart.setName("mcu_config_din_start")
//  io.dacClk.setName("dac_clk")
//  io.dacData.setName("dac_data")
  noIoPrefix()
  mapClockDomain(clock = io.clk_125m, reset = io.rstN.setName("locked") , resetActiveLevel = LOW)
  private def renameIO(): Unit = {
    io.flatten.foreach(bt => {
//      if (bt.getName().contains("rstN")) bt.setName(bt.getName().replace("N", "_n"))
      if (bt.getName().contains("End")) bt.setName(bt.getName().replace("End", "_end"))
//      if (bt.getName().contains("Start")) bt.setName(bt.getName().replace("Start", "_start"))
      if (bt.getName().contains("Flag")) bt.setName(bt.getName().replace("Flag", "_flag"))
      if (bt.getName().contains("Udp")) bt.setName(bt.getName().replace("Udp", "_udp"))
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
