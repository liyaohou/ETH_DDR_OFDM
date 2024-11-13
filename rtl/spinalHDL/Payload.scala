package spinal.demo.workSpace
import spinal.core._
import spinal.lib._
import spinal.lib.bus.amba4.axis.Axi4Stream.Axi4StreamBundle
import spinal.lib.bus.amba4.axis.Axi4StreamConfig

case class Payload (axi4s: Axi4StreamConfig) extends Bundle {
  val axis = Axi4StreamBundle(axi4s)
  val lastPiece = Bool()
}
