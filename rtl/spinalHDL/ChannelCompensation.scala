package spinal.demo.ofdm
import spinal.core._
import spinal.core.sim._
import spinal.lib._
case class ChannelCompensation ()extends Component{
  val io = new Bundle{
    val ChannelCoefEnable = in Bool()
    val ChannelCoefRe = in SInt(8 bits)
    val ChannelCoefIm = in SInt(8 bits)
    val DataInEnable = in Bool()
    val DataInRe = in SInt(8 bits)
    val DataInIm = in SInt(8 bits)
    val DataInSymbol = in UInt(8 bits)
    val DataOutEnable = out Bool()
    val DataOutRe = out SInt(10 bits)
    val DataOutIm = out SInt(10 bits)
    val DataOutSymbol = out UInt(8 bits)
  }
  noIoPrefix()
  class Context extends Bundle {
    val Re = cloneOf(io.DataInRe)
    val Im = cloneOf(io.DataInIm)
  }
  val DataInStream = Flow(new Context)
  class mem_ChannelCompensation extends Mem(new Context, 64)
  val mem = new mem_ChannelCompensation
  DataInStream.valid := io.ChannelCoefEnable
  DataInStream.Re := io.ChannelCoefRe
  DataInStream.Im := io.ChannelCoefIm
  val wrAddr = Reg(UInt(6 bits)).init(0)
  val rdAddr = Reg(UInt(6 bits)).init(0)
  when(RegNext(DataInStream.valid).init(False)){
    mem.write(wrAddr, DataInStream.payload)
    wrAddr := wrAddr + 1
  }otherwise()


//  fifo.io.push.valid := Mux(io.DataInSymbol.asUInt >= 3, fifo.io.pop.valid & RegNext(io.DataInEnable), DataInStream.valid)
//  fifo.io.push.payload := Mux(io.DataInSymbol.asUInt >= 3, fifo.io.pop.payload, DataInStream.payload)
//  fifo.io.pop.ready := Mux(io.DataInSymbol.asUInt >= 3, RegNext(io.DataInEnable), RegNext(io.DataInEnable))

  val TempEn1 = Bool()
  val TempA1  = Reg(SInt(widthOf(io.DataInRe) + 1 bits)).init(0)
  val TempA2  = Reg(SInt(widthOf(io.DataInRe) + 1 bits)).init(0)
  val TempB   = Reg(SInt(widthOf(io.DataInRe) + 1 bits)).init(0)
  val TempAR  = Reg(SInt(widthOf(io.DataInRe)bits)).init(0)
  val TempBR  = Reg(SInt(widthOf(io.DataInRe)bits)).init(0)
  val TempBI  = Reg(SInt(widthOf(io.DataInIm)bits)).init(0)
  val memRdRe = mem.readSync(rdAddr).Re
  val memRdIm = mem.readSync(rdAddr).Im
  when(RegNext(io.DataInEnable)){
    TempA1 := io.DataInRe +^ io.DataInIm
    TempA2 := io.DataInRe -^ io.DataInIm
    TempB  := memRdRe +^ memRdIm
    TempAR := io.DataInRe
    TempBR := memRdRe
    TempBI := memRdIm
    TempEn1.set()
  }otherwise{
    TempA1.clearAll()
    TempA2.clearAll()
    TempB.clearAll()
    TempAR.clearAll()
    TempBR.clearAll()
    TempBI.clearAll()
    TempEn1.clear()
  }
  when(io.DataInEnable){
    rdAddr := rdAddr + 1
  }otherwise()
  val TempEn2  = RegNext(TempEn1)
  val TempARB  = Reg(SInt(widthOf(TempAR) + widthOf(TempB) bits)).init(0)
  val TempA1BI = Reg(SInt(widthOf(TempA1) + widthOf(TempBI) bits)).init(0)
  val TempA2BR = Reg(SInt(widthOf(TempA2) + widthOf(TempBR) bits)).init(0)

  when(TempEn2){
    TempARB := TempAR * TempB
    TempA1BI := TempA1 * TempBI
    TempA2BR := TempA2 * TempBR
  }otherwise{
    TempARB.clearAll()
    TempA1BI.clearAll()
    TempA2BR.clearAll()
  }
  val TempEn3  = RegNext(TempEn2).init(False)
  val TempRe  = Reg(SInt(widthOf(TempARB) + 1 bits)).init(0)
  val TempIm  = Reg(SInt(widthOf(TempARB) + 1 bits)).init(0)
  when(TempEn3){
    TempRe := TempARB -^ TempA1BI
    TempIm := TempARB -^ TempA2BR
  }otherwise{
    TempRe.clearAll()
    TempIm.clearAll()
  }
  io.DataOutEnable := TempEn3
  io.DataOutRe := (TempRe(TempRe.high) ## TempRe(14 downto(6))).asSInt
  io.DataOutIm := (TempIm(TempIm.high) ## TempIm(14 downto(6))).asSInt
  io.DataOutSymbol := Delay(io.DataInSymbol, 3)
}
object ChannelCompensation {
  def main(args: Array[String]): Unit = {
    SpinalConfig(
      targetDirectory = "verilog/ofdm",
      oneFilePerComponent = false,
      defaultConfigForClockDomains = ClockDomainConfig(resetActiveLevel = LOW)
      ).generateVerilog(ChannelCompensation())
  }
}

object ChannelCompensationSim{
  def main(args: Array[String]): Unit = {
    SimConfig.withVcdWave.compile(ChannelCompensation()).doSimUntilVoid{dut =>
      import dut._
      clockDomain.forkStimulus(10000)
      def inputOne(last: Boolean) = {
        io.DataInEnable #= true
        clockDomain.waitSampling()
        if(last)io.DataInEnable #= false
        io.DataInRe.randomize()
        io.DataInIm.randomize()
        if(last)clockDomain.waitSampling()
        //        io.DataInEnable #= false
        if(last)io.DataInRe #= 0
        if(last)io.DataInIm #= 0
      }
      def input(num: Int) = {
        for(i <- 0 until(num)){
          inputOne(i==num-1)
          //          if(i != num-1)clockDomain.waitSampling(util.Random.nextInt(5))
        }
      }
      def inputOne_C(last: Boolean) = {
        io.ChannelCoefEnable #= true
        clockDomain.waitSampling()
        if(last)io.ChannelCoefEnable #= false
        io.ChannelCoefRe.randomize()
        io.ChannelCoefIm.randomize()
        if(last)clockDomain.waitSampling()
        //        io.DataInEnable #= false
        if(last)io.ChannelCoefRe #= 0
        if(last)io.ChannelCoefIm #= 0
      }
      def input_C(num: Int) = {
        for(i <- 0 until(num)){
          inputOne_C(i==num-1)
          //          if(i != num-1)clockDomain.waitSampling(util.Random.nextInt(5))
        }
      }
      io.DataInEnable #= false
      io.DataInRe #= 0
      io.DataInIm #= 0
      io.ChannelCoefEnable #= false
      io.ChannelCoefRe #= 0
      io.ChannelCoefIm #= 0
      io.DataInSymbol #= 0
      clockDomain.waitSampling(100)
//      io.DataInSymbol #= 1
      input_C(64)
//      io.DataInSymbol #= 2
      clockDomain.waitSampling(4)
//      input(64)
      io.DataInSymbol #= 3
      clockDomain.waitSampling(4)
      input(64)
      io.DataInSymbol #= 4
      clockDomain.waitSampling(4)
      input(64)
      io.DataInSymbol #= 5
      clockDomain.waitSampling(4)
      input(64)
      io.DataInSymbol #= 6
      clockDomain.waitSampling(4)
      input(64)
      io.DataInSymbol #= 7
      clockDomain.waitSampling(4)
      input(64)
      clockDomain.waitSampling(4)
      clockDomain.waitSampling(20)
      simSuccess()
    }
  }
}