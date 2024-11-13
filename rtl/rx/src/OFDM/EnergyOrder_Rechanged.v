// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : EnergyOrder_Rechanged
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module EnergyOrder_Rechanged (
  input  wire          EnergyInEn,
  input  wire [9:0]    EnergyIn,
  output wire          EnergyOutEn,
  output wire [9:0]    EnergyOut,
  input  wire          clk_out1,
  input  wire          rstN
);

  wire                fifoFront_io_push_ready;
  wire                fifoFront_io_pop_valid;
  wire       [9:0]    fifoFront_io_pop_payload_Energy;
  wire       [6:0]    fifoFront_io_occupancy;
  wire       [6:0]    fifoFront_io_availability;
  wire                fifoBehind_io_push_ready;
  wire                fifoBehind_io_pop_valid;
  wire       [9:0]    fifoBehind_io_pop_payload_Energy;
  wire       [6:0]    fifoBehind_io_occupancy;
  wire       [6:0]    fifoBehind_io_availability;
  wire                streamDemux_2_io_input_ready;
  wire                streamDemux_2_io_outputs_0_valid;
  wire       [9:0]    streamDemux_2_io_outputs_0_payload_Energy;
  wire                streamDemux_2_io_outputs_1_valid;
  wire       [9:0]    streamDemux_2_io_outputs_1_payload_Energy;
  wire                streamMux_2_io_inputs_0_ready;
  wire                streamMux_2_io_inputs_1_ready;
  wire                streamMux_2_io_output_valid;
  wire       [9:0]    streamMux_2_io_output_payload_Energy;
  wire       [5:0]    _zz_wrAddr_valueNext;
  wire       [0:0]    _zz_wrAddr_valueNext_1;
  wire       [5:0]    _zz_rdAddr_valueNext;
  wire       [0:0]    _zz_rdAddr_valueNext_1;
  wire                inputFlow_valid;
  wire       [9:0]    inputFlow_payload_Energy;
  wire                inputStream_valid;
  wire                inputStream_ready;
  wire       [9:0]    inputStream_payload_Energy;
  reg                 wrAddr_willIncrement;
  wire                wrAddr_willClear;
  reg        [5:0]    wrAddr_valueNext;
  reg        [5:0]    wrAddr_value;
  wire                wrAddr_willOverflowIfInc;
  wire                wrAddr_willOverflow;
  reg                 rdAddr_willIncrement;
  wire                rdAddr_willClear;
  reg        [5:0]    rdAddr_valueNext;
  reg        [5:0]    rdAddr_value;
  wire                rdAddr_willOverflowIfInc;
  wire                rdAddr_willOverflow;
  wire                behindWr;
  wire                frontWr;
  wire       [0:0]    dMux;
  wire                inputStream_fire;
  wire                behindRd;
  wire                frontRd;
  wire       [0:0]    mux;
  reg                 _zz_EnergyOutEn;
  reg        [9:0]    _zz_EnergyOut;

  assign _zz_wrAddr_valueNext_1 = wrAddr_willIncrement;
  assign _zz_wrAddr_valueNext = {5'd0, _zz_wrAddr_valueNext_1};
  assign _zz_rdAddr_valueNext_1 = rdAddr_willIncrement;
  assign _zz_rdAddr_valueNext = {5'd0, _zz_rdAddr_valueNext_1};
  EnergyStreamFifoOrder_Rechanged fifoFront (
    .io_push_valid          (streamDemux_2_io_outputs_0_valid              ), //i
    .io_push_ready          (fifoFront_io_push_ready                       ), //o
    .io_push_payload_Energy (streamDemux_2_io_outputs_0_payload_Energy[9:0]), //i
    .io_pop_valid           (fifoFront_io_pop_valid                        ), //o
    .io_pop_ready           (streamMux_2_io_inputs_1_ready                 ), //i
    .io_pop_payload_Energy  (fifoFront_io_pop_payload_Energy[9:0]          ), //o
    .io_flush               (1'b0                                          ), //i
    .io_occupancy           (fifoFront_io_occupancy[6:0]                   ), //o
    .io_availability        (fifoFront_io_availability[6:0]                ), //o
    .clk_out1               (clk_out1                                      ), //i
    .rstN                   (rstN                                          )  //i
  );
  EnergyStreamFifoOrder_Rechanged fifoBehind (
    .io_push_valid          (streamDemux_2_io_outputs_1_valid              ), //i
    .io_push_ready          (fifoBehind_io_push_ready                      ), //o
    .io_push_payload_Energy (streamDemux_2_io_outputs_1_payload_Energy[9:0]), //i
    .io_pop_valid           (fifoBehind_io_pop_valid                       ), //o
    .io_pop_ready           (streamMux_2_io_inputs_0_ready                 ), //i
    .io_pop_payload_Energy  (fifoBehind_io_pop_payload_Energy[9:0]         ), //o
    .io_flush               (1'b0                                          ), //i
    .io_occupancy           (fifoBehind_io_occupancy[6:0]                  ), //o
    .io_availability        (fifoBehind_io_availability[6:0]               ), //o
    .clk_out1               (clk_out1                                      ), //i
    .rstN                   (rstN                                          )  //i
  );
  StreamDemux_1 streamDemux_2 (
    .io_select                   (dMux                                          ), //i
    .io_input_valid              (inputStream_valid                             ), //i
    .io_input_ready              (streamDemux_2_io_input_ready                  ), //o
    .io_input_payload_Energy     (inputStream_payload_Energy[9:0]               ), //i
    .io_outputs_0_valid          (streamDemux_2_io_outputs_0_valid              ), //o
    .io_outputs_0_ready          (fifoFront_io_push_ready                       ), //i
    .io_outputs_0_payload_Energy (streamDemux_2_io_outputs_0_payload_Energy[9:0]), //o
    .io_outputs_1_valid          (streamDemux_2_io_outputs_1_valid              ), //o
    .io_outputs_1_ready          (fifoBehind_io_push_ready                      ), //i
    .io_outputs_1_payload_Energy (streamDemux_2_io_outputs_1_payload_Energy[9:0])  //o
  );
  StreamMux_1 streamMux_2 (
    .io_select                  (mux                                      ), //i
    .io_inputs_0_valid          (fifoBehind_io_pop_valid                  ), //i
    .io_inputs_0_ready          (streamMux_2_io_inputs_0_ready            ), //o
    .io_inputs_0_payload_Energy (fifoBehind_io_pop_payload_Energy[9:0]    ), //i
    .io_inputs_1_valid          (fifoFront_io_pop_valid                   ), //i
    .io_inputs_1_ready          (streamMux_2_io_inputs_1_ready            ), //o
    .io_inputs_1_payload_Energy (fifoFront_io_pop_payload_Energy[9:0]     ), //i
    .io_output_valid            (streamMux_2_io_output_valid              ), //o
    .io_output_ready            (1'b1                                     ), //i
    .io_output_payload_Energy   (streamMux_2_io_output_payload_Energy[9:0])  //o
  );
  assign inputFlow_valid = EnergyInEn;
  assign inputFlow_payload_Energy = EnergyIn;
  assign inputStream_valid = inputFlow_valid;
  assign inputStream_payload_Energy = inputFlow_payload_Energy;
  always @(*) begin
    wrAddr_willIncrement = 1'b0;
    if(inputStream_fire) begin
      wrAddr_willIncrement = 1'b1;
    end
  end

  assign wrAddr_willClear = 1'b0;
  assign wrAddr_willOverflowIfInc = (wrAddr_value == 6'h3f);
  assign wrAddr_willOverflow = (wrAddr_willOverflowIfInc && wrAddr_willIncrement);
  always @(*) begin
    wrAddr_valueNext = (wrAddr_value + _zz_wrAddr_valueNext);
    if(wrAddr_willClear) begin
      wrAddr_valueNext = 6'h0;
    end
  end

  always @(*) begin
    rdAddr_willIncrement = 1'b0;
    if((streamMux_2_io_output_valid && 1'b1)) begin
      rdAddr_willIncrement = 1'b1;
    end
  end

  assign rdAddr_willClear = 1'b0;
  assign rdAddr_willOverflowIfInc = (rdAddr_value == 6'h3f);
  assign rdAddr_willOverflow = (rdAddr_willOverflowIfInc && rdAddr_willIncrement);
  always @(*) begin
    rdAddr_valueNext = (rdAddr_value + _zz_rdAddr_valueNext);
    if(rdAddr_willClear) begin
      rdAddr_valueNext = 6'h0;
    end
  end

  assign behindWr = (inputStream_valid && (6'h20 <= wrAddr_value));
  assign frontWr = (inputStream_valid && (wrAddr_value < 6'h20));
  assign dMux = behindWr;
  assign inputStream_ready = streamDemux_2_io_input_ready;
  assign inputStream_fire = (inputStream_valid && inputStream_ready);
  assign behindRd = (rdAddr_value < 6'h20);
  assign frontRd = (! behindRd);
  assign mux = frontRd;
  assign EnergyOutEn = _zz_EnergyOutEn;
  assign EnergyOut = _zz_EnergyOut;
  always @(posedge clk_out1 or negedge rstN) begin
    if(!rstN) begin
      wrAddr_value <= 6'h0;
      rdAddr_value <= 6'h0;
      _zz_EnergyOutEn <= 1'b0;
      _zz_EnergyOut <= 10'h0;
    end else begin
      wrAddr_value <= wrAddr_valueNext;
      rdAddr_value <= rdAddr_valueNext;
      _zz_EnergyOutEn <= streamMux_2_io_output_valid;
      _zz_EnergyOut <= streamMux_2_io_output_payload_Energy;
    end
  end


endmodule
