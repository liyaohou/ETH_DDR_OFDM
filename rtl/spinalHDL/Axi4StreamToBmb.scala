package spinal.demo.workSpace
import spinal.core._
import spinal.core.sim._
import spinal.lib._
import spinal.lib.bus.amba4.axis._
import spinal.lib.bus.bmb._

import scala.collection.mutable
import scala.util.control.Breaks

case class Axi4StreamToBmb(
    tx_rx: Boolean,
    axis: Axi4StreamConfig,
    bmbp: BmbParameter,
    wrLength: Int,
    rdLength: Int,
    bmbClockDomain: ClockDomain
) extends Component {

  val io = new Bundle {
    val axiIn = slave(Axi4Stream(axis))
    val signalOut = master(Stream(Payload(axis)))
    val rdCtr = slave(Stream(NoData))
    val writeEnd = master(Stream(NoData))
    val bmb = master(Bmb(bmbp))
    val error = out Bool ()
    val lengthIn = in Bits (bmbp.access.lengthWidth bits)
    val lengthOut = out Bits (bmbp.access.lengthWidth bits)
  }
  val bmbBridgeParameter = BmbParameter(
    addressWidth = bmbp.access.addressWidth,
    dataWidth = axis.dataWidth * 8,
    sourceWidth = bmbp.access.sourceWidth,
    contextWidth = bmbp.access.contextWidth - 4,
    lengthWidth = bmbp.access.lengthWidth,
    alignment = bmbp.access.alignment
  )
  val axiOut = Axi4Stream(axis)
  val readEnd = out Bool ()
  val axisToBmbBridge = new Area {
    val bmbBridge = Bmb(bmbBridgeParameter)
    val cmd = new Area {
      val bmbAddr = Reg(cloneOf(io.bmb.cmd.address)).init(0).addTag(crossClockDomain)
      when(readEnd.rise()) { bmbAddr.clearAll() }
      val fifo = Axi4Stream(axis)
      fifo << io.axiIn.queueLowLatency(wrLength / 4)
      when(fifo.lastFire) {
        bmbAddr := bmbAddr + (io.lengthIn.asUInt +^ 1).resized
      }
      val translate = (bmbCmd: Fragment[BmbCmd], axis: Axi4Stream.Axi4StreamBundle) => {
        bmbCmd.data := axis.data
        bmbCmd.last := axis.last
        bmbCmd.length := io.lengthIn.asUInt.resized
        bmbCmd.address := bmbAddr
        bmbCmd.mask := 0
        bmbCmd.opcode := 1
      }
      bmbBridge.cmd.translateFrom(fifo)(translate)
      val error = RegInit(False).setWhen(fifo.lastFire & fifo.user.asBool)
      io.error := error
    }
    val rsp = new Area {
      val lastCounter = Counter(0 until rdLength)
      val tailCounter = Counter(0 until (1 << bmbp.access.addressWidth) / rdLength)
      when(lastCounter.willOverflow) { tailCounter.increment() }
      when(readEnd.rise()) {
        lastCounter.clear()
        tailCounter.clear()
      }
      val fifo = Axi4Stream(axis)
      val translate = (axis: Axi4Stream.Axi4StreamBundle, bmbRsp: Fragment[BmbRsp]) => {
        axis.user.clearAll()
        axis.data := bmbRsp.data
        axis.last := lastCounter.willOverflow || ((tailCounter.value << log2Up(
          rdLength
        )) + lastCounter.value === cmd.bmbAddr - 1)
      }
      when(fifo.fire) { lastCounter.increment() }
      fifo.translateFrom(bmbBridge.rsp)(translate)
    }
  }

  axiOut << axisToBmbBridge.rsp.fifo
  val adapter = new Area {
    val endFlag = Reg(Bool()).init(False)
    val widthMatch = axisToBmbBridge.bmbBridge.resize(bmbp.access.dataWidth)
    val bmbCCDomain = BmbCcFifo(bmbp, wrLength, rdLength, ClockDomain.current, bmbClockDomain)
    val headCCDomain = new StreamCCByToggle(NoData(), ClockDomain.current, bmbClockDomain)
    val writeEndHistory = History(io.writeEnd.ready, 4).orR
//    val readFlag1 = Reg(Bool()).init(False).setWhen(io.writeEnd.ready).clearWhen(io.readEnd).addTag(crossClockDomain)
    val bmbClockArea = new ClockingArea(bmbClockDomain) {
      val BmbMux = Reg(Bool()).init(False)
      val bmbRdGen = BmbRdCmdGen(bmbp, rdLength)
      bmbRdGen.io.start := BmbMux.rise()
      bmbRdGen.io.address := axisToBmbBridge.cmd.bmbAddr
      Mux(BmbMux, bmbRdGen.io.bmbCmd, bmbCCDomain.io.output.cmd) >> io.bmb.cmd
      if (tx_rx) { BmbMux.setWhen(BufferCC(writeEndHistory)).clearWhen(bmbRdGen.io.end) }
      else {
        BmbMux
          .setWhen(
            Reg(Bool())
              .setWhen(BufferCC(writeEndHistory))
              .clearWhen(bmbRdGen.io.end) & bmbCCDomain.io.output.cmd.lastFire
          )
          .clearWhen(bmbRdGen.io.end)
      }
      bmbRdGen.io.bmbCmd.ready := io.bmb.cmd.ready
      bmbCCDomain.io.output.cmd.ready := io.bmb.cmd.ready
      bmbCCDomain.io.output.rsp.translateFrom(io.bmb.rsp)((bmbOut: Fragment[BmbRsp], bmbIn: Fragment[BmbRsp]) => {
        bmbOut.last.clear()
        bmbOut.fragment := bmbIn.fragment
      })
      headCCDomain.io.output >> bmbRdGen.io.handShake
    }
    io.writeEnd.valid := BufferCC(bmbClockArea.BmbMux, init = False).rise()
    endFlag.setWhen(BufferCC(bmbClockArea.bmbRdGen.io.end, init = False)).clearWhen(readEnd)
    readEnd := endFlag & axiOut.lastFire

    headCCDomain.io.input << io.rdCtr
    bmbCCDomain.io.input << widthMatch.pipelined(rspValid = true, rspReady = true)
//    mixLength.axisMixLength.io.length := bmbClockArea.bmbRdGen.io.length.asBits.resized
    io.lengthOut := bmbClockArea.bmbRdGen.io.length.asBits.resized
  }
  io.signalOut.arbitrationFrom(axiOut)
  io.signalOut.axis := axiOut.payload
  io.signalOut.lastPiece := readEnd
}

