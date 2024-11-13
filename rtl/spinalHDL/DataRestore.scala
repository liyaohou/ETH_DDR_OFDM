package spinal.demo.ofdm
import spinal.core._
import spinal.lib._
import spinal.lib.bus.amba4.axis._
case class DataRestore(axis: Axi4StreamConfig)extends Component{
  val io = new Bundle{
    val inputDataEn = in Bool()
    val inputDataR = in SInt(8 bits)
    val inputDataI = in SInt(8 bits)
    val inputSymbol = in UInt(8 bits)
    val axisOut = master(Axi4Stream(axis))
  }
  val channel_Equalizer = Channel_Equalizer()
  channel_Equalizer.io.DataInEnable <> io.inputDataEn
  channel_Equalizer.io.DataInRe <> io.inputDataR
  channel_Equalizer.io.DataInIm <> io.inputDataI
  channel_Equalizer.io.DataInSymbol <> io.inputSymbol

  val interim_function = Interim_function()
  interim_function.io.inputDataEn <> channel_Equalizer.io.DataOutEnable
  interim_function.io.inputDataR  <> channel_Equalizer.io.DataOutRe
  interim_function.io.inputDataI  <> channel_Equalizer.io.DataOutIm
  interim_function.io.inputSymbol <> channel_Equalizer.io.DataOutSymbol

  val qam_Demodulate = QAM_Demodulate()
  qam_Demodulate.io.EnergyInEn <> channel_Equalizer.io.EnergyEnable
  qam_Demodulate.io.Energy <> channel_Equalizer.io.Energy
  qam_Demodulate.io.inputDataEn <> interim_function.io.outputDataEn
  qam_Demodulate.io.inputDataR  <> interim_function.io.outputDataR
  qam_Demodulate.io.inputDataI  <> interim_function.io.outputDataI
  qam_Demodulate.io.inputSymbol <> interim_function.io.outputSymbol

  val decode = Decode()
  decode.io.deintv2 << qam_Demodulate.io.outputData
  decode.io.deintv2_din_Map_Type := U(2, 2 bits)
  decode.io.deintv2_din_symb_cnt := qam_Demodulate.io.outputSymbol

  val tempStream = Stream(Bits(8 bits))
  val decodeWidthAdapter = StreamWidthAdapter(decode.io.descram, tempStream)

  io.axisOut.arbitrationFrom(tempStream)
  io.axisOut.data := tempStream.payload
  io.axisOut.user.clearAll()
  io.axisOut.last := decode.io.descram_dout_last
}
object DataRestore {
  def main(args: Array[String]): Unit = {
    val axi4Stream = Axi4StreamConfig(
      dataWidth = 1,
      userWidth = 1,
      useLast = true,
      useUser = true
      )
    SpinalConfig(
      targetDirectory = "verilog/ofdm",
      oneFilePerComponent = false,
      defaultConfigForClockDomains = ClockDomainConfig(resetActiveLevel = LOW)
      ).generateVerilog(DataRestore(axi4Stream))
  }
}