package spinal.demo.workSpace
import spinal.core._
import spinal.lib._
import spinal.lib.bus.amba4.axis._
case class Rgmii() extends Bundle with IMasterSlave {
  val rxc = Bool()
  val rxd = Bits(4 bits)
  val rxCtl = Bool()
  val txc = Bool()
  val txd = Bits(4 bits)
  val txCtl = Bool()
  val rstN = Bool()
  override def asMaster(): Unit = {
    in(rxc, rxd, rxCtl)
    out(txc, txd, txCtl, rstN)
  }
}
case class eth_mac_tx(axi4s: Axi4StreamConfig, lengthWidth: Int) extends BlackBox {
  val io = new Bundle {
    val logicClk = in Bool()
    val gtxClk = in Bool()
    val gtxClk90 = in Bool()
    val rstN = in Bool ()
    val rgmii = master(Rgmii())
    val port = new Bundle {
      val udp = new Bundle{
        val rx =new Bundle{
          val hdr = master(Stream(NoData()))
          val axis = master(Axi4Stream(axi4s))
          val length = out Bits (lengthWidth bits)
        }
        val tx = new Bundle{
          val hdr = slave(Stream(NoData()))
          val axis = slave(Axi4Stream(axi4s))
          val length = in Bits(lengthWidth bits)
          val destIp = in Bits(32 bits)
        }
      }
      val eth = new Bundle{
        val tx = new Bundle{
          val axis = master(Axi4Stream(axi4s))
        }
      }
    }
  }
  noIoPrefix()
//  mapClockDomain(clock = io.rgmii.rxc, reset = io.rstN, resetActiveLevel = LOW)
  private def renameIO(): Unit = {
    io.flatten.foreach(bt => {
      if (bt.getName().contains("rstN")) bt.setName(bt.getName().replace("N", "_n"))
      if (bt.getName().contains("Clk")) bt.setName(bt.getName().replace("Clk", "_clk"))
      if (bt.getName().contains("Ip")) bt.setName(bt.getName().replace("Ip", "_ip"))
      if (bt.getName().contains("Ctl")) bt.setName(bt.getName().replace("Ctl", "_ctl"))
      if (bt.getName().contains("Rx")) bt.setName(bt.getName().replace("Rx", "_rx"))
      if (bt.getName().contains("Udp")) bt.setName(bt.getName().replace("Udp", "_udp"))
    })
  }
  addPrePopTask(() => renameIO())
}