object Axi4StreamToBmb {
  val axi4Stream = Axi4StreamConfig(
    dataWidth = 1,
    userWidth = 1,
    useLast = true,
    useUser = true
  )
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
      Axi4StreamToBmbVerilog(axi4Stream, bmbParameter, 1024, 64)
    )
  }

  case class Axi4StreamToBmbVerilog(axis: Axi4StreamConfig, bmbp: BmbParameter, wrLength: Int, rdLength: Int)
      extends Component {
    val io = new Bundle {
      val bmbClk = in Bool ()
      val bmbRstN = in Bool ()
      val axiIn = slave(Axi4Stream(axis))
      val signalOut = master(Stream(Payload(axis)))
      val rdCtr = slave(Stream(NoData))
      val writeEnd = master(Stream(NoData))
      val bmb = master(Bmb(bmbp))
      val error = out Bool ()
      val lengthIn = in Bits (bmbp.access.lengthWidth bits)
      val lengthOut = out Bits (bmbp.access.lengthWidth bits)
    }

    val bmbClockDomain = ClockDomain(
      clock = io.bmbClk,
      reset = io.bmbRstN,
      config = ClockDomainConfig(resetActiveLevel = LOW)
    )

    val axi4StreamToBmb = Axi4StreamToBmb(true, axis, bmbp, wrLength, rdLength, bmbClockDomain)
    axi4StreamToBmb.io.axiIn <> io.axiIn
    axi4StreamToBmb.io.signalOut <> io.signalOut
    axi4StreamToBmb.io.rdCtr <> io.rdCtr
    axi4StreamToBmb.io.writeEnd <> io.writeEnd
    axi4StreamToBmb.io.bmb <> io.bmb
    axi4StreamToBmb.io.error <> io.error
    axi4StreamToBmb.io.lengthIn <> io.lengthIn
    axi4StreamToBmb.io.lengthOut <> io.lengthOut
  }
}

