// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : ConfigRx
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module ConfigRx (
  input  wire          io_udpAxisIn_valid,
  output reg           io_udpAxisIn_ready,
  input  wire [7:0]    io_udpAxisIn_payload_data,
  input  wire          io_udpAxisIn_payload_last,
  input  wire [0:0]    io_udpAxisIn_payload_user,
  output wire          io_udpAxisOut_valid,
  input  wire          io_udpAxisOut_ready,
  output wire [7:0]    io_udpAxisOut_payload_data,
  output wire          io_udpAxisOut_payload_last,
  output wire [0:0]    io_udpAxisOut_payload_user,
  input  wire [9:0]    io_lengthIn,
  output wire [9:0]    io_lengthOut,
  input  wire          io_rxHdr_valid,
  output wire          io_rxHdr_ready,
  output wire [20:0]   io_config,
  output wire          io_end,
  input  wire          clk_out1,
  input  wire          rstN
);

  wire       [1:0]    _zz_counter_valueNext;
  wire       [0:0]    _zz_counter_valueNext_1;
  wire       [4:0]    _zz_config_1;
  reg                 end_1;
  wire                io_rxHdr_fire;
  reg        [9:0]    lengthIn;
  reg        [23:0]   config_1;
  wire                hit;
  reg                 counter_willIncrement;
  wire                counter_willClear;
  reg        [1:0]    counter_valueNext;
  reg        [1:0]    counter_value;
  wire                counter_willOverflowIfInc;
  wire                counter_willOverflow;
  wire                io_udpAxisIn_fire;
  wire                when_ConfigRx_l26;
  reg                 io_udpAxisIn_thrown_valid;
  wire                io_udpAxisIn_thrown_ready;
  wire       [7:0]    io_udpAxisIn_thrown_payload_data;
  wire                io_udpAxisIn_thrown_payload_last;
  wire       [0:0]    io_udpAxisIn_thrown_payload_user;

  assign _zz_config_1 = ({3'd0,counter_value} <<< 2'd3);
  assign _zz_counter_valueNext_1 = counter_willIncrement;
  assign _zz_counter_valueNext = {1'd0, _zz_counter_valueNext_1};
  always @(*) begin
    end_1 = 1'b0;
    if(counter_willOverflow) begin
      end_1 = 1'b1;
    end
  end

  assign io_end = end_1;
  assign io_rxHdr_ready = 1'b1;
  assign io_rxHdr_fire = (io_rxHdr_valid && io_rxHdr_ready);
  assign hit = (lengthIn == 10'h002);
  always @(*) begin
    counter_willIncrement = 1'b0;
    if(when_ConfigRx_l26) begin
      counter_willIncrement = 1'b1;
    end
  end

  assign counter_willClear = 1'b0;
  assign counter_willOverflowIfInc = (counter_value == 2'b10);
  assign counter_willOverflow = (counter_willOverflowIfInc && counter_willIncrement);
  always @(*) begin
    if(counter_willOverflow) begin
      counter_valueNext = 2'b00;
    end else begin
      counter_valueNext = (counter_value + _zz_counter_valueNext);
    end
    if(counter_willClear) begin
      counter_valueNext = 2'b00;
    end
  end

  assign io_config = config_1[20:0];
  assign io_lengthOut = lengthIn;
  assign io_udpAxisIn_fire = (io_udpAxisIn_valid && io_udpAxisIn_ready);
  assign when_ConfigRx_l26 = (hit && io_udpAxisIn_fire);
  always @(*) begin
    io_udpAxisIn_thrown_valid = io_udpAxisIn_valid;
    if(hit) begin
      io_udpAxisIn_thrown_valid = 1'b0;
    end
  end

  always @(*) begin
    io_udpAxisIn_ready = io_udpAxisIn_thrown_ready;
    if(hit) begin
      io_udpAxisIn_ready = 1'b1;
    end
  end

  assign io_udpAxisIn_thrown_payload_data = io_udpAxisIn_payload_data;
  assign io_udpAxisIn_thrown_payload_last = io_udpAxisIn_payload_last;
  assign io_udpAxisIn_thrown_payload_user[0 : 0] = io_udpAxisIn_payload_user[0 : 0];
  assign io_udpAxisOut_valid = io_udpAxisIn_thrown_valid;
  assign io_udpAxisIn_thrown_ready = io_udpAxisOut_ready;
  assign io_udpAxisOut_payload_data = io_udpAxisIn_thrown_payload_data;
  assign io_udpAxisOut_payload_last = io_udpAxisIn_thrown_payload_last;
  assign io_udpAxisOut_payload_user[0 : 0] = io_udpAxisIn_thrown_payload_user[0 : 0];
  always @(posedge clk_out1) begin
    if(io_rxHdr_fire) begin
      lengthIn <= io_lengthIn;
    end
  end

  always @(posedge clk_out1 or negedge rstN) begin
    if(!rstN) begin
      config_1 <= 24'h0;
      counter_value <= 2'b00;
    end else begin
      counter_value <= counter_valueNext;
      if(when_ConfigRx_l26) begin
        config_1[_zz_config_1 +: 8] <= io_udpAxisIn_payload_data;
      end
    end
  end


endmodule
