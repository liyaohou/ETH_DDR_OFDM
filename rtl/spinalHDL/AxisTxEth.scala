package spinal.demo.workSpace
import spinal.core._
import spinal.core.sim._
import spinal.lib._
import spinal.lib.bus.amba4.axis._
import spinal.lib.fsm._
case class AxisTxEth (axis: Axi4StreamConfig, rxDataNumber: Int)extends Component{
  val io = new Bundle {
    val txCtrl = master(Stream(NoData))
    val axiIn = slave(Axi4Stream(axis))
    val axiOut = master(Axi4Stream(axis))
    val start = in Bool ()
    val rxEnd = in Bool ()
    val txEnd = out Bool ()
  }
  val fifo = new StreamFifoLowLatency(io.axiIn.payloadType, rxDataNumber << 1)
  fifo.io.push << io.axiIn
//  val rxEndFlag = Reg(Bool()).init(False)
  val fsm = new StateMachine {
    val idle = new State with EntryPoint
    val need = new State
    val rxd = new State
    val txd = new State
    val end = new State
    fifo.io.pop.haltWhen(isActive(rxd)) >> io.axiOut
    io.txCtrl.valid.clear()
    io.txEnd.clear()
    idle.whenIsActive {
      when(io.start.rise()) {
        goto(need)
      }
    }
    need.onEntry(io.txCtrl.valid.set())
    need.whenIsActive {
      goto(rxd)
    }
    rxd.whenIsActive {
      when(io.axiIn.lastFire) { goto(txd) }
      when(io.rxEnd) { goto(end) }
    }
    txd.whenIsActive {
      when(fifo.io.occupancy === 0) { goto(need) }
      when(io.rxEnd) { goto(end) }
    }
    end.whenIsActive(when(fifo.io.pop.lastFire) {
      io.txEnd.set()
//      rxEndFlag.clear()
      goto(idle)
    })
  }
}
