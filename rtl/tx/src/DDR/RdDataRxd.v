// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : RdDataRxd
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module RdDataRxd (
  input  wire          io_task_read,
  input  wire          io_task_write,
  input  wire          io_task_active,
  input  wire          io_task_precharge,
  input  wire          io_task_last,
  input  wire [0:0]    io_task_address_byte,
  input  wire [9:0]    io_task_address_column,
  input  wire [2:0]    io_task_address_bank,
  input  wire [14:0]   io_task_address_row,
  input  wire [17:0]   io_task_context,
  input  wire          io_task_prechargeAll,
  input  wire          io_task_refresh,
  input  wire          io_idfiRdData_0_valid,
  output wire          io_idfiRdData_0_ready,
  input  wire          io_idfiRdData_0_payload_last,
  input  wire [31:0]   io_idfiRdData_0_payload_fragment_rdData,
  output wire          io_rden_0,
  output wire          io_taskRdData_valid,
  output wire          io_taskRdData_payload_last,
  output wire [31:0]   io_taskRdData_payload_fragment_data,
  output wire [17:0]   io_taskRdData_payload_fragment_context,
  input  wire          clk_out4,
  input  wire          rstN
);

  wire                rspPipeline_input_toStream_fifo_io_push_ready;
  wire                rspPipeline_input_toStream_fifo_io_pop_valid;
  wire                rspPipeline_input_toStream_fifo_io_pop_payload_last;
  wire       [17:0]   rspPipeline_input_toStream_fifo_io_pop_payload_fragment_context;
  wire       [2:0]    rspPipeline_input_toStream_fifo_io_occupancy;
  wire       [2:0]    rspPipeline_input_toStream_fifo_io_availability;
  wire       [1:0]    _zz_rspPipeline_beatCounter_valueNext;
  wire       [0:0]    _zz_rspPipeline_beatCounter_valueNext_1;
  reg                 rspPipeline_input_valid;
  wire                rspPipeline_input_payload_last;
  wire       [17:0]   rspPipeline_input_payload_fragment_context;
  wire                rspPipeline_input_toStream_valid;
  wire                rspPipeline_input_toStream_ready;
  wire                rspPipeline_input_toStream_payload_last;
  wire       [17:0]   rspPipeline_input_toStream_payload_fragment_context;
  wire                rspPipeline_rdensHistory_0_0;
  wire                rspPipeline_rdensHistory_0_1;
  wire                rspPipeline_rdensHistory_0_2;
  wire                rspPipeline_rdensHistory_0_3;
  wire                rspPipeline_rdensHistory_0_4;
  wire                _zz_rspPipeline_rdensHistory_0_0;
  reg                 _zz_rspPipeline_rdensHistory_0_1;
  reg                 _zz_rspPipeline_rdensHistory_0_2;
  reg                 _zz_rspPipeline_rdensHistory_0_3;
  reg                 _zz_rspPipeline_rdensHistory_0_4;
  wire                when_Utils_l585;
  reg                 rspPipeline_beatCounter_willIncrement;
  wire                rspPipeline_beatCounter_willClear;
  reg        [1:0]    rspPipeline_beatCounter_valueNext;
  reg        [1:0]    rspPipeline_beatCounter_value;
  wire                rspPipeline_beatCounter_willOverflowIfInc;
  wire                rspPipeline_beatCounter_willOverflow;
  wire                _zz_io_rden_0;
  reg                 _zz_io_rden_0_1;
  reg                 _zz_io_rden_0_2;
  reg                 _zz_io_rden_0_3;
  reg                 rspPipeline_output_valid;
  wire                rspPipeline_output_payload_last;
  wire       [31:0]   rspPipeline_output_payload_fragment_data;
  wire       [17:0]   rspPipeline_output_payload_fragment_context;
  wire                when_Task2IDFI_l123;
  reg                 rspPop_valid;
  reg                 rspPop_payload_last;
  reg        [31:0]   rspPop_payload_fragment_data;
  reg        [17:0]   rspPop_payload_fragment_context;
  reg                 ready_0;

  assign _zz_rspPipeline_beatCounter_valueNext_1 = rspPipeline_beatCounter_willIncrement;
  assign _zz_rspPipeline_beatCounter_valueNext = {1'd0, _zz_rspPipeline_beatCounter_valueNext_1};
  StreamFifoLowLatency_4 rspPipeline_input_toStream_fifo (
    .io_push_valid                    (rspPipeline_input_toStream_valid                                     ), //i
    .io_push_ready                    (rspPipeline_input_toStream_fifo_io_push_ready                        ), //o
    .io_push_payload_last             (rspPipeline_input_toStream_payload_last                              ), //i
    .io_push_payload_fragment_context (rspPipeline_input_toStream_payload_fragment_context[17:0]            ), //i
    .io_pop_valid                     (rspPipeline_input_toStream_fifo_io_pop_valid                         ), //o
    .io_pop_ready                     (rspPipeline_beatCounter_willOverflow                                 ), //i
    .io_pop_payload_last              (rspPipeline_input_toStream_fifo_io_pop_payload_last                  ), //o
    .io_pop_payload_fragment_context  (rspPipeline_input_toStream_fifo_io_pop_payload_fragment_context[17:0]), //o
    .io_flush                         (1'b0                                                                 ), //i
    .io_occupancy                     (rspPipeline_input_toStream_fifo_io_occupancy[2:0]                    ), //o
    .io_availability                  (rspPipeline_input_toStream_fifo_io_availability[2:0]                 ), //o
    .clk_out4                         (clk_out4                                                             ), //i
    .rstN                             (rstN                                                                 )  //i
  );
  assign rspPipeline_input_toStream_valid = rspPipeline_input_valid;
  assign rspPipeline_input_toStream_payload_last = rspPipeline_input_payload_last;
  assign rspPipeline_input_toStream_payload_fragment_context = rspPipeline_input_payload_fragment_context;
  assign rspPipeline_input_toStream_ready = rspPipeline_input_toStream_fifo_io_push_ready;
  assign _zz_rspPipeline_rdensHistory_0_0 = rspPipeline_input_valid;
  assign rspPipeline_rdensHistory_0_0 = _zz_rspPipeline_rdensHistory_0_0;
  assign rspPipeline_rdensHistory_0_1 = _zz_rspPipeline_rdensHistory_0_1;
  assign rspPipeline_rdensHistory_0_2 = _zz_rspPipeline_rdensHistory_0_2;
  assign rspPipeline_rdensHistory_0_3 = _zz_rspPipeline_rdensHistory_0_3;
  assign rspPipeline_rdensHistory_0_4 = _zz_rspPipeline_rdensHistory_0_4;
  assign when_Utils_l585 = (|io_idfiRdData_0_valid);
  always @(*) begin
    rspPipeline_beatCounter_willIncrement = 1'b0;
    if(when_Utils_l585) begin
      rspPipeline_beatCounter_willIncrement = 1'b1;
    end
  end

  assign rspPipeline_beatCounter_willClear = 1'b0;
  assign rspPipeline_beatCounter_willOverflowIfInc = (rspPipeline_beatCounter_value == 2'b11);
  assign rspPipeline_beatCounter_willOverflow = (rspPipeline_beatCounter_willOverflowIfInc && rspPipeline_beatCounter_willIncrement);
  always @(*) begin
    rspPipeline_beatCounter_valueNext = (rspPipeline_beatCounter_value + _zz_rspPipeline_beatCounter_valueNext);
    if(rspPipeline_beatCounter_willClear) begin
      rspPipeline_beatCounter_valueNext = 2'b00;
    end
  end

  assign _zz_io_rden_0 = rspPipeline_rdensHistory_0_3;
  assign io_rden_0 = (|{_zz_io_rden_0_3,{_zz_io_rden_0_2,{_zz_io_rden_0_1,_zz_io_rden_0}}});
  always @(*) begin
    rspPipeline_output_valid = 1'b0;
    if(when_Task2IDFI_l123) begin
      rspPipeline_output_valid = 1'b1;
    end
  end

  assign when_Task2IDFI_l123 = (|io_idfiRdData_0_valid);
  assign rspPipeline_output_payload_fragment_context = rspPipeline_input_toStream_fifo_io_pop_payload_fragment_context;
  assign rspPipeline_output_payload_last = (rspPipeline_beatCounter_willOverflowIfInc && rspPipeline_input_toStream_fifo_io_pop_payload_last);
  assign rspPipeline_output_payload_fragment_data[31 : 0] = io_idfiRdData_0_payload_fragment_rdData;
  always @(*) begin
    rspPipeline_input_valid = 1'b0;
    if(io_task_read) begin
      rspPipeline_input_valid = 1'b1;
    end
  end

  assign rspPipeline_input_payload_last = io_task_last;
  assign rspPipeline_input_payload_fragment_context = io_task_context;
  assign io_taskRdData_valid = rspPop_valid;
  assign io_taskRdData_payload_last = rspPop_payload_last;
  assign io_taskRdData_payload_fragment_data = rspPop_payload_fragment_data;
  assign io_taskRdData_payload_fragment_context = rspPop_payload_fragment_context;
  assign io_idfiRdData_0_ready = ready_0;
  always @(posedge clk_out4 or negedge rstN) begin
    if(!rstN) begin
      _zz_rspPipeline_rdensHistory_0_1 <= 1'b0;
      _zz_rspPipeline_rdensHistory_0_2 <= 1'b0;
      _zz_rspPipeline_rdensHistory_0_3 <= 1'b0;
      _zz_rspPipeline_rdensHistory_0_4 <= 1'b0;
      rspPipeline_beatCounter_value <= 2'b00;
      rspPop_valid <= 1'b0;
      ready_0 <= 1'b0;
    end else begin
      _zz_rspPipeline_rdensHistory_0_1 <= _zz_rspPipeline_rdensHistory_0_0;
      _zz_rspPipeline_rdensHistory_0_2 <= _zz_rspPipeline_rdensHistory_0_1;
      _zz_rspPipeline_rdensHistory_0_3 <= _zz_rspPipeline_rdensHistory_0_2;
      _zz_rspPipeline_rdensHistory_0_4 <= _zz_rspPipeline_rdensHistory_0_3;
      rspPipeline_beatCounter_value <= rspPipeline_beatCounter_valueNext;
      rspPop_valid <= rspPipeline_output_valid;
      if(io_task_read) begin
        ready_0 <= 1'b1;
      end
      if(io_task_write) begin
        ready_0 <= 1'b0;
      end
    end
  end

  always @(posedge clk_out4) begin
    _zz_io_rden_0_1 <= _zz_io_rden_0;
    _zz_io_rden_0_2 <= _zz_io_rden_0_1;
    _zz_io_rden_0_3 <= _zz_io_rden_0_2;
    rspPop_payload_last <= rspPipeline_output_payload_last;
    rspPop_payload_fragment_data <= rspPipeline_output_payload_fragment_data;
    rspPop_payload_fragment_context <= rspPipeline_output_payload_fragment_context;
  end


endmodule
