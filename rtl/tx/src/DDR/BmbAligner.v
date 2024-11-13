// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : BmbAligner
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module BmbAligner (
  input  wire          io_input_cmd_valid,
  output wire          io_input_cmd_ready,
  input  wire          io_input_cmd_payload_last,
  input  wire [0:0]    io_input_cmd_payload_fragment_opcode,
  input  wire [28:0]   io_input_cmd_payload_fragment_address,
  input  wire [9:0]    io_input_cmd_payload_fragment_length,
  input  wire [31:0]   io_input_cmd_payload_fragment_data,
  input  wire [3:0]    io_input_cmd_payload_fragment_mask,
  input  wire [3:0]    io_input_cmd_payload_fragment_context,
  output wire          io_input_rsp_valid,
  input  wire          io_input_rsp_ready,
  output reg           io_input_rsp_payload_last,
  output wire [0:0]    io_input_rsp_payload_fragment_opcode,
  output wire [31:0]   io_input_rsp_payload_fragment_data,
  output wire [3:0]    io_input_rsp_payload_fragment_context,
  output wire          io_output_cmd_valid,
  input  wire          io_output_cmd_ready,
  output reg           io_output_cmd_payload_last,
  output wire [0:0]    io_output_cmd_payload_fragment_opcode,
  output wire [28:0]   io_output_cmd_payload_fragment_address,
  output wire [10:0]   io_output_cmd_payload_fragment_length,
  output wire [31:0]   io_output_cmd_payload_fragment_data,
  output wire [3:0]    io_output_cmd_payload_fragment_mask,
  output wire [15:0]   io_output_cmd_payload_fragment_context,
  input  wire          io_output_rsp_valid,
  output reg           io_output_rsp_ready,
  input  wire          io_output_rsp_payload_last,
  input  wire [0:0]    io_output_rsp_payload_fragment_opcode,
  input  wire [31:0]   io_output_rsp_payload_fragment_data,
  input  wire [15:0]   io_output_rsp_payload_fragment_context,
  input  wire          clk_out4,
  input  wire          rstN
);

  wire       [10:0]   _zz_io_output_cmd_payload_fragment_length;
  wire       [10:0]   _zz_io_output_cmd_payload_fragment_length_1;
  wire       [3:0]    _zz_io_output_cmd_payload_fragment_length_2;
  wire       [10:0]   _zz_io_output_cmd_payload_fragment_length_3;
  wire       [1:0]    _zz_logic_cmdLogic_forWrite_beatCounter;
  wire       [0:0]    _zz_logic_cmdLogic_forWrite_beatCounter_1;
  wire       [10:0]   _zz_logic_cmdLogic_context_transfers;
  wire       [10:0]   _zz_logic_cmdLogic_context_transfers_1;
  wire       [1:0]    _zz_logic_cmdLogic_context_transfers_2;
  wire       [1:0]    _zz_logic_rspLogic_forRead_beatCounter;
  wire       [0:0]    _zz_logic_rspLogic_forRead_beatCounter_1;
  wire       [1:0]    logic_cmdLogic_paddings;
  wire                logic_cmdLogic_context_write;
  wire       [1:0]    logic_cmdLogic_context_paddings;
  wire       [8:0]    logic_cmdLogic_context_transfers;
  wire       [3:0]    logic_cmdLogic_context_input;
  reg                 logic_cmdLogic_inputReadyOk;
  reg        [1:0]    logic_cmdLogic_forWrite_beatCounter;
  wire                io_output_cmd_fire;
  wire                io_input_cmd_fire;
  reg                 io_input_cmd_payload_first;
  wire                logic_cmdLogic_forWrite_prePadding;
  reg                 logic_cmdLogic_forWrite_postPadding;
  wire                when_BmbSpliter_l93;
  wire                when_BmbSpliter_l95;
  wire                when_BmbSpliter_l98;
  reg        [9:0]    logic_cmdLogic_lengthReg;
  reg        [28:0]   logic_cmdLogic_addressReg;
  wire       [9:0]    logic_cmdLogic_length;
  wire       [28:0]   logic_cmdLogic_address;
  wire                when_BmbSpliter_l118;
  wire                when_BmbSpliter_l119;
  wire                logic_rspLogic_context_write;
  wire       [1:0]    logic_rspLogic_context_paddings;
  wire       [8:0]    logic_rspLogic_context_transfers;
  wire       [3:0]    logic_rspLogic_context_input;
  wire       [15:0]   _zz_logic_rspLogic_context_write;
  reg                 logic_rspLogic_drop;
  reg                 io_output_rsp_thrown_valid;
  wire                io_output_rsp_thrown_ready;
  wire                io_output_rsp_thrown_payload_last;
  wire       [0:0]    io_output_rsp_thrown_payload_fragment_opcode;
  wire       [31:0]   io_output_rsp_thrown_payload_fragment_data;
  wire       [15:0]   io_output_rsp_thrown_payload_fragment_context;
  reg        [1:0]    logic_rspLogic_forRead_beatCounter;
  wire                io_output_rsp_fire;
  reg        [8:0]    logic_rspLogic_forRead_transferCounter;
  wire                io_input_rsp_fire;
  wire                when_BmbSpliter_l149;
  reg                 io_input_rsp_payload_first;
  wire                when_BmbSpliter_l153;
  wire                when_BmbSpliter_l157;

  assign _zz_io_output_cmd_payload_fragment_length = (_zz_io_output_cmd_payload_fragment_length_1 + _zz_io_output_cmd_payload_fragment_length_3);
  assign _zz_io_output_cmd_payload_fragment_length_2 = io_input_cmd_payload_fragment_address[3 : 0];
  assign _zz_io_output_cmd_payload_fragment_length_1 = {7'd0, _zz_io_output_cmd_payload_fragment_length_2};
  assign _zz_io_output_cmd_payload_fragment_length_3 = {1'd0, io_input_cmd_payload_fragment_length};
  assign _zz_logic_cmdLogic_forWrite_beatCounter_1 = (io_output_cmd_fire && (io_input_cmd_payload_fragment_opcode == 1'b1));
  assign _zz_logic_cmdLogic_forWrite_beatCounter = {1'd0, _zz_logic_cmdLogic_forWrite_beatCounter_1};
  assign _zz_logic_cmdLogic_context_transfers = ({1'b0,logic_cmdLogic_length} + _zz_logic_cmdLogic_context_transfers_1);
  assign _zz_logic_cmdLogic_context_transfers_2 = logic_cmdLogic_address[1 : 0];
  assign _zz_logic_cmdLogic_context_transfers_1 = {9'd0, _zz_logic_cmdLogic_context_transfers_2};
  assign _zz_logic_rspLogic_forRead_beatCounter_1 = (! logic_rspLogic_context_write);
  assign _zz_logic_rspLogic_forRead_beatCounter = {1'd0, _zz_logic_rspLogic_forRead_beatCounter_1};
  assign io_output_cmd_valid = io_input_cmd_valid;
  assign io_output_cmd_payload_fragment_address = ({4'd0,io_input_cmd_payload_fragment_address[28 : 4]} <<< 3'd4);
  assign io_output_cmd_payload_fragment_opcode = io_input_cmd_payload_fragment_opcode;
  assign io_output_cmd_payload_fragment_length = (_zz_io_output_cmd_payload_fragment_length | 11'h00f);
  always @(*) begin
    io_output_cmd_payload_last = 1'b0;
    if(when_BmbSpliter_l95) begin
      io_output_cmd_payload_last = 1'b1;
    end
    if(when_BmbSpliter_l118) begin
      io_output_cmd_payload_last = 1'b1;
    end
  end

  assign logic_cmdLogic_paddings = io_input_cmd_payload_fragment_address[3 : 2];
  assign logic_cmdLogic_context_input = io_input_cmd_payload_fragment_context;
  assign logic_cmdLogic_context_write = (io_input_cmd_payload_fragment_opcode == 1'b1);
  assign io_output_cmd_payload_fragment_context = {logic_cmdLogic_context_input,{logic_cmdLogic_context_transfers,{logic_cmdLogic_context_paddings,logic_cmdLogic_context_write}}};
  always @(*) begin
    logic_cmdLogic_inputReadyOk = 1'b0;
    if(when_BmbSpliter_l98) begin
      logic_cmdLogic_inputReadyOk = 1'b1;
    end
    if(when_BmbSpliter_l119) begin
      logic_cmdLogic_inputReadyOk = 1'b1;
    end
  end

  assign io_input_cmd_ready = (io_output_cmd_ready && logic_cmdLogic_inputReadyOk);
  assign io_output_cmd_fire = (io_output_cmd_valid && io_output_cmd_ready);
  assign io_input_cmd_fire = (io_input_cmd_valid && io_input_cmd_ready);
  assign logic_cmdLogic_forWrite_prePadding = (((io_input_cmd_payload_fragment_opcode == 1'b1) && io_input_cmd_payload_first) && (logic_cmdLogic_forWrite_beatCounter < logic_cmdLogic_paddings));
  assign when_BmbSpliter_l93 = (((! logic_cmdLogic_forWrite_prePadding) && io_output_cmd_fire) && io_input_cmd_payload_last);
  assign when_BmbSpliter_l95 = (io_input_cmd_payload_last && (logic_cmdLogic_forWrite_beatCounter == 2'b11));
  assign io_output_cmd_payload_fragment_data = io_input_cmd_payload_fragment_data;
  assign io_output_cmd_payload_fragment_mask = ((! (logic_cmdLogic_forWrite_prePadding || logic_cmdLogic_forWrite_postPadding)) ? io_input_cmd_payload_fragment_mask : 4'b0000);
  assign when_BmbSpliter_l98 = ((! logic_cmdLogic_forWrite_prePadding) && (! (io_input_cmd_payload_last && (logic_cmdLogic_forWrite_beatCounter != 2'b11))));
  assign logic_cmdLogic_length = (io_input_cmd_fire ? io_input_cmd_payload_fragment_length : logic_cmdLogic_lengthReg);
  assign logic_cmdLogic_address = (io_input_cmd_fire ? io_input_cmd_payload_fragment_address : logic_cmdLogic_addressReg);
  assign when_BmbSpliter_l118 = (io_input_cmd_payload_fragment_opcode == 1'b0);
  assign when_BmbSpliter_l119 = (io_input_cmd_payload_fragment_opcode == 1'b0);
  assign logic_cmdLogic_context_paddings = logic_cmdLogic_paddings;
  assign logic_cmdLogic_context_transfers = _zz_logic_cmdLogic_context_transfers[10 : 2];
  assign _zz_logic_rspLogic_context_write = io_output_rsp_payload_fragment_context;
  assign logic_rspLogic_context_write = _zz_logic_rspLogic_context_write[0];
  assign logic_rspLogic_context_paddings = _zz_logic_rspLogic_context_write[2 : 1];
  assign logic_rspLogic_context_transfers = _zz_logic_rspLogic_context_write[11 : 3];
  assign logic_rspLogic_context_input = _zz_logic_rspLogic_context_write[15 : 12];
  always @(*) begin
    logic_rspLogic_drop = 1'b0;
    if(when_BmbSpliter_l153) begin
      logic_rspLogic_drop = 1'b1;
    end
  end

  always @(*) begin
    io_output_rsp_thrown_valid = io_output_rsp_valid;
    if(logic_rspLogic_drop) begin
      io_output_rsp_thrown_valid = 1'b0;
    end
  end

  always @(*) begin
    io_output_rsp_ready = io_output_rsp_thrown_ready;
    if(logic_rspLogic_drop) begin
      io_output_rsp_ready = 1'b1;
    end
  end

  assign io_output_rsp_thrown_payload_last = io_output_rsp_payload_last;
  assign io_output_rsp_thrown_payload_fragment_opcode = io_output_rsp_payload_fragment_opcode;
  assign io_output_rsp_thrown_payload_fragment_data = io_output_rsp_payload_fragment_data;
  assign io_output_rsp_thrown_payload_fragment_context = io_output_rsp_payload_fragment_context;
  assign io_input_rsp_valid = io_output_rsp_thrown_valid;
  assign io_output_rsp_thrown_ready = io_input_rsp_ready;
  always @(*) begin
    io_input_rsp_payload_last = 1'b0;
    if(logic_rspLogic_context_write) begin
      io_input_rsp_payload_last = 1'b0;
    end
    if(when_BmbSpliter_l157) begin
      io_input_rsp_payload_last = 1'b1;
    end
  end

  assign io_input_rsp_payload_fragment_opcode = io_output_rsp_payload_fragment_opcode;
  assign io_input_rsp_payload_fragment_context = logic_rspLogic_context_input;
  assign io_output_rsp_fire = (io_output_rsp_valid && io_output_rsp_ready);
  assign io_input_rsp_fire = (io_input_rsp_valid && io_input_rsp_ready);
  assign when_BmbSpliter_l149 = (io_output_rsp_fire && io_output_rsp_payload_last);
  assign when_BmbSpliter_l153 = ((! logic_rspLogic_context_write) && ((io_input_rsp_payload_first && (logic_rspLogic_forRead_beatCounter[1 : 0] < logic_rspLogic_context_paddings)) || (logic_rspLogic_context_transfers < logic_rspLogic_forRead_transferCounter)));
  assign when_BmbSpliter_l157 = (logic_rspLogic_forRead_transferCounter == logic_rspLogic_context_transfers);
  assign io_input_rsp_payload_fragment_data = io_output_rsp_payload_fragment_data;
  always @(posedge clk_out4 or negedge rstN) begin
    if(!rstN) begin
      logic_cmdLogic_forWrite_beatCounter <= 2'b00;
      io_input_cmd_payload_first <= 1'b1;
      logic_cmdLogic_forWrite_postPadding <= 1'b0;
      logic_cmdLogic_lengthReg <= 10'h3ff;
      logic_cmdLogic_addressReg <= 29'h0;
      logic_rspLogic_forRead_beatCounter <= 2'b00;
      logic_rspLogic_forRead_transferCounter <= 9'h0;
      io_input_rsp_payload_first <= 1'b1;
    end else begin
      logic_cmdLogic_forWrite_beatCounter <= (logic_cmdLogic_forWrite_beatCounter + _zz_logic_cmdLogic_forWrite_beatCounter);
      if(io_input_cmd_fire) begin
        io_input_cmd_payload_first <= io_input_cmd_payload_last;
      end
      if(when_BmbSpliter_l93) begin
        logic_cmdLogic_forWrite_postPadding <= 1'b1;
      end
      if(io_input_cmd_ready) begin
        logic_cmdLogic_forWrite_postPadding <= 1'b0;
      end
      if(io_input_cmd_fire) begin
        logic_cmdLogic_lengthReg <= io_input_cmd_payload_fragment_length;
      end
      if(io_input_cmd_fire) begin
        logic_cmdLogic_addressReg <= io_input_cmd_payload_fragment_address;
      end
      if(io_output_rsp_fire) begin
        logic_rspLogic_forRead_beatCounter <= (logic_rspLogic_forRead_beatCounter + _zz_logic_rspLogic_forRead_beatCounter);
      end
      if(io_input_rsp_fire) begin
        logic_rspLogic_forRead_transferCounter <= (logic_rspLogic_forRead_transferCounter + 9'h001);
      end
      if(when_BmbSpliter_l149) begin
        logic_rspLogic_forRead_transferCounter <= 9'h0;
      end
      if(io_input_rsp_fire) begin
        io_input_rsp_payload_first <= io_input_rsp_payload_last;
      end
    end
  end


endmodule
