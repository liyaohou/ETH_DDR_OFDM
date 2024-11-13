package spinal.demo.workSpace
import spinal.core._
import spinal.lib._
import spinal.lib.bus.amba4.axis.{Axi4Stream, Axi4StreamConfig}
import spinal.lib.fsm._
case class HarMatch(axis: Axi4StreamConfig) extends Component{
  val io = new Bundle{
    val hdr = master(Stream(NoData()))
    val signalIn = slave(Stream(Payload(axis)))
    val signalOut = master(Stream(Payload(axis)))
  }
  val fifo = cloneOf(io.signalIn)
  fifo << io.signalIn.queue(16)
  io.hdr.valid.clear()
  io.signalOut.valid.clear()
  io.signalOut.payload.clearAll()
  fifo.ready.clear()
  val fsm = new StateMachine {
    val idle = new State with EntryPoint
    val head = new State
    val main = new State

    idle.whenIsActive(when(fifo.valid) { goto(head) })
    head.whenIsActive(when(io.hdr.ready) { goto(main) })
    head.onExit {
      io.hdr.valid.set()
    }
    main.whenIsActive(when(io.signalOut.fire & io.signalOut.axis.last) { goto(idle) })
    main.whenIsActive {
      fifo >> io.signalOut
    }
  }
}
case class AxisHarMatch(axis: Axi4StreamConfig) extends Component{
  val io = new Bundle{
    val hdr = master(Stream(NoData()))
    val axiIn = slave(Axi4Stream(axis))
    val axiOut = master(Axi4Stream(axis))
  }
  val fifo = cloneOf(io.axiIn)
  fifo << io.axiIn.queue(16)
  io.hdr.valid.clear()
  io.axiOut.valid.clear()
  io.axiOut.payload.clearAll()
  fifo.ready.clear()
  val fsm = new StateMachine {
    val idle = new State with EntryPoint
    val head = new State
    val main = new State

    idle.whenIsActive(when(fifo.valid) { goto(head) })
    head.whenIsActive(when(io.hdr.ready) { goto(main) })
    head.onExit {
      io.hdr.valid.set()
    }
    main.whenIsActive(when(io.axiOut.lastFire) { goto(idle) })
    main.whenIsActive {
      fifo >> io.axiOut
    }
  }
}
object HarMatch {
  val axi4Stream = Axi4StreamConfig(
    dataWidth = 1,
    userWidth = 1,
    useLast = true,
    useUser = true
    )
  def main(args: Array[String]): Unit = {
    SpinalConfig(targetDirectory = "verilog/rtl", oneFilePerComponent = false).generateVerilog(
      HarMatch(axi4Stream)
      )
  }
}