case class eth_mac_tx_r(axi4s: Axi4StreamConfig, lengthWidth: Int) extends BlackBox {
  val io = new Bundle {
    val logicClk = in Bool()
    val gtxClk = in Bool()
    val gtxClk90 = in Bool()
    val rstN = in Bool ()
    val rgmii = master(Rgmii())
    val port = new Bundle {
      val udp = new Bundle{
        val rx =new Bundle{
          val hdr = master(Stream(NoData()))
          val axis = master(Axi4Stream(axi4s))
          val length = out Bits(lengthWidth bits)
          val sourceIp = out Bits(32 bits)
        }
      }
    }
  }
  noIoPrefix()
  //  mapClockDomain(clock = io.rgmii.rxc, reset = io.rstN, resetActiveLevel = LOW)
  private def renameIO(): Unit = {
    io.flatten.foreach(bt => {
      if (bt.getName().contains("rstN")) bt.setName(bt.getName().replace("N", "_n"))
      if (bt.getName().contains("Clk")) bt.setName(bt.getName().replace("Clk", "_clk"))
      if (bt.getName().contains("Ip")) bt.setName(bt.getName().replace("Ip", "_ip"))
      if (bt.getName().contains("Ctl")) bt.setName(bt.getName().replace("Ctl", "_ctl"))
      if (bt.getName().contains("Rx")) bt.setName(bt.getName().replace("Rx", "_rx"))
      if (bt.getName().contains("Udp")) bt.setName(bt.getName().replace("Udp", "_udp"))
    })
  }
  addPrePopTask(() => renameIO())
}
case class eth_mac_tx_t(axi4s: Axi4StreamConfig, lengthWidth: Int) extends BlackBox {
  val io = new Bundle {
    val logicClk = in Bool()
    val gtxClk = in Bool()
    val gtxClk90 = in Bool()
    val rstN = in Bool ()
    val port = new Bundle {
      val udp = new Bundle{
        val tx = new Bundle{
          val hdr = slave(Stream(NoData()))
          val axis = slave(Axi4Stream(axi4s))
          val length = in Bits(lengthWidth bits)
          val destIp = in Bits(32 bits)
        }
      }
      val eth = new Bundle{
        val tx = new Bundle{
          val axis = master(Axi4Stream(axi4s))
        }
      }
    }
  }
  noIoPrefix()
  //  mapClockDomain(clock = io.rgmii.rxc, reset = io.rstN, resetActiveLevel = LOW)
  private def renameIO(): Unit = {
    io.flatten.foreach(bt => {
      if (bt.getName().contains("rstN")) bt.setName(bt.getName().replace("N", "_n"))
      if (bt.getName().contains("Clk")) bt.setName(bt.getName().replace("Clk", "_clk"))
      if (bt.getName().contains("Ip")) bt.setName(bt.getName().replace("Ip", "_ip"))
      if (bt.getName().contains("Ctl")) bt.setName(bt.getName().replace("Ctl", "_ctl"))
      if (bt.getName().contains("Rx")) bt.setName(bt.getName().replace("Rx", "_rx"))
      if (bt.getName().contains("Udp")) bt.setName(bt.getName().replace("Udp", "_udp"))
    })
  }
  addPrePopTask(() => renameIO())
}
case class eth_mac_rx(axi4s: Axi4StreamConfig, lengthWidth: Int) extends BlackBox {
  val io = new Bundle {
    val logicClk = in Bool()
    val gtxClk = in Bool()
    val gtxClk90 = in Bool()
    val rstN = in Bool ()
    val rgmii = master(Rgmii())
    val port = new Bundle {
      val udp = new Bundle{
        val rx =new Bundle{
          val hdr = master(Stream(NoData()))
          val axis = master(Axi4Stream(axi4s))
          val length = out Bits (lengthWidth bits)
        }
        val tx = new Bundle{
          val hdr = slave(Stream(NoData()))
          val axis = slave(Axi4Stream(axi4s))
          val length = in Bits(lengthWidth bits)
          val destIp = in Bits(32 bits)
        }
      }
      val eth = new Bundle{
        val rx = new Bundle{
          val hdr = master(Stream(NoData()))
          val axis = master(Axi4Stream(axi4s))
        }
      }
    }
  }
  noIoPrefix()
  mapClockDomain(clock = io.rgmii.rxc, reset = io.rstN, resetActiveLevel = LOW)
  private def renameIO(): Unit = {
    io.flatten.foreach(bt => {
      if (bt.getName().contains("rstN")) bt.setName(bt.getName().replace("N", "_n"))
      if (bt.getName().contains("Clk")) bt.setName(bt.getName().replace("Clk", "_clk"))
      if (bt.getName().contains("Ip")) bt.setName(bt.getName().replace("Ip", "_ip"))
      if (bt.getName().contains("Ctl")) bt.setName(bt.getName().replace("Ctl", "_ctl"))
      if (bt.getName().contains("Rx")) bt.setName(bt.getName().replace("Rx", "_rx"))
      if (bt.getName().contains("Udp")) bt.setName(bt.getName().replace("Udp", "_udp"))
    })
  }
  addPrePopTask(() => renameIO())
}
case class eth_mac_rx_r(axi4s: Axi4StreamConfig, lengthWidth: Int) extends BlackBox {
  val io = new Bundle {
    val logicClk = in Bool()
    val gtxClk = in Bool()
    val gtxClk90 = in Bool()
    val rstN = in Bool ()
    val port = new Bundle {
      val udp = new Bundle{
        val rx = new Bundle{
          val hdr = master(Stream(NoData()))
          val axis = master(Axi4Stream(axi4s))
          val length = out Bits(lengthWidth bits)
          val sourceIp = out Bits(32 bits)
        }
      }
      val eth = new Bundle{
        val rx = new Bundle{
          val hdr = slave(Stream(NoData))
          val axis = slave(Axi4Stream(axi4s))
        }
      }
    }
  }
  noIoPrefix()
  //  mapClockDomain(clock = io.rgmii.rxc, reset = io.rstN, resetActiveLevel = LOW)
  private def renameIO(): Unit = {
    io.flatten.foreach(bt => {
      if (bt.getName().contains("rstN")) bt.setName(bt.getName().replace("N", "_n"))
      if (bt.getName().contains("Clk")) bt.setName(bt.getName().replace("Clk", "_clk"))
      if (bt.getName().contains("Ip")) bt.setName(bt.getName().replace("Ip", "_ip"))
      if (bt.getName().contains("Ctl")) bt.setName(bt.getName().replace("Ctl", "_ctl"))
      if (bt.getName().contains("Rx")) bt.setName(bt.getName().replace("Rx", "_rx"))
      if (bt.getName().contains("Udp")) bt.setName(bt.getName().replace("Udp", "_udp"))
    })
  }
  addPrePopTask(() => renameIO())
}

case class eth_mac_rx_t(axi4s: Axi4StreamConfig, lengthWidth: Int) extends BlackBox {
  val io = new Bundle {
    val logicClk = in Bool()
    val gtxClk = in Bool()
    val gtxClk90 = in Bool()
    val rstN = in Bool ()
    val rgmii = master(Rgmii())
    val port = new Bundle {
      val udp = new Bundle{
        val tx =new Bundle{
          val hdr = slave(Stream(NoData()))
          val axis = slave(Axi4Stream(axi4s))
          val length = in Bits(lengthWidth bits)
          val destIp = in Bits(32 bits)
        }
      }
    }
  }
  noIoPrefix()
  //  mapClockDomain(clock = io.rgmii.rxc, reset = io.rstN, resetActiveLevel = LOW)
  private def renameIO(): Unit = {
    io.flatten.foreach(bt => {
      if (bt.getName().contains("rstN")) bt.setName(bt.getName().replace("N", "_n"))
      if (bt.getName().contains("Clk")) bt.setName(bt.getName().replace("Clk", "_clk"))
      if (bt.getName().contains("Ip")) bt.setName(bt.getName().replace("Ip", "_ip"))
      if (bt.getName().contains("Ctl")) bt.setName(bt.getName().replace("Ctl", "_ctl"))
      if (bt.getName().contains("Rx")) bt.setName(bt.getName().replace("Rx", "_rx"))
      if (bt.getName().contains("Udp")) bt.setName(bt.getName().replace("Udp", "_udp"))
    })
  }
  addPrePopTask(() => renameIO())
}