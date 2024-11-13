package spinal.demo.workSpace
import spinal.core._
import spinal.core.sim._
import spinal.lib._
import spinal.lib.bus.amba4.axis._
import spinal.lib.fsm._
case class AxisTxRateCtrl(axis: Axi4StreamConfig, rxDataNumber: Int) extends Component {

  val io = new Bundle {
    val txCtrl = master(Stream(NoData))
    val axiIn = slave(Axi4Stream(axis))
    val axiOut = master(Axi4Stream(axis))
    val config = master(Stream(NoData()))
    val cfgStart = out Bool ()
    val start = in Bool ()
    val rxEnd = in Bool ()
    val txEnd = out Bool ()
  }
  val cfgStart = Reg(Bool()).init(False)
//  io.cfgStart := cfgStart
  io.cfgStart.clear()
  io.config.valid.clear()
  val fifo = new StreamFifoLowLatency(io.axiIn.payloadType, rxDataNumber << 1)
  fifo.io.push << io.axiIn
  val rxEndFlag = Reg(Bool()).init(False)
  val fsm = new StateMachine {
    val idle = new State with EntryPoint
    val cfg = new State
    val need = new State
    val rxd = new State
    val txd = new State
    val end = new State
    val cfgFlag = Reg(Bool()).init(False)
    fifo.io.pop.haltWhen(isActive(rxd) | isActive(need) | isActive(cfg)) >> io.axiOut
    io.txCtrl.valid.clear()
    io.txEnd.clear()
    idle.whenIsActive {
      when(io.start.rise()) {
        goto(need)
        cfgFlag.set()
      }
    }
    cfg.onEntry(io.cfgStart.set())
    cfg.whenIsActive {
      io.config.valid.set()
      when(io.config.ready) {
        goto(txd)
      }
    }
    need.onEntry(io.txCtrl.valid.set())
    need.whenIsActive {
      when(RegNext(isExiting(idle))) {
        goto(rxd)
      } otherwise {
        when(fifo.io.push.lastFire) {
          when(cfgFlag){
            goto(cfg)
            cfgFlag.clear()
          }otherwise {
            goto(txd)
          }
        }
      }
      rxEndFlag.setWhen(io.rxEnd)
    }
    rxd.whenIsActive {
      when(fifo.io.occupancy >= rxDataNumber) { goto(need) }
    }
    txd.whenIsActive {
      when(fifo.io.occupancy <= rxDataNumber) { goto(need) }
      when(io.rxEnd | rxEndFlag) { goto(end) }
    }
    end.whenIsActive(when(fifo.io.occupancy === 0) {
      io.txEnd.set()
      cfgStart.clear()
      rxEndFlag.clear()
      goto(idle)
    })
  }
}

object AxisTxRateCtrl {
  val axi4Stream = Axi4StreamConfig(
    dataWidth = 1,
    userWidth = 1,
    useLast = true,
    useUser = true
  )
  def main(args: Array[String]): Unit = {
    SpinalConfig(targetDirectory = "verilog/rtl", oneFilePerComponent = false).generateVerilog(
      AxisTxRateCtrl(axi4Stream, 68)
    )
  }
}

object AxisTxRateCtrlSim {
  import Axi4StreamToBmb._
  def main(args: Array[String]): Unit = {
    SimConfig.withVcdWave
      .compile {
        val dut = AxisTxRateCtrl(axi4Stream, 68)
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
                clockDomain.waitSampling()
              }
              clockDomain.waitSampling()
              io.axiIn.valid #= true
              io.axiIn.data #= (length >> i * 8) % 1024
            }
            clockDomain.waitSampling()
          }
          def write(
              range: Range
          ) = {
            io.axiIn.last #= false
            io.axiIn.user #= 0
            //            io.axiLengthIn #= range.length
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
          def writeLength(length: Int, byte: Int): Unit = {
            if (!io.txCtrl.valid.toBoolean) {
              clockDomain.waitSamplingWhere(io.txCtrl.valid.toBoolean)
            }
            clockDomain.waitSampling(4)
            AddLength(length, byte)
            write(0 until length)
          }
          io.axiIn.valid #= false
          io.axiOut.ready #= true
          io.start #= false
          io.txCtrl.ready #= false
          io.rxEnd #= false
          clockDomain.waitSampling(20)
          io.start #= true
          io.txCtrl.ready #= true
          for (i <- 0 until (8)) {
            writeLength(64, 4)
          }
          clockDomain.waitSampling(20)
          writeLength(16, 4)
          io.rxEnd #= true
          clockDomain.waitSampling(20)
//          clockDomain.waitSampling(800)
          clockDomain.waitSamplingWhere(io.txEnd.toBoolean)
          simSuccess()
        }
        fork {
          clockDomain.waitSamplingWhere(io.axiOut.valid.toBoolean)
          def cmdNumber(number: Int): Unit = {
            for (i <- 0 until (number)) {
              dut.io.axiOut.ready #= true
              dut.clockDomain.waitSampling(1)
              dut.io.axiOut.ready #= false
              dut.clockDomain.waitSampling(7)
            }
          }
          cmdNumber(1400)
        }
      }
  }
}
