package spinal.demo.workSpace
import spinal.core._
import spinal.core.sim._
import spinal.lib._
import spinal.lib.bus.amba4.axis._
import spinal.lib.fsm._
case class AxisRxRateCtrl(axis: Axi4StreamConfig, txDataNumber: Int) extends Component {
  val io = new Bundle {
    val axiIn = slave(Axi4Stream(axis))
    val signalOut = master(Stream(Payload(axis)))
    val rxEnd = master(Stream(NoData))
  }
  val axiOut = Axi4Stream(axis)
  val fifo = new StreamFifoLowLatency(io.axiIn.payloadType, txDataNumber)
  io.rxEnd.valid.clear()
  io.signalOut.arbitrationFrom(axiOut)
  io.signalOut.axis := axiOut.payload
  io.signalOut.lastPiece := io.rxEnd.valid
  val fsm = new StateMachine {
    val idle = new State with EntryPoint
    val rxd = new State
    val txd = new State
    val end = new State
    fifo.io.push << io.axiIn.queueLowLatency(txDataNumber << 1).haltWhen(~(isActive(rxd) | isActive(end)))
    axiOut.translateFrom(fifo.io.pop.haltWhen(isActive(rxd)))(
      (axisOut: Axi4Stream.Axi4StreamBundle, axisIn: Axi4Stream.Axi4StreamBundle) => {
        axisOut.user.clearAll()
        axisOut.data := axisIn.data
        axiOut.last := axisIn.last
      }
    )

    idle.whenIsActive(when(io.axiIn.isNew) {
      goto(rxd)
    })
    rxd.whenIsActive {
      when(fifo.io.occupancy >= txDataNumber) {
        goto(txd)
      }
      when(io.rxEnd.ready) {
        goto(end)
      }
    }
    txd.whenIsActive(when(fifo.io.occupancy === 1) {
      axiOut.last.set()
      goto(rxd)
    }otherwise{
      when(io.rxEnd.ready) {
        goto(end)
      }
    })
    end.whenIsActive(when(fifo.io.occupancy === 1) {
      axiOut.last.set()
      io.rxEnd.valid.set()
      goto(idle)
    })
  }
}

object AxisRxRateCtrl {
  val axi4Stream = Axi4StreamConfig(
    dataWidth = 1,
    userWidth = 1,
    useLast = true,
    useUser = true
  )
  def main(args: Array[String]): Unit = {
    SpinalConfig(targetDirectory = "verilog/rtl", oneFilePerComponent = false).generateVerilog(
      AxisRxRateCtrl(axi4Stream, 68)
    )
  }
}
object AxisRxRateCtrlSim {
  import Axi4StreamToBmb._
  def main(args: Array[String]): Unit = {
    SimConfig.withVcdWave
      .compile {
        val dut = AxisRxRateCtrl(axi4Stream, 68)
        dut
      }
      .doSimUntilVoid { dut =>
        dut.clockDomain.forkStimulus(10000)
        import dut._
        fork {
          dut.clockDomain.assertReset()
          sleep(50000)
          dut.clockDomain.deassertReset()
          sleep(10000)
        }
        fork {
          //          clockDomain.waitSampling(10)
          def AddLength(length: Int, byte: Int) = {
            io.axiIn.last #= false
            io.axiIn.user #= 0
            io.axiIn.valid #= false
            io.axiIn.data #= 0
            clockDomain.waitSampling()
            for (i <- 0 until byte) {
              while (!io.axiIn.ready.toBoolean) {
                io.axiIn.valid #= false
                clockDomain.waitSamplingWhere(io.axiIn.ready.toBoolean)
              }
              clockDomain.waitSampling(6)
              io.axiIn.valid #= true
              io.axiIn.data #= (length >> i * 8) % 1024
              clockDomain.waitSampling()
              io.axiIn.valid #= false
            }
            clockDomain.waitSampling(6)
          }
          def write(
              range: Range
          ) = {
            io.axiIn.last #= false
            io.axiIn.user #= 0
            io.axiIn.valid #= true
            io.axiIn.data.randomize()
            clockDomain.waitSampling()
            io.axiIn.valid #= false
            clockDomain.waitSampling(6)
            for (arr <- range.tail) {
              while (!io.axiIn.ready.toBoolean) {
                io.axiIn.valid #= false
                clockDomain.waitSamplingWhere(io.axiIn.ready.toBoolean)
              }
              io.axiIn.valid #= true
              io.axiIn.data.randomize()
              if (arr == range.last) io.axiIn.last #= true
              clockDomain.waitSampling()
              io.axiIn.valid #= false
              if (arr == range.last) io.axiIn.last #= false
              clockDomain.waitSampling(6)
            }
            io.axiIn.last #= false
            io.axiIn.valid #= false
            clockDomain.waitSampling()
          }
          def writeLength(length: Int, byte: Int): Unit = {
            clockDomain.waitSampling(4)
            AddLength(length, byte)
            write(0 until length)
          }
          io.axiIn.valid #= false
          io.signalOut.ready #= true
          io.rxEnd.ready #= false
          clockDomain.waitSampling(20)
          for (i <- 0 until (8)) {
            writeLength(64, 4)
            clockDomain.waitSampling()
          }
          clockDomain.waitSampling(20)
          writeLength(16, 4)
          io.rxEnd.ready #= true
          clockDomain.waitSampling(20)
          clockDomain.waitSampling(800)
//                 clockDomain.waitSamplingWhere(io.rxEnd.toBoolean)
          simSuccess()
        }
//               fork {
//                 clockDomain.waitSamplingWhere(io.axiOut.valid.toBoolean)
//                 def cmdNumber(number: Int): Unit = {
//                   for (i <- 0 until (number)) {
//                     dut.io.axiOut.ready #= true
//                     dut.clockDomain.waitSampling(1)
//                     dut.io.axiOut.ready #= false
//                     dut.clockDomain.waitSampling(7)
//                   }
//                 }
//                 cmdNumber(1400)
//               }
      }
  }
}
