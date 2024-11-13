// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : BmbAlignedSpliter
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module BmbAlignedSpliter (
  input  wire          io_input_cmd_valid,
  output wire          io_input_cmd_ready,
  input  wire          io_input_cmd_payload_last,
  input  wire [0:0]    io_input_cmd_payload_fragment_opcode,
  input  wire [28:0]   io_input_cmd_payload_fragment_address,
  input  wire [10:0]   io_input_cmd_payload_fragment_length,
  input  wire [31:0]   io_input_cmd_payload_fragment_data,
  input  wire [3:0]    io_input_cmd_payload_fragment_mask,
  input  wire [15:0]   io_input_cmd_payload_fragment_context,
  output wire          io_input_rsp_valid,
  input  wire          io_input_rsp_ready,
  output wire          io_input_rsp_payload_last,
  output wire [0:0]    io_input_rsp_payload_fragment_opcode,
  output wire [31:0]   io_input_rsp_payload_fragment_data,
  output wire [15:0]   io_input_rsp_payload_fragment_context,
  output wire          io_output_cmd_valid,
  input  wire          io_output_cmd_ready,
  output wire          io_output_cmd_payload_last,
  output wire [0:0]    io_output_cmd_payload_fragment_opcode,
  output wire [28:0]   io_output_cmd_payload_fragment_address,
  output wire [5:0]    io_output_cmd_payload_fragment_length,
  output wire [31:0]   io_output_cmd_payload_fragment_data,
  output wire [3:0]    io_output_cmd_payload_fragment_mask,
  output wire [17:0]   io_output_cmd_payload_fragment_context,
  input  wire          io_output_rsp_valid,
  output wire          io_output_rsp_ready,
  input  wire          io_output_rsp_payload_last,
  input  wire [0:0]    io_output_rsp_payload_fragment_opcode,
  input  wire [31:0]   io_output_rsp_payload_fragment_data,
  input  wire [17:0]   io_output_rsp_payload_fragment_context,
  output wire          io_outputBurstLast,
  input  wire          clk_out4,
  input  wire          rstN
);

  wire       [11:0]   _zz_cmdLogic_lastAddress;
  wire       [5:0]    _zz_cmdLogic_lastAddress_1;
  wire       [4:0]    _zz_cmdLogic_beatsInSplit;
  wire       [3:0]    _zz_cmdLogic_beatsInSplit_1;
  wire       [4:0]    _zz_io_output_cmd_valid;
  wire       [4:0]    _zz_io_output_cmd_valid_1;
  wire       [4:0]    _zz_io_output_cmd_payload_last;
  wire       [4:0]    _zz_io_output_cmd_payload_last_1;
  wire       [4:0]    _zz_io_output_cmd_payload_last_2;
  wire       [4:0]    _zz_io_output_cmd_payload_last_3;
  wire       [11:0]   _zz_io_output_cmd_payload_fragment_address;
  wire       [11:0]   _zz_io_output_cmd_payload_fragment_address_1;
  wire       [4:0]    _zz_io_output_cmd_payload_fragment_opcode;
  wire       [4:0]    _zz_io_output_cmd_payload_fragment_opcode_1;
  wire       [3:0]    _zz_cmdLogic_wrBeatCounter;
  wire       [0:0]    _zz_cmdLogic_wrBeatCounter_1;
  wire       [5:0]    _zz_cmdLogic_splitCounter;
  wire       [0:0]    _zz_cmdLogic_splitCounter_1;
  reg        [3:0]    cmdLogic_wrBeatCounter;
  reg        [3:0]    cmdLogic_rdBeatCounter;
  reg        [5:0]    cmdLogic_splitCounter;
  wire                io_input_cmd_fire;
  reg        [10:0]   cmdLogic_lengthReg;
  reg        [28:0]   cmdLogic_addressReg;
  wire       [10:0]   cmdLogic_length;
  wire       [28:0]   cmdLogic_address;
  wire       [5:0]    cmdLogic_headLenghtMax;
  wire       [11:0]   cmdLogic_lastAddress;
  wire       [5:0]    cmdLogic_tailLength;
  wire       [5:0]    cmdLogic_splitCount;
  reg                 cmdLogic_firstSplit;
  wire                io_output_cmd_fire;
  wire                when_BmbSpliter_l210;
  wire                cmdLogic_lastSplit;
  wire                cmdLogic_usedSplit;
  reg        [28:0]   cmdLogic_addressBase;
  wire                when_BmbSpliter_l215;
  wire       [4:0]    cmdLogic_beatsInSplit;
  wire                cmdLogic_context_last;
  wire                cmdLogic_context_write;
  wire       [15:0]   cmdLogic_context_input;
  wire       [1:0]    switch_Misc_l241;
  reg        [5:0]    _zz_io_output_cmd_payload_fragment_length;
  wire                when_BmbSpliter_l247;
  reg                 cmdLogic_rdStart;
  wire                when_BmbSpliter_l256;
  wire                io_input_rsp_fire;
  wire                when_BmbSpliter_l256_1;
  wire                when_BmbSpliter_l259;
  wire                when_BmbSpliter_l264;
  wire                rspLogic_context_last;
  wire                rspLogic_context_write;
  wire       [15:0]   rspLogic_context_input;
  wire       [17:0]   _zz_rspLogic_context_last;

  assign _zz_cmdLogic_lastAddress_1 = cmdLogic_address[5 : 0];
  assign _zz_cmdLogic_lastAddress = {6'd0, _zz_cmdLogic_lastAddress_1};
  assign _zz_cmdLogic_beatsInSplit_1 = ((! cmdLogic_firstSplit) ? 4'b0000 : cmdLogic_address[5 : 2]);
  assign _zz_cmdLogic_beatsInSplit = {1'd0, _zz_cmdLogic_beatsInSplit_1};
  assign _zz_io_output_cmd_valid = {1'd0, cmdLogic_rdBeatCounter};
  assign _zz_io_output_cmd_valid_1 = (cmdLogic_beatsInSplit - 5'h01);
  assign _zz_io_output_cmd_payload_last = {1'd0, cmdLogic_wrBeatCounter};
  assign _zz_io_output_cmd_payload_last_1 = (cmdLogic_beatsInSplit - 5'h01);
  assign _zz_io_output_cmd_payload_last_2 = {1'd0, cmdLogic_rdBeatCounter};
  assign _zz_io_output_cmd_payload_last_3 = (cmdLogic_beatsInSplit - 5'h01);
  assign _zz_io_output_cmd_payload_fragment_address = (cmdLogic_addressBase[11 : 0] + _zz_io_output_cmd_payload_fragment_address_1);
  assign _zz_io_output_cmd_payload_fragment_address_1 = ({6'd0,cmdLogic_splitCounter} <<< 3'd6);
  assign _zz_io_output_cmd_payload_fragment_opcode = {1'd0, cmdLogic_rdBeatCounter};
  assign _zz_io_output_cmd_payload_fragment_opcode_1 = (cmdLogic_beatsInSplit - 5'h01);
  assign _zz_cmdLogic_wrBeatCounter_1 = (io_input_cmd_payload_fragment_opcode == 1'b1);
  assign _zz_cmdLogic_wrBeatCounter = {3'd0, _zz_cmdLogic_wrBeatCounter_1};
  assign _zz_cmdLogic_splitCounter_1 = 1'b1;
  assign _zz_cmdLogic_splitCounter = {5'd0, _zz_cmdLogic_splitCounter_1};
  assign io_input_cmd_fire = (io_input_cmd_valid && io_input_cmd_ready);
  assign cmdLogic_length = (io_input_cmd_fire ? io_input_cmd_payload_fragment_length : cmdLogic_lengthReg);
  assign cmdLogic_address = (io_input_cmd_fire ? io_input_cmd_payload_fragment_address : cmdLogic_addressReg);
  assign cmdLogic_headLenghtMax = (6'h3f - cmdLogic_address[5 : 0]);
  assign cmdLogic_lastAddress = (_zz_cmdLogic_lastAddress + {1'b0,cmdLogic_length});
  assign cmdLogic_tailLength = cmdLogic_lastAddress[5 : 0];
  assign cmdLogic_splitCount = (cmdLogic_lastAddress >>> 3'd6);
  assign io_output_cmd_fire = (io_output_cmd_valid && io_output_cmd_ready);
  assign when_BmbSpliter_l210 = (io_output_cmd_fire && io_output_cmd_payload_last);
  assign cmdLogic_lastSplit = (cmdLogic_splitCounter == cmdLogic_splitCount);
  assign cmdLogic_usedSplit = ((cmdLogic_splitCounter <= cmdLogic_splitCount) && (cmdLogic_splitCounter != 6'h0));
  always @(*) begin
    cmdLogic_addressBase = cmdLogic_address;
    if(when_BmbSpliter_l215) begin
      cmdLogic_addressBase[5 : 0] = 6'h0;
    end
  end

  assign when_BmbSpliter_l215 = (! cmdLogic_firstSplit);
  assign cmdLogic_beatsInSplit = (5'h10 - _zz_cmdLogic_beatsInSplit);
  assign cmdLogic_context_input = io_input_cmd_payload_fragment_context;
  assign cmdLogic_context_last = cmdLogic_lastSplit;
  assign cmdLogic_context_write = (io_input_cmd_payload_fragment_opcode == 1'b1);
  assign io_output_cmd_valid = (io_input_cmd_valid || ((_zz_io_output_cmd_valid == _zz_io_output_cmd_valid_1) && cmdLogic_usedSplit));
  assign io_output_cmd_payload_last = ((io_input_cmd_payload_last || (((_zz_io_output_cmd_payload_last == _zz_io_output_cmd_payload_last_1) && io_input_cmd_fire) && (io_input_cmd_payload_fragment_opcode == 1'b1))) || ((_zz_io_output_cmd_payload_last_2 == _zz_io_output_cmd_payload_last_3) && cmdLogic_usedSplit));
  assign io_output_cmd_payload_fragment_address = {cmdLogic_addressBase[28 : 12],_zz_io_output_cmd_payload_fragment_address};
  assign io_output_cmd_payload_fragment_context = {cmdLogic_context_input,{cmdLogic_context_write,cmdLogic_context_last}};
  assign io_output_cmd_payload_fragment_opcode = (io_input_cmd_payload_fragment_opcode & (~ ((_zz_io_output_cmd_payload_fragment_opcode == _zz_io_output_cmd_payload_fragment_opcode_1) && cmdLogic_usedSplit)));
  assign switch_Misc_l241 = {cmdLogic_firstSplit,cmdLogic_lastSplit};
  always @(*) begin
    case(switch_Misc_l241)
      2'b10 : begin
        _zz_io_output_cmd_payload_fragment_length = cmdLogic_headLenghtMax;
      end
      2'b00 : begin
        _zz_io_output_cmd_payload_fragment_length = 6'h3f;
      end
      2'b01 : begin
        _zz_io_output_cmd_payload_fragment_length = cmdLogic_tailLength;
      end
      default : begin
        _zz_io_output_cmd_payload_fragment_length = cmdLogic_length[5:0];
      end
    endcase
  end

  assign io_output_cmd_payload_fragment_length = _zz_io_output_cmd_payload_fragment_length;
  assign io_output_cmd_payload_fragment_data = io_input_cmd_payload_fragment_data;
  assign io_output_cmd_payload_fragment_mask = io_input_cmd_payload_fragment_mask;
  assign io_outputBurstLast = cmdLogic_context_last;
  assign io_input_cmd_ready = io_output_cmd_ready;
  assign when_BmbSpliter_l247 = (io_input_cmd_payload_fragment_opcode == 1'b1);
  assign when_BmbSpliter_l256 = (io_input_cmd_valid && (io_input_cmd_payload_fragment_opcode == 1'b0));
  assign io_input_rsp_fire = (io_input_rsp_valid && io_input_rsp_ready);
  assign when_BmbSpliter_l256_1 = (io_input_rsp_fire && io_input_rsp_payload_last);
  assign when_BmbSpliter_l259 = (io_output_cmd_fire && io_output_cmd_payload_last);
  assign when_BmbSpliter_l264 = (((io_input_cmd_fire && io_input_cmd_payload_last) && (io_input_cmd_payload_fragment_opcode == 1'b1)) || (io_input_rsp_fire && io_input_rsp_payload_last));
  assign _zz_rspLogic_context_last = io_output_rsp_payload_fragment_context;
  assign rspLogic_context_last = _zz_rspLogic_context_last[0];
  assign rspLogic_context_write = _zz_rspLogic_context_last[1];
  assign rspLogic_context_input = _zz_rspLogic_context_last[17 : 2];
  assign io_input_rsp_valid = io_output_rsp_valid;
  assign io_output_rsp_ready = io_input_rsp_ready;
  assign io_input_rsp_payload_last = (io_output_rsp_payload_last && rspLogic_context_last);
  assign io_input_rsp_payload_fragment_opcode = io_output_rsp_payload_fragment_opcode;
  assign io_input_rsp_payload_fragment_data = io_output_rsp_payload_fragment_data;
  assign io_input_rsp_payload_fragment_context = rspLogic_context_input;
  always @(posedge clk_out4 or negedge rstN) begin
    if(!rstN) begin
      cmdLogic_wrBeatCounter <= 4'b0000;
      cmdLogic_rdBeatCounter <= 4'b0000;
      cmdLogic_splitCounter <= 6'h0;
      cmdLogic_lengthReg <= 11'h03f;
      cmdLogic_addressReg <= 29'h0;
      cmdLogic_firstSplit <= 1'b1;
      cmdLogic_rdStart <= 1'b0;
    end else begin
      if(io_input_cmd_fire) begin
        cmdLogic_lengthReg <= io_input_cmd_payload_fragment_length;
      end
      if(io_input_cmd_fire) begin
        cmdLogic_addressReg <= io_input_cmd_payload_fragment_address;
      end
      if(when_BmbSpliter_l210) begin
        cmdLogic_firstSplit <= 1'b0;
      end
      if(io_output_cmd_fire) begin
        if(when_BmbSpliter_l247) begin
          cmdLogic_wrBeatCounter <= (cmdLogic_wrBeatCounter + _zz_cmdLogic_wrBeatCounter);
        end
        if(io_output_cmd_payload_last) begin
          cmdLogic_splitCounter <= (cmdLogic_splitCounter + _zz_cmdLogic_splitCounter);
          cmdLogic_wrBeatCounter <= 4'b0000;
        end
      end
      if(when_BmbSpliter_l256) begin
        cmdLogic_rdStart <= 1'b1;
      end
      if(when_BmbSpliter_l256_1) begin
        cmdLogic_rdStart <= 1'b0;
      end
      if(cmdLogic_rdStart) begin
        cmdLogic_rdBeatCounter <= (cmdLogic_rdBeatCounter + 4'b0001);
        if(when_BmbSpliter_l259) begin
          cmdLogic_rdBeatCounter <= 4'b0000;
        end
      end else begin
        cmdLogic_rdBeatCounter <= 4'b0000;
      end
      if(when_BmbSpliter_l264) begin
        cmdLogic_splitCounter <= 6'h0;
        cmdLogic_firstSplit <= 1'b1;
      end
    end
  end


endmodule
