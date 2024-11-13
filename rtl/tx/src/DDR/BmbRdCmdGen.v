// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : BmbRdCmdGen
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module BmbRdCmdGen (
  input  wire          io_start,
  input  wire          io_handShake_valid,
  output reg           io_handShake_ready,
  input  wire [28:0]   io_address,
  output wire [9:0]    io_length,
  output reg           io_bmbCmd_valid,
  input  wire          io_bmbCmd_ready,
  output reg           io_bmbCmd_payload_last,
  output reg  [0:0]    io_bmbCmd_payload_fragment_opcode,
  output reg  [28:0]   io_bmbCmd_payload_fragment_address,
  output reg  [9:0]    io_bmbCmd_payload_fragment_length,
  output wire [31:0]   io_bmbCmd_payload_fragment_data,
  output wire [3:0]    io_bmbCmd_payload_fragment_mask,
  output wire [3:0]    io_bmbCmd_payload_fragment_context,
  output reg           io_end,
  input  wire          clk_out4,
  input  wire          rstN
);
  localparam StateMachineEnum_ = 3'd0;
  localparam StateMachineEnum__1 = 3'd1;
  localparam StateMachineEnum__2 = 3'd2;
  localparam StateMachineEnum__3 = 3'd3;
  localparam StateMachineEnum__4 = 3'd4;

  wire       [19:0]   _zz_counter_valueNext;
  wire       [0:0]    _zz_counter_valueNext_1;
  wire       [28:0]   _zz_addressBridge;
  wire       [9:0]    _zz_addressBridge_1;
  wire       [18:0]   _zz_when_BmbRdCmdGen_l40;
  wire       [18:0]   _zz_when_BmbRdCmdGen_l40_1;
  wire       [18:0]   _zz_when_BmbRdCmdGen_l40_1_1;
  wire       [18:0]   _zz_when_BmbRdCmdGen_l40_1_2;
  wire                _zz_when;
  wire       [29:0]   _zz_io_bmbCmd_payload_fragment_address;
  wire       [18:0]   _zz_when_BmbRdCmdGen_l57;
  wire       [18:0]   _zz_when_BmbRdCmdGen_l57_1;
  wire                _zz_when_1;
  wire       [29:0]   _zz_io_bmbCmd_payload_fragment_address_1;
  wire       [18:0]   _zz_when_BmbRdCmdGen_l57_1_1;
  wire       [18:0]   _zz_when_BmbRdCmdGen_l57_1_2;
  reg                 start;
  wire                pipeline_valid;
  reg                 pipeline_ready;
  (* async_reg = "true" *) reg        [9:0]    lengthReg;
  reg                 counter_willIncrement;
  reg                 counter_willClear;
  reg        [19:0]   counter_valueNext;
  reg        [19:0]   counter_value;
  wire                counter_willOverflowIfInc;
  wire                counter_willOverflow;
  wire                io_handShake_m2sPipe_valid;
  wire                io_handShake_m2sPipe_ready;
  reg                 io_handShake_rValid;
  wire                when_Stream_l393;
  wire       [28:0]   addressBridge;
  reg                 _zz_1;
  reg        [2:0]    _zz_when_BmbRdCmdGen_l49;
  reg        [2:0]    _zz_when_BmbRdCmdGen_l49_1;
  wire                when_BmbRdCmdGen_l40;
  wire                when_BmbRdCmdGen_l40_1;
  wire                when_BmbRdCmdGen_l49;
  wire                when_BmbRdCmdGen_l57;
  wire                when_BmbRdCmdGen_l49_1;
  wire                when_BmbRdCmdGen_l57_1;
  `ifndef SYNTHESIS
  reg [15:0] _zz_when_BmbRdCmdGen_l49_string;
  reg [15:0] _zz_when_BmbRdCmdGen_l49_1_string;
  `endif


  assign _zz_when = ((_zz_when_BmbRdCmdGen_l49_1 != StateMachineEnum__2) && (_zz_when_BmbRdCmdGen_l49 == StateMachineEnum__2));
  assign _zz_when_1 = ((_zz_when_BmbRdCmdGen_l49_1 != StateMachineEnum__3) && (_zz_when_BmbRdCmdGen_l49 == StateMachineEnum__3));
  assign _zz_counter_valueNext_1 = counter_willIncrement;
  assign _zz_counter_valueNext = {19'd0, _zz_counter_valueNext_1};
  assign _zz_addressBridge_1 = 10'h3ff;
  assign _zz_addressBridge = {19'd0, _zz_addressBridge_1};
  assign _zz_when_BmbRdCmdGen_l40 = counter_value[18:0];
  assign _zz_when_BmbRdCmdGen_l40_1 = (addressBridge >>> 4'd10);
  assign _zz_when_BmbRdCmdGen_l40_1_1 = counter_value[18:0];
  assign _zz_when_BmbRdCmdGen_l40_1_2 = (addressBridge >>> 4'd10);
  assign _zz_io_bmbCmd_payload_fragment_address = ({10'd0,counter_value} <<< 4'd10);
  assign _zz_when_BmbRdCmdGen_l57 = counter_valueNext[18:0];
  assign _zz_when_BmbRdCmdGen_l57_1 = (addressBridge >>> 4'd10);
  assign _zz_io_bmbCmd_payload_fragment_address_1 = ({10'd0,counter_value} <<< 4'd10);
  assign _zz_when_BmbRdCmdGen_l57_1_1 = counter_valueNext[18:0];
  assign _zz_when_BmbRdCmdGen_l57_1_2 = (addressBridge >>> 4'd10);
  `ifndef SYNTHESIS
  always @(*) begin
    case(_zz_when_BmbRdCmdGen_l49)
      StateMachineEnum_ : _zz_when_BmbRdCmdGen_l49_string = "  ";
      StateMachineEnum__1 : _zz_when_BmbRdCmdGen_l49_string = "_1";
      StateMachineEnum__2 : _zz_when_BmbRdCmdGen_l49_string = "_2";
      StateMachineEnum__3 : _zz_when_BmbRdCmdGen_l49_string = "_3";
      StateMachineEnum__4 : _zz_when_BmbRdCmdGen_l49_string = "_4";
      default : _zz_when_BmbRdCmdGen_l49_string = "??";
    endcase
  end
  always @(*) begin
    case(_zz_when_BmbRdCmdGen_l49_1)
      StateMachineEnum_ : _zz_when_BmbRdCmdGen_l49_1_string = "  ";
      StateMachineEnum__1 : _zz_when_BmbRdCmdGen_l49_1_string = "_1";
      StateMachineEnum__2 : _zz_when_BmbRdCmdGen_l49_1_string = "_2";
      StateMachineEnum__3 : _zz_when_BmbRdCmdGen_l49_1_string = "_3";
      StateMachineEnum__4 : _zz_when_BmbRdCmdGen_l49_1_string = "_4";
      default : _zz_when_BmbRdCmdGen_l49_1_string = "??";
    endcase
  end
  `endif

  always @(*) begin
    io_bmbCmd_valid = 1'b0;
    if(start) begin
      if(_zz_when) begin
        if(when_BmbRdCmdGen_l49) begin
          io_bmbCmd_valid = 1'b1;
        end
      end
      if(_zz_when_1) begin
        if(when_BmbRdCmdGen_l49_1) begin
          io_bmbCmd_valid = 1'b1;
        end
      end
    end
  end

  always @(*) begin
    io_bmbCmd_payload_last = 1'b0;
    if(start) begin
      if(_zz_when) begin
        if(when_BmbRdCmdGen_l49) begin
          io_bmbCmd_payload_last = 1'b1;
        end
      end
      if(_zz_when_1) begin
        if(when_BmbRdCmdGen_l49_1) begin
          io_bmbCmd_payload_last = 1'b1;
        end
      end
    end
  end

  always @(*) begin
    io_bmbCmd_payload_fragment_opcode = 1'b1;
    if(start) begin
      if(_zz_when) begin
        if(when_BmbRdCmdGen_l49) begin
          io_bmbCmd_payload_fragment_opcode = 1'b0;
        end
      end
      if(_zz_when_1) begin
        if(when_BmbRdCmdGen_l49_1) begin
          io_bmbCmd_payload_fragment_opcode = 1'b0;
        end
      end
    end
  end

  always @(*) begin
    io_bmbCmd_payload_fragment_address = 29'h0;
    if(start) begin
      if(_zz_when) begin
        if(when_BmbRdCmdGen_l49) begin
          io_bmbCmd_payload_fragment_address = _zz_io_bmbCmd_payload_fragment_address[28:0];
        end
      end
      if(_zz_when_1) begin
        if(when_BmbRdCmdGen_l49_1) begin
          io_bmbCmd_payload_fragment_address = _zz_io_bmbCmd_payload_fragment_address_1[28:0];
        end
      end
    end
  end

  always @(*) begin
    io_bmbCmd_payload_fragment_length = 10'h0;
    if(start) begin
      if(_zz_when) begin
        if(when_BmbRdCmdGen_l49) begin
          if(when_BmbRdCmdGen_l57) begin
            io_bmbCmd_payload_fragment_length = (io_address[9 : 0] - 10'h001);
          end else begin
            io_bmbCmd_payload_fragment_length = 10'h3ff;
          end
        end
      end
      if(_zz_when_1) begin
        if(when_BmbRdCmdGen_l49_1) begin
          if(when_BmbRdCmdGen_l57_1) begin
            io_bmbCmd_payload_fragment_length = (io_address[9 : 0] - 10'h001);
          end else begin
            io_bmbCmd_payload_fragment_length = 10'h3ff;
          end
        end
      end
    end
  end

  assign io_bmbCmd_payload_fragment_data = 32'h0;
  assign io_bmbCmd_payload_fragment_mask = 4'b0000;
  assign io_bmbCmd_payload_fragment_context = 4'b0000;
  assign io_length = lengthReg;
  always @(*) begin
    counter_willIncrement = 1'b0;
    if(start) begin
      if(_zz_when) begin
        if(when_BmbRdCmdGen_l49) begin
          counter_willIncrement = 1'b1;
        end
      end
      if(_zz_when_1) begin
        if(when_BmbRdCmdGen_l49_1) begin
          counter_willIncrement = 1'b1;
        end
      end
    end
  end

  always @(*) begin
    counter_willClear = 1'b0;
    if(start) begin
      case(_zz_when_BmbRdCmdGen_l49)
        StateMachineEnum__1 : begin
        end
        StateMachineEnum__2 : begin
        end
        StateMachineEnum__3 : begin
        end
        StateMachineEnum__4 : begin
          counter_willClear = 1'b1;
        end
        default : begin
        end
      endcase
    end
  end

  assign counter_willOverflowIfInc = (counter_value == 20'h80000);
  assign counter_willOverflow = (counter_willOverflowIfInc && counter_willIncrement);
  always @(*) begin
    if(counter_willOverflow) begin
      counter_valueNext = 20'h0;
    end else begin
      counter_valueNext = (counter_value + _zz_counter_valueNext);
    end
    if(counter_willClear) begin
      counter_valueNext = 20'h0;
    end
  end

  always @(*) begin
    io_handShake_ready = io_handShake_m2sPipe_ready;
    if(when_Stream_l393) begin
      io_handShake_ready = 1'b1;
    end
  end

  assign when_Stream_l393 = (! io_handShake_m2sPipe_valid);
  assign io_handShake_m2sPipe_valid = io_handShake_rValid;
  assign pipeline_valid = io_handShake_m2sPipe_valid;
  assign io_handShake_m2sPipe_ready = pipeline_ready;
  always @(*) begin
    pipeline_ready = 1'b0;
    if(start) begin
      if(_zz_when) begin
        if(when_BmbRdCmdGen_l49) begin
          pipeline_ready = 1'b1;
        end
      end
      if(_zz_when_1) begin
        if(when_BmbRdCmdGen_l49_1) begin
          pipeline_ready = 1'b1;
        end
      end
    end
  end

  assign addressBridge = (io_address + _zz_addressBridge);
  always @(*) begin
    io_end = 1'b0;
    if(start) begin
      case(_zz_when_BmbRdCmdGen_l49)
        StateMachineEnum__1 : begin
        end
        StateMachineEnum__2 : begin
        end
        StateMachineEnum__3 : begin
        end
        StateMachineEnum__4 : begin
          io_end = 1'b1;
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    _zz_1 = 1'b0;
    case(_zz_when_BmbRdCmdGen_l49)
      StateMachineEnum__1 : begin
      end
      StateMachineEnum__2 : begin
      end
      StateMachineEnum__3 : begin
      end
      StateMachineEnum__4 : begin
      end
      default : begin
        _zz_1 = 1'b1;
      end
    endcase
  end

  always @(*) begin
    _zz_when_BmbRdCmdGen_l49_1 = _zz_when_BmbRdCmdGen_l49;
    case(_zz_when_BmbRdCmdGen_l49)
      StateMachineEnum__1 : begin
        if(start) begin
          _zz_when_BmbRdCmdGen_l49_1 = StateMachineEnum__2;
        end
      end
      StateMachineEnum__2 : begin
        if(when_BmbRdCmdGen_l40) begin
          _zz_when_BmbRdCmdGen_l49_1 = StateMachineEnum__4;
        end else begin
          if(pipeline_valid) begin
            _zz_when_BmbRdCmdGen_l49_1 = StateMachineEnum__3;
          end
        end
      end
      StateMachineEnum__3 : begin
        if(when_BmbRdCmdGen_l40_1) begin
          _zz_when_BmbRdCmdGen_l49_1 = StateMachineEnum__4;
        end else begin
          if(pipeline_valid) begin
            _zz_when_BmbRdCmdGen_l49_1 = StateMachineEnum__2;
          end
        end
      end
      StateMachineEnum__4 : begin
        _zz_when_BmbRdCmdGen_l49_1 = StateMachineEnum__1;
      end
      default : begin
      end
    endcase
    if(_zz_1) begin
      _zz_when_BmbRdCmdGen_l49_1 = StateMachineEnum__1;
    end
    if(1'b0) begin
      _zz_when_BmbRdCmdGen_l49_1 = StateMachineEnum_;
    end
  end

  assign when_BmbRdCmdGen_l40 = (_zz_when_BmbRdCmdGen_l40 == _zz_when_BmbRdCmdGen_l40_1);
  assign when_BmbRdCmdGen_l40_1 = (_zz_when_BmbRdCmdGen_l40_1_1 == _zz_when_BmbRdCmdGen_l40_1_2);
  assign when_BmbRdCmdGen_l49 = (! ((_zz_when_BmbRdCmdGen_l49_1 == StateMachineEnum__4) && (_zz_when_BmbRdCmdGen_l49 != StateMachineEnum__4)));
  assign when_BmbRdCmdGen_l57 = (_zz_when_BmbRdCmdGen_l57 == _zz_when_BmbRdCmdGen_l57_1);
  assign when_BmbRdCmdGen_l49_1 = (! ((_zz_when_BmbRdCmdGen_l49_1 == StateMachineEnum__4) && (_zz_when_BmbRdCmdGen_l49 != StateMachineEnum__4)));
  assign when_BmbRdCmdGen_l57_1 = (_zz_when_BmbRdCmdGen_l57_1_1 == _zz_when_BmbRdCmdGen_l57_1_2);
  always @(posedge clk_out4 or negedge rstN) begin
    if(!rstN) begin
      start <= 1'b0;
      lengthReg <= 10'h0;
      counter_value <= 20'h0;
      io_handShake_rValid <= 1'b0;
    end else begin
      if(io_end) begin
        start <= 1'b0;
      end
      if(io_start) begin
        start <= 1'b1;
      end
      counter_value <= counter_valueNext;
      if(io_handShake_ready) begin
        io_handShake_rValid <= io_handShake_valid;
      end
      if(start) begin
        if(_zz_when) begin
          if(when_BmbRdCmdGen_l49) begin
            lengthReg <= io_bmbCmd_payload_fragment_length;
          end
        end
        if(_zz_when_1) begin
          if(when_BmbRdCmdGen_l49_1) begin
            lengthReg <= io_bmbCmd_payload_fragment_length;
          end
        end
      end
    end
  end

  always @(posedge clk_out4 or negedge rstN) begin
    if(!rstN) begin
      _zz_when_BmbRdCmdGen_l49 <= StateMachineEnum_;
    end else begin
      _zz_when_BmbRdCmdGen_l49 <= _zz_when_BmbRdCmdGen_l49_1;
    end
  end


endmodule