object Axi4StreamToBmbSim {
  import Axi4StreamToBmb._
  def main(args: Array[String]): Unit = {
    SimConfig.withVcdWave
      .compile {
        val dut = Axi4StreamToBmbVerilog(axi4Stream, bmbParameter, 1024, 64)
        dut
      }
      .doSimUntilVoid { dut =>
        import dut._
        fork {
          while (true) {
            dut.clockDomain.clockToggle()
            sleep(10000)
          }
        }
        fork {
          while (true) {
            io.bmbClk #= !io.bmbClk.toBoolean
            sleep(40000)
          }
        }
        fork {
          io.bmbClk #= true
          dut.clockDomain.risingEdge()
          dut.clockDomain.assertReset()
          io.bmbRstN #= false
          sleep(200000)
          dut.clockDomain.deassertReset()
          io.bmbRstN #= true
        }

//        fork {
//
//          dut.clockDomain.assertReset()
//          io.bmbRstN #= false
//          sleep(80000)
//          dut.clockDomain.deassertReset()
//          io.bmbRstN #= true
//        }
        val dataQueue = mutable.Queue[BigInt]()
        fork {
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
              dataQueue.enqueue(io.axiIn.data.toInt)
              if (arr == range.last) io.axiIn.last #= true
              clockDomain.waitSampling()
//              dataQueue.enqueue(io.axiIn.data.toBigInt)
            }
            dataQueue.enqueue(io.axiIn.data.toInt)
            io.axiIn.last #= false
            io.axiIn.valid #= false
            clockDomain.waitSampling()
          }
          def writeLength(length: Int, byte: Int): Unit = {
//            AddLength(length, byte)
            io.lengthIn #= length - 1
            write(0 until length)
          }

          io.bmb.cmd.ready #= true
          io.bmb.rsp.context #= 0
          io.writeEnd.ready #= false
          io.rdCtr.valid #= false
          clockDomain.waitSampling(100)
          clockDomain.waitSampling(10)
          for (i <- 0 until (4)) {
            writeLength(1024, 4)
            clockDomain.waitSampling(100)
          }
          writeLength(128, 4)
          io.writeEnd.ready #= true
          io.rdCtr.valid #= false
          clockDomain.waitSampling(20)
          def cmdNumber(number: Int): Unit = {
            Breaks.breakable {
              for (i <- 0 until (number)) {
                dut.io.rdCtr.valid #= true
                dut.clockDomain.waitSampling()
                dut.io.rdCtr.valid #= false
                dut.clockDomain.waitSampling(200)
//                dut.clockDomain.waitSamplingWhere(io.axiOut.valid.toBoolean)
//                dut.clockDomain.waitSamplingWhere(!io.axiOut.valid.toBoolean)
              }
            }
          }
          cmdNumber(66)
          clockDomain.waitSampling(1000)
          simSuccess()
        }
        fork {
          def readdata(beatCount: Int): Unit = {
            if (io.bmb.cmd.opcode.toInt == 0 & io.bmb.cmd.valid.toBoolean) {} else {
              bmbClockDomain.waitSamplingWhere(io.bmb.cmd.opcode.toInt == 0 & io.bmb.cmd.valid.toBoolean)
            }
            bmbClockDomain.waitSampling(10)
            Breaks.breakable {
              for (i <- 0 until beatCount) {
                var temp: Long = 0
                dut.io.bmb.rsp.valid #= true
                io.bmb.rsp.last #= false
                for (j <- 0 until (4)) {
                  temp = temp + (dataQueue.dequeue().toLong << (j * 8))
                  println(s"temp${j} = ${temp}")
                }
                dut.io.bmb.rsp.data #= temp
                temp = 0
                if ((i == beatCount - 1) | dataQueue.isEmpty) io.bmb.rsp.last #= false
                bmbClockDomain.waitSampling()
                io.bmb.rsp.last #= false
                if (dataQueue.isEmpty) {
                  Breaks.break()
                }
              }
            }
            dut.io.bmb.rsp.valid #= false
          }
          io.signalOut.ready #= true
          io.bmb.rsp.valid #= false
          io.bmb.rsp.opcode #= 0
          io.bmb.rsp.last #= false
          while (true) {
            bmbClockDomain.waitSamplingWhere(io.bmb.cmd.opcode.toInt == 0 & io.bmb.cmd.valid.toBoolean)
            readdata(16)
          }
        }
        fork {
//          clockDomain.waitSamplingWhere(io.readEnd.toBoolean)
//          simSuccess()
        }
      }
  }
}
