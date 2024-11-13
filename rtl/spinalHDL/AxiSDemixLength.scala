package spinal.demo.workSpace
import spinal.core._
import spinal.core.sim._
import spinal.lib._
import spinal.lib.bus.amba4.axis._
import spinal.lib.fsm._
case class AxiSDemixLength(axis: Axi4StreamConfig, lengthWordNumber: Int) extends Component {

  val io = new Bundle {
    val axiIn = slave(Axi4Stream(axis))
    val length = out(Bits(lengthWordNumber * axis.dataWidth * 8 bits))
    val axiOut = master(Axi4Stream(axis))
  }
  val lengthBytes = Reg(cloneOf(io.length)).init(0)
  io.axiOut.valid.clear()
  io.axiIn.ready.set()
  io.axiOut.payload.clearAll()
  io.length.clearAll()
  val fsm = new StateMachine {
    val idle = new State with EntryPoint
    val head = new State
    val main = new State
    val counter = Counter(0, lengthWordNumber - 1)

    idle.whenIsActive(when(io.axiIn.valid & io.axiOut.ready) { goto(head) })
    head.whenIsActive(when(counter === lengthWordNumber - 2) { goto(main) })
    main.whenIsActive(when(io.axiOut.lastFire) { goto(idle) })

    head.onEntry{
      lengthBytes(counter.value * widthOf(io.axiOut.data), widthOf(io.axiOut.data) bits) := io.axiIn.data
    }
    head.whenIsActive {
      counter.increment()
      lengthBytes(counter.valueNext * widthOf(io.axiOut.data), widthOf(io.axiOut.data) bits) := io.axiIn.data
    }
    main.whenIsActive {
      io.axiIn >> io.axiOut
      io.length := lengthBytes
    }
    main.onExit(counter.clear())
  }
}

object AxiSDemixLength {
  val axi4Stream = Axi4StreamConfig(
    dataWidth = 1,
    userWidth = 1,
    useLast = true,
    useUser = true
  )
  def main(args: Array[String]): Unit = {
    SpinalConfig(targetDirectory = "verilog/rtl", oneFilePerComponent = false).generateVerilog(
      AxiSDemixLength(axi4Stream, 4)
    )
  }
}

object AxiSDemixLengthSim {
  import AxiSDemixLength._
  def main(args: Array[String]): Unit = {
    SimConfig.withVcdWave
      .compile {
        val dut = AxiSDemixLength(axi4Stream, 4)
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
