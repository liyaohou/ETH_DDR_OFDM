// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : BmbToPreTaskPort
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module BmbToPreTaskPort (
  input  wire          io_input_cmd_valid,
  output reg           io_input_cmd_ready,
  input  wire          io_input_cmd_payload_last,
  input  wire [0:0]    io_input_cmd_payload_fragment_opcode,
  input  wire [28:0]   io_input_cmd_payload_fragment_address,
  input  wire [5:0]    io_input_cmd_payload_fragment_length,
  input  wire [31:0]   io_input_cmd_payload_fragment_data,
  input  wire [3:0]    io_input_cmd_payload_fragment_mask,
  input  wire [17:0]   io_input_cmd_payload_fragment_context,
  output wire          io_input_rsp_valid,
  input  wire          io_input_rsp_ready,
  output wire          io_input_rsp_payload_last,
  output wire [0:0]    io_input_rsp_payload_fragment_opcode,
  output wire [31:0]   io_input_rsp_payload_fragment_data,
  output wire [17:0]   io_input_rsp_payload_fragment_context,
  input  wire          io_inputBurstLast,
  output wire          io_output_cmd_valid,
  input  wire          io_output_cmd_ready,
  output wire          io_output_cmd_payload_write,
  output wire [28:0]   io_output_cmd_payload_address,
  output wire [17:0]   io_output_cmd_payload_context,
  output wire          io_output_cmd_payload_burstLast,
  output wire [1:0]    io_output_cmd_payload_length,
  output wire          io_output_writeData_valid,
  input  wire          io_output_writeData_ready,
  output wire [31:0]   io_output_writeData_payload_data,
  output wire [3:0]    io_output_writeData_payload_mask,
  output wire          io_output_writeDataToken_valid,
  input  wire          io_output_writeDataToken_ready,
  output wire          io_output_writeDataToken_payload_valid,
  output wire          io_output_writeDataToken_payload_ready,
  input  wire          io_output_rsp_valid,
  output wire          io_output_rsp_ready,
  input  wire          io_output_rsp_payload_last,
  input  wire [31:0]   io_output_rsp_payload_fragment_data,
  input  wire [17:0]   io_output_rsp_payload_fragment_context,
  input  wire          clk_out4,
  input  wire          rstN
);

  wire       [4:0]    _zz_cmdToRspCount;
  wire       [2:0]    _zz_cmdToRspCount_1;
  wire       [2:0]    _zz_cmdToRspCount_2;
  wire       [1:0]    _zz_cmdToRspCount_3;
  wire       [7:0]    _zz_toManyRsp;
  wire       [7:0]    _zz_toManyRsp_1;
  wire       [6:0]    _zz_rspPendingCounter;
  wire       [6:0]    _zz_rspPendingCounter_1;
  wire       [4:0]    _zz_rspPendingCounter_2;
  wire       [6:0]    _zz_rspPendingCounter_3;
  wire       [0:0]    _zz_rspPendingCounter_4;
  wire       [4:0]    cmdToRspCount;
  reg        [6:0]    rspPendingCounter;
  wire                toManyRsp;
  wire                io_input_cmd_fire;
  wire                io_output_rsp_fire;
  wire       [17:0]   cmdContext_context;
  wire                when_Bmb2PreTaskPort_l24;
  wire       [17:0]   rspContext_context;
  reg                 io_input_cmd_payload_first;

  assign _zz_cmdToRspCount = ({2'd0,_zz_cmdToRspCount_1} <<< 2'd2);
  assign _zz_cmdToRspCount_1 = ({1'b0,io_output_cmd_payload_length} + _zz_cmdToRspCount_2);
  assign _zz_cmdToRspCount_3 = {1'b0,1'b1};
  assign _zz_cmdToRspCount_2 = {1'd0, _zz_cmdToRspCount_3};
  assign _zz_toManyRsp = ({1'b0,rspPendingCounter} + _zz_toManyRsp_1);
  assign _zz_toManyRsp_1 = {3'd0, cmdToRspCount};
  assign _zz_rspPendingCounter = (rspPendingCounter + _zz_rspPendingCounter_1);
  assign _zz_rspPendingCounter_2 = ((io_input_cmd_fire && io_input_cmd_payload_last) ? cmdToRspCount : 5'h0);
  assign _zz_rspPendingCounter_1 = {2'd0, _zz_rspPendingCounter_2};
  assign _zz_rspPendingCounter_4 = io_output_rsp_fire;
  assign _zz_rspPendingCounter_3 = {6'd0, _zz_rspPendingCounter_4};
  assign cmdToRspCount = (io_output_cmd_payload_write ? 5'h0 : _zz_cmdToRspCount);
  assign toManyRsp = (8'h40 < _zz_toManyRsp);
  assign io_input_cmd_fire = (io_input_cmd_valid && io_input_cmd_ready);
  assign io_output_rsp_fire = (io_output_rsp_valid && io_output_rsp_ready);
  always @(*) begin
    io_input_cmd_ready = (io_output_cmd_ready && (! toManyRsp));
    if(when_Bmb2PreTaskPort_l24) begin
      io_input_cmd_ready = 1'b0;
    end
  end

  assign when_Bmb2PreTaskPort_l24 = (! io_output_writeData_ready);
  assign rspContext_context = io_output_rsp_payload_fragment_context[17 : 0];
  assign cmdContext_context = io_input_cmd_payload_fragment_context;
  assign io_output_cmd_valid = (io_input_cmd_fire && io_input_cmd_payload_first);
  assign io_output_cmd_payload_write = (io_input_cmd_payload_fragment_opcode == 1'b1);
  assign io_output_cmd_payload_address = io_input_cmd_payload_fragment_address;
  assign io_output_cmd_payload_length = (io_input_cmd_payload_fragment_length >>> 3'd4);
  assign io_output_cmd_payload_context = cmdContext_context;
  assign io_output_cmd_payload_burstLast = io_inputBurstLast;
  assign io_output_writeData_valid = (io_input_cmd_fire && (io_input_cmd_payload_fragment_opcode == 1'b1));
  assign io_output_writeData_payload_data = io_input_cmd_payload_fragment_data;
  assign io_output_writeData_payload_mask = io_input_cmd_payload_fragment_mask;
  assign io_input_rsp_valid = io_output_rsp_valid;
  assign io_output_rsp_ready = io_input_rsp_ready;
  assign io_input_rsp_payload_fragment_opcode = 1'b0;
  assign io_input_rsp_payload_last = io_output_rsp_payload_last;
  assign io_input_rsp_payload_fragment_data = io_output_rsp_payload_fragment_data;
  assign io_input_rsp_payload_fragment_context = rspContext_context;
  always @(posedge clk_out4 or negedge rstN) begin
    if(!rstN) begin
      rspPendingCounter <= 7'h0;
      io_input_cmd_payload_first <= 1'b1;
    end else begin
      rspPendingCounter <= (_zz_rspPendingCounter - _zz_rspPendingCounter_3);
      if(io_input_cmd_fire) begin
        io_input_cmd_payload_first <= io_input_cmd_payload_last;
      end
    end
  end


endmodule
