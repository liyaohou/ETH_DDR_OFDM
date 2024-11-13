package spinal.demo.workSpace
import spinal.core._
import spinal.core.sim._
import spinal.lib._
import spinal.lib.bus.bmb._
import spinal.lib.fsm.{EntryPoint, State, StateMachine}
case class BmbRdCmdGen(bmbp: BmbParameter, brustLength: Int) extends Component {

  val io = new Bundle {
    val start = in Bool ()
    val handShake = slave(Stream(NoData()))
    val address = in UInt(bmbp.access.addressWidth bits)
    val length = out UInt(log2Up(brustLength) bits)
    val bmbCmd = master(Stream(Fragment(BmbCmd(bmbp))))
    val end = out Bool ()
  }
  io.bmbCmd.valid.clear()
  io.bmbCmd.last.clear()
  io.bmbCmd.source.clearAll()
  io.bmbCmd.opcode.setAll()
  io.bmbCmd.address.clearAll()
  io.bmbCmd.length.clearAll()
  io.bmbCmd.data.clearAll()
  io.bmbCmd.mask.clearAll()
  io.bmbCmd.context.clearAll()

  val start = Reg(Bool()).init(False).clearWhen(io.end).setWhen(io.start)
  val pipeline = Stream(NoData())
  val lengthReg = Reg(cloneOf(io.length)).init(0).addTag(crossClockDomain)
  io.length := lengthReg
  val counter = Counter(0, (1 << bmbp.access.addressWidth) / brustLength)
  pipeline << io.handShake.m2sPipe()
  pipeline.ready.clear()
  val addressBridge = io.address + UInt(log2Up(brustLength) bits).getAllTrue
  io.end.clear()
  when(start) {
    val fsm = new StateMachine {
      def read(state: State, nextState: State): Unit = {
        state.whenIsActive {
          when(counter.value.resized === addressBridge >> log2Up(brustLength)) {
              goto(end)
          } otherwise {
            when(pipeline.valid) {
              goto(nextState)
            }
          }
        }
        state.onExit {
          when(~isEntering(end)){
            io.bmbCmd.opcode := False.asBits
            io.bmbCmd.last.set()
            io.bmbCmd.valid.set()
            pipeline.ready.set()
            counter.increment()
            io.bmbCmd.address := (counter.value << log2Up(brustLength)).resized
            lengthReg := io.bmbCmd.length.resized
            when(counter.valueNext.resized === addressBridge >> log2Up(brustLength)) {
              io.bmbCmd.length := (io.address(log2Up(brustLength) - 1 downto (0)) - 1).resized
            } otherwise {
              io.bmbCmd.length := brustLength - 1
            }
          }
        }
      }
      val idle = new State with EntryPoint
      val task1 = new State
      val task2 = new State
      val end = new State

      idle.whenIsActive(when(start) { goto(task1) })
      read(task1, task2)
      read(task2, task1)
      end.whenIsActive {
        io.end.set()
        counter.clear()
        goto(idle)
      }
    }
  }
}
object BmbRdCmdGen {
  val bmbParameter = BmbParameter(
    addressWidth = 29,
    dataWidth = 32,
    sourceWidth = 0,
    contextWidth = 4,
    lengthWidth = 10,
    alignment = BmbParameter.BurstAlignement.BYTE
  )
  def main(args: Array[String]): Unit = {
    SpinalConfig(targetDirectory = "verilog/rtl", oneFilePerComponent = false).generateVerilog(
      BmbRdCmdGen(bmbParameter, 1024)
      )
  }
}
object BmbRdCmdGenSim {
  import BmbRdCmdGen._
  def main(args: Array[String]): Unit = {
    SimConfig.withVcdWave
      .compile {
        val dut = BmbRdCmdGen(bmbParameter, 1024)
        dut
      }
      .doSimUntilVoid { dut =>
        dut.clockDomain.forkStimulus(10000)

        fork {
          dut.clockDomain.assertReset()
          sleep(50000)
          dut.clockDomain.deassertReset()
          sleep(10000)
        }
        fork {
          def cmdNumber(number: Int): Unit = {
            for (i <- 0 until (number)) {
              dut.io.handShake.valid #= true
              dut.clockDomain.waitSampling()
              dut.io.handShake.valid #= false
              dut.clockDomain.waitSampling(10)
            }
          }

          dut.io.start #= false
          dut.io.handShake.valid #= false
          dut.io.bmbCmd.ready #= false
          dut.io.address #= 0
          dut.clockDomain.waitSampling(10)
          dut.io.start #= true
          dut.io.bmbCmd.ready #= true
          dut.io.address #= 1024 * 6 + 512 + 16
          dut.clockDomain.waitSampling(10)
          dut.io.start #= false
          cmdNumber(50)
//          dut.clockDomain.waitSampling(100)
//          simSuccess()

        }
        fork {
          dut.clockDomain.waitSamplingWhere(dut.io.end.toBoolean)
          dut.clockDomain.waitSampling(100)
          simSuccess()
        }
      }
  }
}
