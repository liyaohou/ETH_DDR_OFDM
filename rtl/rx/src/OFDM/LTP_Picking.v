// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : LTP_Picking
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module LTP_Picking (
  input  wire          DataInEnable,
  output wire          DataOutEnable,
  output wire          AveLongTrainingEnable,
  input  wire [7:0]    DataInSymbol,
  output wire [7:0]    DataOutSymbol,
  input  wire [7:0]    DataInRe,
  input  wire [7:0]    DataInIm,
  output wire [7:0]    DataOutRe,
  output wire [7:0]    DataOutIm,
  output reg  [7:0]    AveLongTrainingRe,
  output reg  [7:0]    AveLongTrainingIm,
  input  wire          clk_out1,
  input  wire          rstN
);

  wire                fifo_io_pop_ready;
  wire                fifo_io_push_ready;
  wire                fifo_io_pop_valid;
  wire       [7:0]    fifo_io_pop_payload_Re;
  wire       [7:0]    fifo_io_pop_payload_Im;
  wire       [6:0]    fifo_io_occupancy;
  wire       [6:0]    fifo_io_availability;
  wire       [8:0]    _zz_ReSum;
  wire       [8:0]    _zz_ReSum_1;
  wire       [8:0]    _zz_ImSum;
  wire       [8:0]    _zz_ImSum_1;
  wire                DataInStream_valid;
  wire                DataInStream_ready;
  wire       [7:0]    DataInStream_payload_Re;
  wire       [7:0]    DataInStream_payload_Im;
  reg                 DataInEnableNext;
  wire                fifo_io_pop_fire;
  wire       [8:0]    ReSum;
  wire       [8:0]    ImSum;
  wire                assignCond;

  assign _zz_ReSum = {fifo_io_pop_payload_Re[7],fifo_io_pop_payload_Re};
  assign _zz_ReSum_1 = {DataInRe[7],DataInRe};
  assign _zz_ImSum = {fifo_io_pop_payload_Im[7],fifo_io_pop_payload_Im};
  assign _zz_ImSum_1 = {DataInIm[7],DataInIm};
  DataInStreamFifoLTP_Picking fifo (
    .io_push_valid      (DataInStream_valid          ), //i
    .io_push_ready      (fifo_io_push_ready          ), //o
    .io_push_payload_Re (DataInStream_payload_Re[7:0]), //i
    .io_push_payload_Im (DataInStream_payload_Im[7:0]), //i
    .io_pop_valid       (fifo_io_pop_valid           ), //o
    .io_pop_ready       (fifo_io_pop_ready           ), //i
    .io_pop_payload_Re  (fifo_io_pop_payload_Re[7:0] ), //o
    .io_pop_payload_Im  (fifo_io_pop_payload_Im[7:0] ), //o
    .io_flush           (1'b0                        ), //i
    .io_occupancy       (fifo_io_occupancy[6:0]      ), //o
    .io_availability    (fifo_io_availability[6:0]   ), //o
    .clk_out1           (clk_out1                    ), //i
    .rstN               (rstN                        )  //i
  );
  assign DataInStream_valid = (DataInEnableNext && (DataInSymbol == 8'h01));
  assign DataInStream_payload_Re = DataInRe;
  assign DataInStream_payload_Im = DataInIm;
  assign DataInStream_ready = fifo_io_push_ready;
  assign fifo_io_pop_ready = (DataInEnableNext && (DataInSymbol == 8'h02));
  always @(*) begin
    AveLongTrainingRe = 8'h0;
    if(fifo_io_pop_fire) begin
      AveLongTrainingRe = (ReSum >>> 1'd1);
    end
  end

  always @(*) begin
    AveLongTrainingIm = 8'h0;
    if(fifo_io_pop_fire) begin
      AveLongTrainingIm = (ImSum >>> 1'd1);
    end
  end

  assign fifo_io_pop_fire = (fifo_io_pop_valid && fifo_io_pop_ready);
  assign ReSum = ($signed(_zz_ReSum) + $signed(_zz_ReSum_1));
  assign ImSum = ($signed(_zz_ImSum) + $signed(_zz_ImSum_1));
  assign AveLongTrainingEnable = (DataInEnable && (DataInSymbol == 8'h02));
  assign assignCond = (DataInEnableNext && (8'h03 <= DataInSymbol));
  assign DataOutEnable = (DataInEnable && (8'h03 <= DataInSymbol));
  assign DataOutSymbol = ((8'h03 <= DataInSymbol) ? DataInSymbol : 8'h0);
  assign DataOutRe = (assignCond ? DataInRe : 8'h0);
  assign DataOutIm = (assignCond ? DataInIm : 8'h0);
  always @(posedge clk_out1 or negedge rstN) begin
    if(!rstN) begin
      DataInEnableNext <= 1'b0;
    end else begin
      DataInEnableNext <= DataInEnable;
    end
  end


endmodule
