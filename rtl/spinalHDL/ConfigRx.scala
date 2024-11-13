package spinal.demo.workSpace
import spinal.core._
import spinal.lib._
import spinal.lib.bus.amba4.axis.{Axi4Stream, Axi4StreamConfig}
case class ConfigRx(axis: Axi4StreamConfig, configWidth:Int, lengthWidth: Int) extends Component{
  val io = new Bundle{
    val udpAxisIn = slave(Axi4Stream(axis))
    val udpAxisOut = master(Axi4Stream(axis))
    val lengthIn = in Bits(lengthWidth bits)
    val lengthOut = out Bits(lengthWidth bits)
    val rxHdr = slave(Stream(NoData))
    val config = out Bits(configWidth bits)
    val end = out Bool()
  }
  val end = Bool()
  end.clear()
  io.end := end
  io.rxHdr.ready.set()
  val lengthIn = RegNextWhen(io.lengthIn,io.rxHdr.fire)
  val config = Reg(Bits((configWidth + 7)/8*8 bits)).init(0)
  val hit = lengthIn === 2
  val counter = Counter(0 until (3))
  io.config := config.resize(configWidth)
  io.lengthOut := lengthIn

  when(hit & io.udpAxisIn.fire){
    counter.increment()
//    config.subdivideIn(axis.dataWidth * 8 bit)(counter.value) := io.udpAxisIn.data
    config(counter.value << 3, 8 bits) := io.udpAxisIn.data
  }
  when(counter.willOverflow){
    end.set()
  }
  io.udpAxisOut << io.udpAxisIn.throwWhen(hit)
}
