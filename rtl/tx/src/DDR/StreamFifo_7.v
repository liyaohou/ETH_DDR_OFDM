// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : StreamFifo_7
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module StreamFifo_7 (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [7:0]    io_push_payload_data,
  input  wire          io_push_payload_last,
  input  wire [0:0]    io_push_payload_user,
  output reg           io_pop_valid,
  input  wire          io_pop_ready,
  output reg  [7:0]    io_pop_payload_data,
  output reg           io_pop_payload_last,
  output reg  [0:0]    io_pop_payload_user,
  input  wire          io_flush,
  output wire [11:0]   io_occupancy,
  output wire [11:0]   io_availability,
  input  wire          clk_out1,
  input  wire          rstN
);

  wire       [9:0]    logic_ram_spinal_port1;
  wire       [11:0]   _zz_logic_ptr_notPow2_counter;
  wire       [11:0]   _zz_logic_ptr_notPow2_counter_1;
  wire       [0:0]    _zz_logic_ptr_notPow2_counter_2;
  wire       [11:0]   _zz_logic_ptr_notPow2_counter_3;
  wire       [0:0]    _zz_logic_ptr_notPow2_counter_4;
  wire       [9:0]    _zz_logic_ram_port;
  reg                 _zz_1;
  reg                 logic_ptr_doPush;
  wire                logic_ptr_doPop;
  wire                logic_ptr_full;
  wire                logic_ptr_empty;
  reg        [11:0]   logic_ptr_push;
  reg        [11:0]   logic_ptr_pop;
  wire       [11:0]   logic_ptr_occupancy;
  wire       [11:0]   logic_ptr_popOnIo;
  wire                when_Stream_l1269;
  reg                 logic_ptr_wentUp;
  wire                when_Stream_l1304;
  wire                when_Stream_l1308;
  reg        [11:0]   logic_ptr_notPow2_counter;
  wire                io_push_fire;
  wire                io_pop_fire;
  wire                logic_push_onRam_write_valid;
  wire       [11:0]   logic_push_onRam_write_payload_address;
  wire       [7:0]    logic_push_onRam_write_payload_data_data;
  wire                logic_push_onRam_write_payload_data_last;
  wire       [0:0]    logic_push_onRam_write_payload_data_user;
  wire                logic_pop_addressGen_valid;
  wire                logic_pop_addressGen_ready;
  wire       [11:0]   logic_pop_addressGen_payload;
  wire                logic_pop_addressGen_fire;
  wire       [7:0]    logic_pop_async_readed_data;
  wire                logic_pop_async_readed_last;
  wire       [0:0]    logic_pop_async_readed_user;
  wire       [9:0]    _zz_logic_pop_async_readed_data;
  wire                logic_pop_addressGen_translated_valid;
  wire                logic_pop_addressGen_translated_ready;
  wire       [7:0]    logic_pop_addressGen_translated_payload_data;
  wire                logic_pop_addressGen_translated_payload_last;
  wire       [0:0]    logic_pop_addressGen_translated_payload_user;
  (* ram_style = "distributed" *) reg [9:0] logic_ram [0:2103];

  assign _zz_logic_ptr_notPow2_counter = (logic_ptr_notPow2_counter + _zz_logic_ptr_notPow2_counter_1);
  assign _zz_logic_ptr_notPow2_counter_2 = io_push_fire;
  assign _zz_logic_ptr_notPow2_counter_1 = {11'd0, _zz_logic_ptr_notPow2_counter_2};
  assign _zz_logic_ptr_notPow2_counter_4 = io_pop_fire;
  assign _zz_logic_ptr_notPow2_counter_3 = {11'd0, _zz_logic_ptr_notPow2_counter_4};
  assign _zz_logic_ram_port = {logic_push_onRam_write_payload_data_user,{logic_push_onRam_write_payload_data_last,logic_push_onRam_write_payload_data_data}};
  always @(posedge clk_out1) begin
    if(_zz_1) begin
      logic_ram[logic_push_onRam_write_payload_address] <= _zz_logic_ram_port;
    end
  end

  assign logic_ram_spinal_port1 = logic_ram[logic_pop_addressGen_payload];
  always @(*) begin
    _zz_1 = 1'b0;
    if(logic_push_onRam_write_valid) begin
      _zz_1 = 1'b1;
    end
  end

  assign when_Stream_l1269 = (logic_ptr_doPush != logic_ptr_doPop);
  assign logic_ptr_full = ((logic_ptr_push == logic_ptr_popOnIo) && logic_ptr_wentUp);
  assign logic_ptr_empty = ((logic_ptr_push == logic_ptr_pop) && (! logic_ptr_wentUp));
  assign when_Stream_l1304 = (logic_ptr_push == 12'h837);
  assign when_Stream_l1308 = (logic_ptr_pop == 12'h837);
  assign io_push_fire = (io_push_valid && io_push_ready);
  assign io_pop_fire = (io_pop_valid && io_pop_ready);
  assign logic_ptr_occupancy = logic_ptr_notPow2_counter;
  assign io_push_ready = (! logic_ptr_full);
  always @(*) begin
    logic_ptr_doPush = io_push_fire;
    if(logic_ptr_empty) begin
      if(io_pop_ready) begin
        logic_ptr_doPush = 1'b0;
      end
    end
  end

  assign logic_push_onRam_write_valid = io_push_fire;
  assign logic_push_onRam_write_payload_address = logic_ptr_push;
  assign logic_push_onRam_write_payload_data_data = io_push_payload_data;
  assign logic_push_onRam_write_payload_data_last = io_push_payload_last;
  assign logic_push_onRam_write_payload_data_user[0 : 0] = io_push_payload_user[0 : 0];
  assign logic_pop_addressGen_valid = (! logic_ptr_empty);
  assign logic_pop_addressGen_payload = logic_ptr_pop;
  assign logic_pop_addressGen_fire = (logic_pop_addressGen_valid && logic_pop_addressGen_ready);
  assign logic_ptr_doPop = logic_pop_addressGen_fire;
  assign _zz_logic_pop_async_readed_data = logic_ram_spinal_port1;
  assign logic_pop_async_readed_data = _zz_logic_pop_async_readed_data[7 : 0];
  assign logic_pop_async_readed_last = _zz_logic_pop_async_readed_data[8];
  assign logic_pop_async_readed_user = _zz_logic_pop_async_readed_data[9 : 9];
  assign logic_pop_addressGen_translated_valid = logic_pop_addressGen_valid;
  assign logic_pop_addressGen_ready = logic_pop_addressGen_translated_ready;
  assign logic_pop_addressGen_translated_payload_data = logic_pop_async_readed_data;
  assign logic_pop_addressGen_translated_payload_last = logic_pop_async_readed_last;
  assign logic_pop_addressGen_translated_payload_user[0 : 0] = logic_pop_async_readed_user[0 : 0];
  always @(*) begin
    io_pop_valid = logic_pop_addressGen_translated_valid;
    if(logic_ptr_empty) begin
      io_pop_valid = io_push_valid;
    end
  end

  assign logic_pop_addressGen_translated_ready = io_pop_ready;
  always @(*) begin
    io_pop_payload_data = logic_pop_addressGen_translated_payload_data;
    if(logic_ptr_empty) begin
      io_pop_payload_data = io_push_payload_data;
    end
  end

  always @(*) begin
    io_pop_payload_last = logic_pop_addressGen_translated_payload_last;
    if(logic_ptr_empty) begin
      io_pop_payload_last = io_push_payload_last;
    end
  end

  always @(*) begin
    io_pop_payload_user[0 : 0] = logic_pop_addressGen_translated_payload_user[0 : 0];
    if(logic_ptr_empty) begin
      io_pop_payload_user[0 : 0] = io_push_payload_user[0 : 0];
    end
  end

  assign logic_ptr_popOnIo = logic_ptr_pop;
  assign io_occupancy = logic_ptr_occupancy;
  assign io_availability = (12'h838 - logic_ptr_occupancy);
  always @(posedge clk_out1 or negedge rstN) begin
    if(!rstN) begin
      logic_ptr_push <= 12'h0;
      logic_ptr_pop <= 12'h0;
      logic_ptr_wentUp <= 1'b0;
      logic_ptr_notPow2_counter <= 12'h0;
    end else begin
      if(when_Stream_l1269) begin
        logic_ptr_wentUp <= logic_ptr_doPush;
      end
      if(io_flush) begin
        logic_ptr_wentUp <= 1'b0;
      end
      if(logic_ptr_doPush) begin
        logic_ptr_push <= (logic_ptr_push + 12'h001);
        if(when_Stream_l1304) begin
          logic_ptr_push <= 12'h0;
        end
      end
      if(logic_ptr_doPop) begin
        logic_ptr_pop <= (logic_ptr_pop + 12'h001);
        if(when_Stream_l1308) begin
          logic_ptr_pop <= 12'h0;
        end
      end
      if(io_flush) begin
        logic_ptr_push <= 12'h0;
        logic_ptr_pop <= 12'h0;
      end
      logic_ptr_notPow2_counter <= (_zz_logic_ptr_notPow2_counter - _zz_logic_ptr_notPow2_counter_3);
      if(io_flush) begin
        logic_ptr_notPow2_counter <= 12'h0;
      end
    end
  end


endmodule
