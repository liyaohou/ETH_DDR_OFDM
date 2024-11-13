package spinal.demo.workSpace
import spinal.core._
import spinal.core.sim._
import spinal.lib._
import spinal.lib.bus.amba4.axis._
import spinal.lib.fsm._
case class AxiSMixLength(axis: Axi4StreamConfig, lengthWordNumber: Int) extends Component {

  val io = new Bundle {
    val axiIn = slave(Axi4Stream(axis))
    val length = in(Bits(lengthWordNumber * axis.dataWidth * 8 bits))
    val axiOut = master(Axi4Stream(axis))
  }
  val lengthBytes = RegNextWhen(io.length, io.axiIn.valid)
  val fifo = cloneOf(io.axiIn)
  fifo << io.axiIn.queue(lengthWordNumber * 4)
  io.axiOut.valid.clear()
  io.axiOut.payload.clearAll()
  fifo.ready.clear()
  val fsm = new StateMachine {
    val idle = new State with EntryPoint
    val head = new State
    val main = new State
    val counter = Counter(0, lengthWordNumber - 1)

    idle.whenIsActive(when(fifo.valid & io.axiOut.ready) { goto(head) })
    head.whenIsActive(when(counter.willOverflow) { goto(main) })
    main.whenIsActive(when(io.axiOut.lastFire) { goto(idle) })

    head.onEntry(counter.clear())
    head.whenIsActive {
      counter.increment()
      io.axiOut.valid.set()
      io.axiOut.data := lengthBytes.subdivideIn(lengthWordNumber slices)(counter.value)
    }
    main.whenIsActive {
      fifo >> io.axiOut
    }
  }
}

object AxiSMixLength {
  val axi4Stream = Axi4StreamConfig(
    dataWidth = 1,
    userWidth = 1,
    useLast = true,
    useUser = true
  )
  def main(args: Array[String]): Unit = {
    SpinalConfig(targetDirectory = "verilog/rtl", oneFilePerComponent = false).generateVerilog(
      AxiSMixLength(axi4Stream, 4)
    )
  }
}

object AxiSMixLengthSim {
  import AxiSMixLength._
  def main(args: Array[String]): Unit = {
    SimConfig.withVcdWave
      .compile {
        val dut = AxiSMixLength(axi4Stream, 4)
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
          clockDomain.waitSampling(10)

          def write(
              range: Range
          ) = {
            io.axiIn.last #= false
            io.axiIn.user #= 0
            io.length #= range.length
            io.axiIn.valid #= true
            io.axiIn.data.randomize()
            clockDomain.waitSampling()
            for (arr <- range.tail) {
              while (!io.axiIn.ready.toBoolean) {
                io.axiIn.valid #= false
                clockDomain.waitSampling()
              }
              io.axiIn.valid #= true
              io.axiIn.data.randomize()
              if (arr == range.last) io.axiIn.last #= true
              clockDomain.waitSampling()
            }
            io.axiIn.last #= false
            io.axiIn.valid #= false
            clockDomain.waitSampling()
          }

          io.axiOut.ready #= true
          write(0 to 1023)
          write(0 to 1023)
          write(0 to 67)
          clockDomain.waitSampling(100)
          simSuccess()
        }
      }
  }
}
