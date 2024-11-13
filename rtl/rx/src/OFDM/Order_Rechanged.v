// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : Order_Rechanged
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module Order_Rechanged (
  input  wire          inputDataEn,
  input  wire [9:0]    inputDataR,
  input  wire [9:0]    inputDataI,
  input  wire [7:0]    inputSymbol,
  output wire          outputDataEn,
  output wire [9:0]    outputDataR,
  output wire [9:0]    outputDataI,
  output wire [7:0]    outputSymbol,
  input  wire          clk_out1,
  input  wire          rstN
);

  wire                fifoFront_io_push_ready;
  wire                fifoFront_io_pop_valid;
  wire       [9:0]    fifoFront_io_pop_payload_Re;
  wire       [9:0]    fifoFront_io_pop_payload_Im;
  wire       [6:0]    fifoFront_io_occupancy;
  wire       [6:0]    fifoFront_io_availability;
  wire                fifoBehind_io_push_ready;
  wire                fifoBehind_io_pop_valid;
  wire       [9:0]    fifoBehind_io_pop_payload_Re;
  wire       [9:0]    fifoBehind_io_pop_payload_Im;
  wire       [6:0]    fifoBehind_io_occupancy;
  wire       [6:0]    fifoBehind_io_availability;
  wire                streamDemux_2_io_input_ready;
  wire                streamDemux_2_io_outputs_0_valid;
  wire       [9:0]    streamDemux_2_io_outputs_0_payload_Re;
  wire       [9:0]    streamDemux_2_io_outputs_0_payload_Im;
  wire                streamDemux_2_io_outputs_1_valid;
  wire       [9:0]    streamDemux_2_io_outputs_1_payload_Re;
  wire       [9:0]    streamDemux_2_io_outputs_1_payload_Im;
  wire                streamMux_2_io_inputs_0_ready;
  wire                streamMux_2_io_inputs_1_ready;
  wire                streamMux_2_io_output_valid;
  wire       [9:0]    streamMux_2_io_output_payload_Re;
  wire       [9:0]    streamMux_2_io_output_payload_Im;
  wire       [5:0]    _zz_wrAddr_valueNext;
  wire       [0:0]    _zz_wrAddr_valueNext_1;
  wire       [5:0]    _zz_rdAddr_valueNext;
  wire       [0:0]    _zz_rdAddr_valueNext_1;
  wire                inputFlow_valid;
  wire       [9:0]    inputFlow_payload_Re;
  wire       [9:0]    inputFlow_payload_Im;
  wire                inputStream_valid;
  wire                inputStream_ready;
  wire       [9:0]    inputStream_payload_Re;
  wire       [9:0]    inputStream_payload_Im;
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
  reg                 _zz_outputDataEn;
  reg        [9:0]    _zz_outputDataR;
  reg        [9:0]    _zz_outputDataI;
  wire                when_OrderRechanged_l54;
  reg        [7:0]    inputSymbol_regNextWhen;

  assign _zz_wrAddr_valueNext_1 = wrAddr_willIncrement;
  assign _zz_wrAddr_valueNext = {5'd0, _zz_wrAddr_valueNext_1};
  assign _zz_rdAddr_valueNext_1 = rdAddr_willIncrement;
  assign _zz_rdAddr_valueNext = {5'd0, _zz_rdAddr_valueNext_1};
  DataInStreamFifoPilots_Picking fifoFront (
    .io_push_valid      (streamDemux_2_io_outputs_0_valid          ), //i
    .io_push_ready      (fifoFront_io_push_ready                   ), //o
    .io_push_payload_Re (streamDemux_2_io_outputs_0_payload_Re[9:0]), //i
    .io_push_payload_Im (streamDemux_2_io_outputs_0_payload_Im[9:0]), //i
    .io_pop_valid       (fifoFront_io_pop_valid                    ), //o
    .io_pop_ready       (streamMux_2_io_inputs_1_ready             ), //i
    .io_pop_payload_Re  (fifoFront_io_pop_payload_Re[9:0]          ), //o
    .io_pop_payload_Im  (fifoFront_io_pop_payload_Im[9:0]          ), //o
    .io_flush           (1'b0                                      ), //i
    .io_occupancy       (fifoFront_io_occupancy[6:0]               ), //o
    .io_availability    (fifoFront_io_availability[6:0]            ), //o
    .clk_out1           (clk_out1                                  ), //i
    .rstN               (rstN                                      )  //i
  );
  DataInStreamFifoPilots_Picking fifoBehind (
    .io_push_valid      (streamDemux_2_io_outputs_1_valid          ), //i
    .io_push_ready      (fifoBehind_io_push_ready                  ), //o
    .io_push_payload_Re (streamDemux_2_io_outputs_1_payload_Re[9:0]), //i
    .io_push_payload_Im (streamDemux_2_io_outputs_1_payload_Im[9:0]), //i
    .io_pop_valid       (fifoBehind_io_pop_valid                   ), //o
    .io_pop_ready       (streamMux_2_io_inputs_0_ready             ), //i
    .io_pop_payload_Re  (fifoBehind_io_pop_payload_Re[9:0]         ), //o
    .io_pop_payload_Im  (fifoBehind_io_pop_payload_Im[9:0]         ), //o
    .io_flush           (1'b0                                      ), //i
    .io_occupancy       (fifoBehind_io_occupancy[6:0]              ), //o
    .io_availability    (fifoBehind_io_availability[6:0]           ), //o
    .clk_out1           (clk_out1                                  ), //i
    .rstN               (rstN                                      )  //i
  );
  StreamDemux streamDemux_2 (
    .io_select               (dMux                                      ), //i
    .io_input_valid          (inputStream_valid                         ), //i
    .io_input_ready          (streamDemux_2_io_input_ready              ), //o
    .io_input_payload_Re     (inputStream_payload_Re[9:0]               ), //i
    .io_input_payload_Im     (inputStream_payload_Im[9:0]               ), //i
    .io_outputs_0_valid      (streamDemux_2_io_outputs_0_valid          ), //o
    .io_outputs_0_ready      (fifoFront_io_push_ready                   ), //i
    .io_outputs_0_payload_Re (streamDemux_2_io_outputs_0_payload_Re[9:0]), //o
    .io_outputs_0_payload_Im (streamDemux_2_io_outputs_0_payload_Im[9:0]), //o
    .io_outputs_1_valid      (streamDemux_2_io_outputs_1_valid          ), //o
    .io_outputs_1_ready      (fifoBehind_io_push_ready                  ), //i
    .io_outputs_1_payload_Re (streamDemux_2_io_outputs_1_payload_Re[9:0]), //o
    .io_outputs_1_payload_Im (streamDemux_2_io_outputs_1_payload_Im[9:0])  //o
  );
  StreamMux streamMux_2 (
    .io_select              (mux                                  ), //i
    .io_inputs_0_valid      (fifoBehind_io_pop_valid              ), //i
    .io_inputs_0_ready      (streamMux_2_io_inputs_0_ready        ), //o
    .io_inputs_0_payload_Re (fifoBehind_io_pop_payload_Re[9:0]    ), //i
    .io_inputs_0_payload_Im (fifoBehind_io_pop_payload_Im[9:0]    ), //i
    .io_inputs_1_valid      (fifoFront_io_pop_valid               ), //i
    .io_inputs_1_ready      (streamMux_2_io_inputs_1_ready        ), //o
    .io_inputs_1_payload_Re (fifoFront_io_pop_payload_Re[9:0]     ), //i
    .io_inputs_1_payload_Im (fifoFront_io_pop_payload_Im[9:0]     ), //i
    .io_output_valid        (streamMux_2_io_output_valid          ), //o
    .io_output_ready        (1'b1                                 ), //i
    .io_output_payload_Re   (streamMux_2_io_output_payload_Re[9:0]), //o
    .io_output_payload_Im   (streamMux_2_io_output_payload_Im[9:0])  //o
  );
  assign inputFlow_valid = inputDataEn;
  assign inputFlow_payload_Re = inputDataR;
  assign inputFlow_payload_Im = inputDataI;
  assign inputStream_valid = inputFlow_valid;
  assign inputStream_payload_Re = inputFlow_payload_Re;
  assign inputStream_payload_Im = inputFlow_payload_Im;
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
  assign outputDataEn = _zz_outputDataEn;
  assign outputDataR = _zz_outputDataR;
  assign outputDataI = _zz_outputDataI;
  assign when_OrderRechanged_l54 = (rdAddr_value == 6'h0);
  assign outputSymbol = inputSymbol_regNextWhen;
  always @(posedge clk_out1 or negedge rstN) begin
    if(!rstN) begin
      wrAddr_value <= 6'h0;
      rdAddr_value <= 6'h0;
      _zz_outputDataEn <= 1'b0;
      _zz_outputDataR <= 10'h0;
      _zz_outputDataI <= 10'h0;
      inputSymbol_regNextWhen <= 8'h0;
    end else begin
      wrAddr_value <= wrAddr_valueNext;
      rdAddr_value <= rdAddr_valueNext;
      _zz_outputDataEn <= streamMux_2_io_output_valid;
      _zz_outputDataR <= streamMux_2_io_output_payload_Re;
      _zz_outputDataI <= streamMux_2_io_output_payload_Im;
      if(when_OrderRechanged_l54) begin
        inputSymbol_regNextWhen <= inputSymbol;
      end
    end
  end


endmodule
