// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : BmbUpSizerBridge
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module BmbUpSizerBridge (
  input  wire          io_input_cmd_valid,
  output wire          io_input_cmd_ready,
  input  wire          io_input_cmd_payload_last,
  input  wire [0:0]    io_input_cmd_payload_fragment_opcode,
  input  wire [28:0]   io_input_cmd_payload_fragment_address,
  input  wire [9:0]    io_input_cmd_payload_fragment_length,
  input  wire [7:0]    io_input_cmd_payload_fragment_data,
  input  wire [0:0]    io_input_cmd_payload_fragment_mask,
  output wire          io_input_rsp_valid,
  input  wire          io_input_rsp_ready,
  output reg           io_input_rsp_payload_last,
  output wire [0:0]    io_input_rsp_payload_fragment_opcode,
  output wire [7:0]    io_input_rsp_payload_fragment_data,
  output wire          io_output_cmd_valid,
  input  wire          io_output_cmd_ready,
  output wire          io_output_cmd_payload_last,
  output wire [0:0]    io_output_cmd_payload_fragment_opcode,
  output wire [28:0]   io_output_cmd_payload_fragment_address,
  output wire [9:0]    io_output_cmd_payload_fragment_length,
  output reg  [31:0]   io_output_cmd_payload_fragment_data,
  output reg  [3:0]    io_output_cmd_payload_fragment_mask,
  output wire [3:0]    io_output_cmd_payload_fragment_context,
  input  wire          io_output_rsp_valid,
  output wire          io_output_rsp_ready,
  input  wire          io_output_rsp_payload_last,
  input  wire [0:0]    io_output_rsp_payload_fragment_opcode,
  input  wire [31:0]   io_output_rsp_payload_fragment_data,
  input  wire [3:0]    io_output_rsp_payload_fragment_context,
  input  wire          clk_out1,
  input  wire          rstN
);

  wire       [10:0]   _zz_cmdArea_context_selEnd;
  wire       [10:0]   _zz_cmdArea_context_selEnd_1;
  wire       [1:0]    _zz_cmdArea_context_selEnd_2;
  wire       [10:0]   _zz_cmdArea_context_selEnd_3;
  reg        [7:0]    _zz_io_input_rsp_payload_fragment_data;
  wire       [1:0]    cmdArea_selStart;
  wire       [1:0]    cmdArea_context_selStart;
  reg        [1:0]    cmdArea_context_selEnd;
  wire                when_BmbUpSizerBridge_l53;
  reg        [7:0]    cmdArea_writeLogic_dataRegs_0;
  reg        [7:0]    cmdArea_writeLogic_dataRegs_1;
  reg        [7:0]    cmdArea_writeLogic_dataRegs_2;
  reg        [0:0]    cmdArea_writeLogic_maskRegs_0;
  reg        [0:0]    cmdArea_writeLogic_maskRegs_1;
  reg        [0:0]    cmdArea_writeLogic_maskRegs_2;
  reg        [1:0]    cmdArea_writeLogic_selReg;
  wire                io_input_cmd_fire;
  reg                 io_input_cmd_payload_first;
  wire       [1:0]    cmdArea_writeLogic_sel;
  wire       [7:0]    cmdArea_writeLogic_outputData_0;
  wire       [7:0]    cmdArea_writeLogic_outputData_1;
  wire       [7:0]    cmdArea_writeLogic_outputData_2;
  wire       [7:0]    cmdArea_writeLogic_outputData_3;
  wire       [0:0]    cmdArea_writeLogic_outputMask_0;
  wire       [0:0]    cmdArea_writeLogic_outputMask_1;
  wire       [0:0]    cmdArea_writeLogic_outputMask_2;
  wire       [0:0]    cmdArea_writeLogic_outputMask_3;
  wire                when_BmbUpSizerBridge_l85;
  wire                when_BmbUpSizerBridge_l95;
  wire                io_output_cmd_fire;
  wire                when_BmbUpSizerBridge_l85_1;
  wire                when_BmbUpSizerBridge_l95_1;
  wire                when_BmbUpSizerBridge_l85_2;
  wire                when_BmbUpSizerBridge_l95_2;
  wire                io_output_cmd_isStall;
  wire       [1:0]    rspArea_context_selStart;
  wire       [1:0]    rspArea_context_selEnd;
  wire       [3:0]    _zz_rspArea_context_selStart;
  reg        [1:0]    rspArea_readLogic_selReg;
  wire                io_input_rsp_fire;
  reg                 io_input_rsp_payload_first;
  wire       [1:0]    rspArea_readLogic_sel;
  wire                when_BmbUpSizerBridge_l133;

  assign _zz_cmdArea_context_selEnd = (_zz_cmdArea_context_selEnd_1 + _zz_cmdArea_context_selEnd_3[10 : 0]);
  assign _zz_cmdArea_context_selEnd_2 = io_input_cmd_payload_fragment_address[1 : 0];
  assign _zz_cmdArea_context_selEnd_1 = {9'd0, _zz_cmdArea_context_selEnd_2};
  assign _zz_cmdArea_context_selEnd_3 = ({1'b0,io_input_cmd_payload_fragment_length} + 11'h0);
  always @(*) begin
    case(rspArea_readLogic_sel)
      2'b00 : _zz_io_input_rsp_payload_fragment_data = io_output_rsp_payload_fragment_data[7 : 0];
      2'b01 : _zz_io_input_rsp_payload_fragment_data = io_output_rsp_payload_fragment_data[15 : 8];
      2'b10 : _zz_io_input_rsp_payload_fragment_data = io_output_rsp_payload_fragment_data[23 : 16];
      default : _zz_io_input_rsp_payload_fragment_data = io_output_rsp_payload_fragment_data[31 : 24];
    endcase
  end

  assign cmdArea_selStart = io_input_cmd_payload_fragment_address[1 : 0];
  assign cmdArea_context_selStart = cmdArea_selStart;
  always @(*) begin
    cmdArea_context_selEnd = _zz_cmdArea_context_selEnd[1:0];
    if(when_BmbUpSizerBridge_l53) begin
      cmdArea_context_selEnd = io_input_cmd_payload_fragment_address[1 : 0];
    end
  end

  assign when_BmbUpSizerBridge_l53 = (io_input_cmd_payload_fragment_opcode == 1'b1);
  assign io_output_cmd_payload_last = io_input_cmd_payload_last;
  assign io_output_cmd_payload_fragment_opcode = io_input_cmd_payload_fragment_opcode;
  assign io_output_cmd_payload_fragment_address = io_input_cmd_payload_fragment_address;
  assign io_output_cmd_payload_fragment_length = io_input_cmd_payload_fragment_length;
  assign io_output_cmd_payload_fragment_context = {cmdArea_context_selEnd,cmdArea_context_selStart};
  assign io_input_cmd_fire = (io_input_cmd_valid && io_input_cmd_ready);
  assign cmdArea_writeLogic_sel = (io_input_cmd_payload_first ? cmdArea_selStart : cmdArea_writeLogic_selReg);
  assign cmdArea_writeLogic_outputData_0 = io_output_cmd_payload_fragment_data[7 : 0];
  assign cmdArea_writeLogic_outputData_1 = io_output_cmd_payload_fragment_data[15 : 8];
  assign cmdArea_writeLogic_outputData_2 = io_output_cmd_payload_fragment_data[23 : 16];
  assign cmdArea_writeLogic_outputData_3 = io_output_cmd_payload_fragment_data[31 : 24];
  assign cmdArea_writeLogic_outputMask_0 = io_output_cmd_payload_fragment_mask[0 : 0];
  assign cmdArea_writeLogic_outputMask_1 = io_output_cmd_payload_fragment_mask[1 : 1];
  assign cmdArea_writeLogic_outputMask_2 = io_output_cmd_payload_fragment_mask[2 : 2];
  assign cmdArea_writeLogic_outputMask_3 = io_output_cmd_payload_fragment_mask[3 : 3];
  always @(*) begin
    io_output_cmd_payload_fragment_data[7 : 0] = io_input_cmd_payload_fragment_data;
    if(when_BmbUpSizerBridge_l85) begin
      io_output_cmd_payload_fragment_data[7 : 0] = cmdArea_writeLogic_dataRegs_0;
    end
    io_output_cmd_payload_fragment_data[15 : 8] = io_input_cmd_payload_fragment_data;
    if(when_BmbUpSizerBridge_l85_1) begin
      io_output_cmd_payload_fragment_data[15 : 8] = cmdArea_writeLogic_dataRegs_1;
    end
    io_output_cmd_payload_fragment_data[23 : 16] = io_input_cmd_payload_fragment_data;
    if(when_BmbUpSizerBridge_l85_2) begin
      io_output_cmd_payload_fragment_data[23 : 16] = cmdArea_writeLogic_dataRegs_2;
    end
    io_output_cmd_payload_fragment_data[31 : 24] = io_input_cmd_payload_fragment_data;
  end

  assign when_BmbUpSizerBridge_l85 = ((! io_input_cmd_payload_first) && (cmdArea_writeLogic_selReg != 2'b00));
  always @(*) begin
    io_output_cmd_payload_fragment_mask[0 : 0] = ((cmdArea_writeLogic_sel == 2'b00) ? io_input_cmd_payload_fragment_mask : cmdArea_writeLogic_maskRegs_0);
    io_output_cmd_payload_fragment_mask[1 : 1] = ((cmdArea_writeLogic_sel == 2'b01) ? io_input_cmd_payload_fragment_mask : cmdArea_writeLogic_maskRegs_1);
    io_output_cmd_payload_fragment_mask[2 : 2] = ((cmdArea_writeLogic_sel == 2'b10) ? io_input_cmd_payload_fragment_mask : cmdArea_writeLogic_maskRegs_2);
    io_output_cmd_payload_fragment_mask[3 : 3] = ((cmdArea_writeLogic_sel == 2'b11) ? io_input_cmd_payload_fragment_mask : 1'b0);
  end

  assign when_BmbUpSizerBridge_l95 = (io_input_cmd_valid && (cmdArea_writeLogic_sel == 2'b00));
  assign io_output_cmd_fire = (io_output_cmd_valid && io_output_cmd_ready);
  assign when_BmbUpSizerBridge_l85_1 = ((! io_input_cmd_payload_first) && (cmdArea_writeLogic_selReg != 2'b01));
  assign when_BmbUpSizerBridge_l95_1 = (io_input_cmd_valid && (cmdArea_writeLogic_sel == 2'b01));
  assign when_BmbUpSizerBridge_l85_2 = ((! io_input_cmd_payload_first) && (cmdArea_writeLogic_selReg != 2'b10));
  assign when_BmbUpSizerBridge_l95_2 = (io_input_cmd_valid && (cmdArea_writeLogic_sel == 2'b10));
  assign io_output_cmd_valid = (io_input_cmd_valid && ((cmdArea_writeLogic_sel == 2'b11) || io_input_cmd_payload_last));
  assign io_output_cmd_isStall = (io_output_cmd_valid && (! io_output_cmd_ready));
  assign io_input_cmd_ready = (! io_output_cmd_isStall);
  assign _zz_rspArea_context_selStart = io_output_rsp_payload_fragment_context;
  assign rspArea_context_selStart = _zz_rspArea_context_selStart[1 : 0];
  assign rspArea_context_selEnd = _zz_rspArea_context_selStart[3 : 2];
  assign io_input_rsp_valid = io_output_rsp_valid;
  assign io_input_rsp_payload_fragment_opcode = io_output_rsp_payload_fragment_opcode;
  assign io_input_rsp_fire = (io_input_rsp_valid && io_input_rsp_ready);
  assign rspArea_readLogic_sel = (io_input_rsp_payload_first ? rspArea_context_selStart : rspArea_readLogic_selReg);
  always @(*) begin
    io_input_rsp_payload_last = (io_output_rsp_payload_last && (rspArea_readLogic_sel == rspArea_context_selEnd));
    if(when_BmbUpSizerBridge_l133) begin
      io_input_rsp_payload_last = 1'b0;
    end
  end

  assign io_output_rsp_ready = (io_input_rsp_ready && (io_input_rsp_payload_last || (rspArea_readLogic_sel == 2'b11)));
  assign when_BmbUpSizerBridge_l133 = (rspArea_context_selEnd != rspArea_readLogic_sel);
  assign io_input_rsp_payload_fragment_data = _zz_io_input_rsp_payload_fragment_data;
  always @(posedge clk_out1 or negedge rstN) begin
    if(!rstN) begin
      cmdArea_writeLogic_maskRegs_0 <= 1'b0;
      cmdArea_writeLogic_maskRegs_1 <= 1'b0;
      cmdArea_writeLogic_maskRegs_2 <= 1'b0;
      io_input_cmd_payload_first <= 1'b1;
      io_input_rsp_payload_first <= 1'b1;
    end else begin
      if(io_input_cmd_fire) begin
        io_input_cmd_payload_first <= io_input_cmd_payload_last;
      end
      if(when_BmbUpSizerBridge_l95) begin
        cmdArea_writeLogic_maskRegs_0 <= io_input_cmd_payload_fragment_mask;
      end
      if(io_output_cmd_fire) begin
        cmdArea_writeLogic_maskRegs_0 <= 1'b0;
      end
      if(when_BmbUpSizerBridge_l95_1) begin
        cmdArea_writeLogic_maskRegs_1 <= io_input_cmd_payload_fragment_mask;
      end
      if(io_output_cmd_fire) begin
        cmdArea_writeLogic_maskRegs_1 <= 1'b0;
      end
      if(when_BmbUpSizerBridge_l95_2) begin
        cmdArea_writeLogic_maskRegs_2 <= io_input_cmd_payload_fragment_mask;
      end
      if(io_output_cmd_fire) begin
        cmdArea_writeLogic_maskRegs_2 <= 1'b0;
      end
      if(io_input_rsp_fire) begin
        io_input_rsp_payload_first <= io_input_rsp_payload_last;
      end
    end
  end

  always @(posedge clk_out1) begin
    if(io_input_cmd_fire) begin
      cmdArea_writeLogic_selReg <= (cmdArea_writeLogic_sel + 2'b01);
    end
    if(!when_BmbUpSizerBridge_l85) begin
      cmdArea_writeLogic_dataRegs_0 <= io_input_cmd_payload_fragment_data;
    end
    if(!when_BmbUpSizerBridge_l85_1) begin
      cmdArea_writeLogic_dataRegs_1 <= io_input_cmd_payload_fragment_data;
    end
    if(!when_BmbUpSizerBridge_l85_2) begin
      cmdArea_writeLogic_dataRegs_2 <= io_input_cmd_payload_fragment_data;
    end
    rspArea_readLogic_selReg <= rspArea_readLogic_sel;
    if(io_input_rsp_fire) begin
      rspArea_readLogic_selReg <= (rspArea_readLogic_sel + 2'b01);
    end
  end


endmodule
