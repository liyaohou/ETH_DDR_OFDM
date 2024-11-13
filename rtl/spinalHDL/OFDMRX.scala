package spinal.demo.ofdm
import spinal.core._
import spinal.lib.bus.amba4.axis.{Axi4Stream, Axi4StreamConfig}
import spinal.lib.{StreamFifoCC, master}
import spinal.lib._
case class OFDMRX (axis: Axi4StreamConfig, adcClockDomain:ClockDomain)extends Component{
  val io = new Bundle{
    val adcData = in Bits(16 bits)
    val axisOut = master(Axi4Stream(axis))
  }
  class Context extends Bundle {
    val Re = SInt(8 bits)
    val Im = SInt(8 bits)
  }
  val adcClockArea = new ClockingArea(adcClockDomain){
    val sync_FFT = Sync_FFT()
    val adcSlices = io.adcData.subdivideIn(2 slices)
    sync_FFT.io.bitInI := adcSlices(0).asSInt
    sync_FFT.io.bitInR := adcSlices(1).asSInt
    val fftData = Flow(new Context)
    fftData.valid := sync_FFT.io.fft_dout.vld
    fftData.Re := sync_FFT.io.fft_dout.re
    fftData.Im := sync_FFT.io.fft_dout.im
  }

  class DataInStreamFifosync_FFT extends StreamFifoCC(new Context, 1024, adcClockDomain, ClockDomain.current)
  val fifo = new DataInStreamFifosync_FFT
  fifo.io.push << adcClockArea.fftData.toStream
  fifo.io.pop.ready.set()
  val dataRestore = DataRestore(axis)
  dataRestore.io.inputDataEn := RegNext(fifo.io.pop.valid)
  dataRestore.io.inputDataR := RegNext(fifo.io.pop.Re)
  dataRestore.io.inputDataI := RegNext(fifo.io.pop.Im)
  dataRestore.io.inputSymbol := RegNextWhen(BufferCC(adcClockArea.sync_FFT.io.DataSymbol), fifo.io.pop.fire)
  dataRestore.io.axisOut >> io.axisOut

}
