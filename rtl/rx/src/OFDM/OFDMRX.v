// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : OFDMRX
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module OFDMRX (
  input  wire [15:0]   io_adcData,
  output wire          io_axisOut_valid,
  input  wire          io_axisOut_ready,
  output wire [7:0]    io_axisOut_payload_data,
  output wire          io_axisOut_payload_last,
  output wire [0:0]    io_axisOut_payload_user,
  input  wire          rstN,
  input  wire          clk_out6,
  input  wire          clk_out1
);

  wire       [7:0]    adcClockArea_sync_FFT_bitInR_0;
  wire       [7:0]    adcClockArea_sync_FFT_bitInI_0;
  wire                fifo_io_pop_ready;
  wire       [7:0]    adcClockArea_sync_FFT_fft_dout_re_0;
  wire       [7:0]    adcClockArea_sync_FFT_fft_dout_im_0;
  wire                adcClockArea_sync_FFT_fft_dout_vld_0;
  wire       [7:0]    adcClockArea_sync_FFT_fft_dout_index_0;
  wire       [7:0]    adcClockArea_sync_FFT_DataSymbol_0;
  wire                fifo_io_push_ready;
  wire                fifo_io_pop_valid;
  wire       [7:0]    fifo_io_pop_payload_Re;
  wire       [7:0]    fifo_io_pop_payload_Im;
  wire       [10:0]   fifo_io_pushOccupancy;
  wire       [10:0]   fifo_io_popOccupancy;
  wire                dataRestore_1_io_axisOut_valid;
  wire       [7:0]    dataRestore_1_io_axisOut_payload_data;
  wire                dataRestore_1_io_axisOut_payload_last;
  wire       [0:0]    dataRestore_1_io_axisOut_payload_user;
  wire       [7:0]    adcClockArea_sync_FFT_DataSymbol_0_buffercc_io_dataOut;
  wire       [7:0]    adcClockArea_adcSlices_0;
  wire       [7:0]    adcClockArea_adcSlices_1;
  wire                adcClockArea_fftData_valid;
  wire       [7:0]    adcClockArea_fftData_payload_Re;
  wire       [7:0]    adcClockArea_fftData_payload_Im;
  wire                adcClockArea_fftData_toStream_valid;
  wire                adcClockArea_fftData_toStream_ready;
  wire       [7:0]    adcClockArea_fftData_toStream_payload_Re;
  wire       [7:0]    adcClockArea_fftData_toStream_payload_Im;
  reg                 fifo_io_pop_valid_regNext;
  reg        [7:0]    fifo_io_pop_payload_Re_regNext;
  reg        [7:0]    fifo_io_pop_payload_Im_regNext;
  wire                fifo_io_pop_fire;
  reg        [7:0]    _zz_io_inputSymbol;

  Sync_FFT adcClockArea_sync_FFT (
    .Clk_0            (clk_out6                                   ), //i
    .Rst_n_0          (rstN                                       ), //i
    .bitInR_0         (adcClockArea_sync_FFT_bitInR_0[7:0]        ), //i
    .bitInI_0         (adcClockArea_sync_FFT_bitInI_0[7:0]        ), //i
    .fft_dout_re_0    (adcClockArea_sync_FFT_fft_dout_re_0[7:0]   ), //o
    .fft_dout_im_0    (adcClockArea_sync_FFT_fft_dout_im_0[7:0]   ), //o
    .fft_dout_vld_0   (adcClockArea_sync_FFT_fft_dout_vld_0       ), //o
    .fft_dout_index_0 (adcClockArea_sync_FFT_fft_dout_index_0[7:0]), //o
    .DataSymbol_0     (adcClockArea_sync_FFT_DataSymbol_0[7:0]    )  //o
  );
  DataInStreamFifosync_FFT fifo (
    .io_push_valid      (adcClockArea_fftData_toStream_valid          ), //i
    .io_push_ready      (fifo_io_push_ready                           ), //o
    .io_push_payload_Re (adcClockArea_fftData_toStream_payload_Re[7:0]), //i
    .io_push_payload_Im (adcClockArea_fftData_toStream_payload_Im[7:0]), //i
    .io_pop_valid       (fifo_io_pop_valid                            ), //o
    .io_pop_ready       (fifo_io_pop_ready                            ), //i
    .io_pop_payload_Re  (fifo_io_pop_payload_Re[7:0]                  ), //o
    .io_pop_payload_Im  (fifo_io_pop_payload_Im[7:0]                  ), //o
    .io_pushOccupancy   (fifo_io_pushOccupancy[10:0]                  ), //o
    .io_popOccupancy    (fifo_io_popOccupancy[10:0]                   ), //o
    .clk_out6           (clk_out6                                     ), //i
    .rstN               (rstN                                         ), //i
    .clk_out1           (clk_out1                                     )  //i
  );
  DataRestore dataRestore_1 (
    .io_inputDataEn          (fifo_io_pop_valid_regNext                 ), //i
    .io_inputDataR           (fifo_io_pop_payload_Re_regNext[7:0]       ), //i
    .io_inputDataI           (fifo_io_pop_payload_Im_regNext[7:0]       ), //i
    .io_inputSymbol          (_zz_io_inputSymbol[7:0]                   ), //i
    .io_axisOut_valid        (dataRestore_1_io_axisOut_valid            ), //o
    .io_axisOut_ready        (io_axisOut_ready                          ), //i
    .io_axisOut_payload_data (dataRestore_1_io_axisOut_payload_data[7:0]), //o
    .io_axisOut_payload_last (dataRestore_1_io_axisOut_payload_last     ), //o
    .io_axisOut_payload_user (dataRestore_1_io_axisOut_payload_user     ), //o
    .rstN                    (rstN                                      ), //i
    .clk_out1                (clk_out1                                  )  //i
  );
  (* keep_hierarchy = "TRUE" *) BufferCC_3 adcClockArea_sync_FFT_DataSymbol_0_buffercc (
    .io_dataIn  (adcClockArea_sync_FFT_DataSymbol_0[7:0]                    ), //i
    .io_dataOut (adcClockArea_sync_FFT_DataSymbol_0_buffercc_io_dataOut[7:0]), //o
    .clk_out1   (clk_out1                                                   ), //i
    .rstN       (rstN                                                       )  //i
  );
  assign adcClockArea_adcSlices_0 = io_adcData[7 : 0];
  assign adcClockArea_adcSlices_1 = io_adcData[15 : 8];
  assign adcClockArea_sync_FFT_bitInI_0 = adcClockArea_adcSlices_0;
  assign adcClockArea_sync_FFT_bitInR_0 = adcClockArea_adcSlices_1;
  assign adcClockArea_fftData_valid = adcClockArea_sync_FFT_fft_dout_vld_0;
  assign adcClockArea_fftData_payload_Re = adcClockArea_sync_FFT_fft_dout_re_0;
  assign adcClockArea_fftData_payload_Im = adcClockArea_sync_FFT_fft_dout_im_0;
  assign adcClockArea_fftData_toStream_valid = adcClockArea_fftData_valid;
  assign adcClockArea_fftData_toStream_payload_Re = adcClockArea_fftData_payload_Re;
  assign adcClockArea_fftData_toStream_payload_Im = adcClockArea_fftData_payload_Im;
  assign adcClockArea_fftData_toStream_ready = fifo_io_push_ready;
  assign fifo_io_pop_ready = 1'b1;
  assign fifo_io_pop_fire = (fifo_io_pop_valid && fifo_io_pop_ready);
  assign io_axisOut_valid = dataRestore_1_io_axisOut_valid;
  assign io_axisOut_payload_data = dataRestore_1_io_axisOut_payload_data;
  assign io_axisOut_payload_last = dataRestore_1_io_axisOut_payload_last;
  assign io_axisOut_payload_user[0 : 0] = dataRestore_1_io_axisOut_payload_user[0 : 0];
  always @(posedge clk_out1) begin
    fifo_io_pop_valid_regNext <= fifo_io_pop_valid;
    fifo_io_pop_payload_Re_regNext <= fifo_io_pop_payload_Re;
    fifo_io_pop_payload_Im_regNext <= fifo_io_pop_payload_Im;
    if(fifo_io_pop_fire) begin
      _zz_io_inputSymbol <= adcClockArea_sync_FFT_DataSymbol_0_buffercc_io_dataOut;
    end
  end


endmodule
