// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : DataRestore
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module DataRestore (
  input  wire          io_inputDataEn,
  input  wire [7:0]    io_inputDataR,
  input  wire [7:0]    io_inputDataI,
  input  wire [7:0]    io_inputSymbol,
  output wire          io_axisOut_valid,
  input  wire          io_axisOut_ready,
  output wire [7:0]    io_axisOut_payload_data,
  output wire          io_axisOut_payload_last,
  output wire [0:0]    io_axisOut_payload_user,
  input  wire          rstN,
  input  wire          clk_out1
);

  wire                decode_1_descram_din_rdy;
  wire                channel_Equalizer_1_DataOutEnable;
  wire       [9:0]    channel_Equalizer_1_DataOutRe;
  wire       [9:0]    channel_Equalizer_1_DataOutIm;
  wire       [7:0]    channel_Equalizer_1_DataOutSymbol;
  wire                channel_Equalizer_1_EnergyEnable;
  wire       [9:0]    channel_Equalizer_1_Energy;
  wire                interim_function_1_outputDataEn;
  wire       [9:0]    interim_function_1_outputDataR;
  wire       [9:0]    interim_function_1_outputDataI;
  wire       [7:0]    interim_function_1_outputSymbol;
  wire                qam_Demodulate_1_io_outputData_valid;
  wire       [0:0]    qam_Demodulate_1_io_outputData_payload;
  wire       [7:0]    qam_Demodulate_1_io_outputSymbol;
  wire                decode_1_deintv2_dout_rdy;
  wire                decode_1_descram_dout_vld;
  wire       [0:0]    decode_1_descram_dout;
  wire                decode_1_descram_dout_last;
  wire       [7:0]    decode_1_descram_dout_symb_cnt;
  wire       [2:0]    _zz__zz_tempStream_valid_1;
  wire       [0:0]    _zz__zz_tempStream_valid_1_1;
  wire       [5:0]    _zz__zz_tempStream_payload;
  wire                tempStream_valid;
  wire                tempStream_ready;
  wire       [7:0]    tempStream_payload;
  wire                decode_1_descram_fire;
  reg                 _zz_tempStream_valid;
  reg        [2:0]    _zz_tempStream_valid_1;
  reg        [2:0]    _zz_tempStream_valid_2;
  wire                _zz_tempStream_valid_3;
  reg        [6:0]    _zz_tempStream_payload;

  assign _zz__zz_tempStream_valid_1_1 = _zz_tempStream_valid;
  assign _zz__zz_tempStream_valid_1 = {2'd0, _zz__zz_tempStream_valid_1_1};
  assign _zz__zz_tempStream_payload = (_zz_tempStream_payload >>> 1'd1);
  Channel_Equalizer channel_Equalizer_1 (
    .DataInEnable  (io_inputDataEn                        ), //i
    .DataInRe      (io_inputDataR[7:0]                    ), //i
    .DataInIm      (io_inputDataI[7:0]                    ), //i
    .DataInSymbol  (io_inputSymbol[7:0]                   ), //i
    .DataOutEnable (channel_Equalizer_1_DataOutEnable     ), //o
    .DataOutRe     (channel_Equalizer_1_DataOutRe[9:0]    ), //o
    .DataOutIm     (channel_Equalizer_1_DataOutIm[9:0]    ), //o
    .DataOutSymbol (channel_Equalizer_1_DataOutSymbol[7:0]), //o
    .EnergyEnable  (channel_Equalizer_1_EnergyEnable      ), //o
    .Energy        (channel_Equalizer_1_Energy[9:0]       ), //o
    .clk_out1      (clk_out1                              ), //i
    .rstN          (rstN                                  )  //i
  );
  Interim_function interim_function_1 (
    .inputDataEn  (channel_Equalizer_1_DataOutEnable     ), //i
    .inputDataR   (channel_Equalizer_1_DataOutRe[9:0]    ), //i
    .inputDataI   (channel_Equalizer_1_DataOutIm[9:0]    ), //i
    .inputSymbol  (channel_Equalizer_1_DataOutSymbol[7:0]), //i
    .outputDataEn (interim_function_1_outputDataEn       ), //o
    .outputDataR  (interim_function_1_outputDataR[9:0]   ), //o
    .outputDataI  (interim_function_1_outputDataI[9:0]   ), //o
    .outputSymbol (interim_function_1_outputSymbol[7:0]  ), //o
    .clk_out1     (clk_out1                              ), //i
    .rstN         (rstN                                  )  //i
  );
  QAM_Demodulate qam_Demodulate_1 (
    .io_EnergyInEn         (channel_Equalizer_1_EnergyEnable      ), //i
    .io_Energy             (channel_Equalizer_1_Energy[9:0]       ), //i
    .io_inputDataEn        (interim_function_1_outputDataEn       ), //i
    .io_inputDataR         (interim_function_1_outputDataR[9:0]   ), //i
    .io_inputDataI         (interim_function_1_outputDataI[9:0]   ), //i
    .io_inputSymbol        (interim_function_1_outputSymbol[7:0]  ), //i
    .io_outputData_valid   (qam_Demodulate_1_io_outputData_valid  ), //o
    .io_outputData_ready   (decode_1_deintv2_dout_rdy             ), //i
    .io_outputData_payload (qam_Demodulate_1_io_outputData_payload), //o
    .io_outputSymbol       (qam_Demodulate_1_io_outputSymbol[7:0] ), //o
    .clk_out1              (clk_out1                              ), //i
    .rstN                  (rstN                                  )  //i
  );
  Decode decode_1 (
    .clk                   (clk_out1                              ), //i
    .rst_n                 (rstN                                  ), //i
    .deintv2_din_vld       (qam_Demodulate_1_io_outputData_valid  ), //i
    .deintv2_dout_rdy      (decode_1_deintv2_dout_rdy             ), //o
    .deintv2_din           (qam_Demodulate_1_io_outputData_payload), //i
    .deintv2_din_symb_cnt  (qam_Demodulate_1_io_outputSymbol[7:0] ), //i
    .deintv2_din_Map_Type  (2'b10                                 ), //i
    .descram_dout_vld      (decode_1_descram_dout_vld             ), //o
    .descram_din_rdy       (decode_1_descram_din_rdy              ), //i
    .descram_dout          (decode_1_descram_dout                 ), //o
    .descram_dout_last     (decode_1_descram_dout_last            ), //o
    .descram_dout_symb_cnt (decode_1_descram_dout_symb_cnt[7:0]   )  //o
  );
  assign decode_1_descram_fire = (decode_1_descram_dout_vld && decode_1_descram_din_rdy);
  always @(*) begin
    _zz_tempStream_valid = 1'b0;
    if(decode_1_descram_fire) begin
      _zz_tempStream_valid = 1'b1;
    end
  end

  assign _zz_tempStream_valid_3 = (_zz_tempStream_valid_2 == 3'b111);
  always @(*) begin
    _zz_tempStream_valid_1 = (_zz_tempStream_valid_2 + _zz__zz_tempStream_valid_1);
    if(1'b0) begin
      _zz_tempStream_valid_1 = 3'b000;
    end
  end

  assign tempStream_valid = (decode_1_descram_dout_vld && _zz_tempStream_valid_3);
  assign tempStream_payload = {decode_1_descram_dout,_zz_tempStream_payload};
  assign decode_1_descram_din_rdy = (! ((! tempStream_ready) && _zz_tempStream_valid_3));
  assign io_axisOut_valid = tempStream_valid;
  assign tempStream_ready = io_axisOut_ready;
  assign io_axisOut_payload_data = tempStream_payload;
  assign io_axisOut_payload_user = 1'b0;
  assign io_axisOut_payload_last = decode_1_descram_dout_last;
  always @(posedge clk_out1 or negedge rstN) begin
    if(!rstN) begin
      _zz_tempStream_valid_2 <= 3'b000;
    end else begin
      _zz_tempStream_valid_2 <= _zz_tempStream_valid_1;
    end
  end

  always @(posedge clk_out1) begin
    if(decode_1_descram_fire) begin
      _zz_tempStream_payload <= {decode_1_descram_dout,_zz__zz_tempStream_payload};
    end
  end


endmodule
