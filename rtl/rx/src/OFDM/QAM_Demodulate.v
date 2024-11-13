// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : QAM_Demodulate
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module QAM_Demodulate (
  input  wire          io_EnergyInEn,
  input  wire [9:0]    io_Energy,
  input  wire          io_inputDataEn,
  input  wire [9:0]    io_inputDataR,
  input  wire [9:0]    io_inputDataI,
  input  wire [7:0]    io_inputSymbol,
  output wire          io_outputData_valid,
  input  wire          io_outputData_ready,
  output wire [0:0]    io_outputData_payload,
  output wire [7:0]    io_outputSymbol,
  input  wire          clk_out1,
  input  wire          rstN
);

  wire                fifo_io_pop_ready;
  wire                threshold_Adjusting_1_EnergyOutEn;
  wire       [13:0]   threshold_Adjusting_1_EnergyPos;
  wire       [13:0]   threshold_Adjusting_1_EnergyNeg;
  wire                qam16_Demapping_1_outputDataEn;
  wire       [3:0]    qam16_Demapping_1_outDataDemod;
  wire       [7:0]    qam16_Demapping_1_outputSymbol;
  wire                fifo_io_push_ready;
  wire                fifo_io_pop_valid;
  wire       [3:0]    fifo_io_pop_payload;
  wire       [6:0]    fifo_io_occupancy;
  wire       [6:0]    fifo_io_availability;
  wire       [1:0]    _zz__zz_io_outputData_payload_1;
  wire       [0:0]    _zz__zz_io_outputData_payload_1_1;
  reg        [0:0]    _zz_io_outputData_payload_4;
  wire                io_outputData_fire;
  reg                 _zz_io_outputData_payload;
  reg        [1:0]    _zz_io_outputData_payload_1;
  reg        [1:0]    _zz_io_outputData_payload_2;
  wire                _zz_io_pop_ready;
  wire       [3:0]    _zz_io_outputData_payload_3;
  wire                when_QAMDemodulate_l37;
  reg        [7:0]    qam16_Demapping_1_outputSymbol_regNextWhen;

  assign _zz__zz_io_outputData_payload_1_1 = _zz_io_outputData_payload;
  assign _zz__zz_io_outputData_payload_1 = {1'd0, _zz__zz_io_outputData_payload_1_1};
  Threshold_Adjusting threshold_Adjusting_1 (
    .EnergyInEn  (io_EnergyInEn                        ), //i
    .Energy      (io_Energy[9:0]                       ), //i
    .EnergyOutEn (threshold_Adjusting_1_EnergyOutEn    ), //o
    .EnergyPos   (threshold_Adjusting_1_EnergyPos[13:0]), //o
    .EnergyNeg   (threshold_Adjusting_1_EnergyNeg[13:0]), //o
    .clk_out1    (clk_out1                             ), //i
    .rstN        (rstN                                 )  //i
  );
  QAM16_Demapping qam16_Demapping_1 (
    .EnergyInEn   (threshold_Adjusting_1_EnergyOutEn    ), //i
    .EnergyPos    (threshold_Adjusting_1_EnergyPos[13:0]), //i
    .EnergyNeg    (threshold_Adjusting_1_EnergyNeg[13:0]), //i
    .inputDataEn  (io_inputDataEn                       ), //i
    .inputDataR   (io_inputDataR[9:0]                   ), //i
    .inputDataI   (io_inputDataI[9:0]                   ), //i
    .inputSymbol  (io_inputSymbol[7:0]                  ), //i
    .outputDataEn (qam16_Demapping_1_outputDataEn       ), //o
    .outDataDemod (qam16_Demapping_1_outDataDemod[3:0]  ), //o
    .outputSymbol (qam16_Demapping_1_outputSymbol[7:0]  ), //o
    .clk_out1     (clk_out1                             ), //i
    .rstN         (rstN                                 )  //i
  );
  StreamFifoQAM_Demodulate fifo (
    .io_push_valid   (qam16_Demapping_1_outputDataEn     ), //i
    .io_push_ready   (fifo_io_push_ready                 ), //o
    .io_push_payload (qam16_Demapping_1_outDataDemod[3:0]), //i
    .io_pop_valid    (fifo_io_pop_valid                  ), //o
    .io_pop_ready    (fifo_io_pop_ready                  ), //i
    .io_pop_payload  (fifo_io_pop_payload[3:0]           ), //o
    .io_flush        (1'b0                               ), //i
    .io_occupancy    (fifo_io_occupancy[6:0]             ), //o
    .io_availability (fifo_io_availability[6:0]          ), //o
    .clk_out1        (clk_out1                           ), //i
    .rstN            (rstN                               )  //i
  );
  always @(*) begin
    case(_zz_io_outputData_payload_2)
      2'b00 : _zz_io_outputData_payload_4 = _zz_io_outputData_payload_3[0 : 0];
      2'b01 : _zz_io_outputData_payload_4 = _zz_io_outputData_payload_3[1 : 1];
      2'b10 : _zz_io_outputData_payload_4 = _zz_io_outputData_payload_3[2 : 2];
      default : _zz_io_outputData_payload_4 = _zz_io_outputData_payload_3[3 : 3];
    endcase
  end

  assign io_outputData_fire = (io_outputData_valid && io_outputData_ready);
  always @(*) begin
    _zz_io_outputData_payload = 1'b0;
    if(io_outputData_fire) begin
      _zz_io_outputData_payload = 1'b1;
    end
  end

  assign _zz_io_pop_ready = (_zz_io_outputData_payload_2 == 2'b11);
  always @(*) begin
    _zz_io_outputData_payload_1 = (_zz_io_outputData_payload_2 + _zz__zz_io_outputData_payload_1);
    if(1'b0) begin
      _zz_io_outputData_payload_1 = 2'b00;
    end
  end

  assign io_outputData_valid = fifo_io_pop_valid;
  assign _zz_io_outputData_payload_3 = fifo_io_pop_payload;
  assign io_outputData_payload = _zz_io_outputData_payload_4;
  assign fifo_io_pop_ready = (io_outputData_ready && _zz_io_pop_ready);
  assign when_QAMDemodulate_l37 = (! io_outputData_fire);
  assign io_outputSymbol = qam16_Demapping_1_outputSymbol_regNextWhen;
  always @(posedge clk_out1 or negedge rstN) begin
    if(!rstN) begin
      _zz_io_outputData_payload_2 <= 2'b00;
      qam16_Demapping_1_outputSymbol_regNextWhen <= 8'h0;
    end else begin
      _zz_io_outputData_payload_2 <= _zz_io_outputData_payload_1;
      if(when_QAMDemodulate_l37) begin
        qam16_Demapping_1_outputSymbol_regNextWhen <= qam16_Demapping_1_outputSymbol;
      end
    end
  end


endmodule
