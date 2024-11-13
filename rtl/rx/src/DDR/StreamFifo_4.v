// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : StreamFifo_4
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module StreamFifo_4 (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire          io_push_payload_write,
  input  wire [28:0]   io_push_payload_address,
  input  wire [17:0]   io_push_payload_context,
  input  wire          io_push_payload_burstLast,
  input  wire [1:0]    io_push_payload_length,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire          io_pop_payload_write,
  output wire [28:0]   io_pop_payload_address,
  output wire [17:0]   io_pop_payload_context,
  output wire          io_pop_payload_burstLast,
  output wire [1:0]    io_pop_payload_length,
  input  wire          io_flush,
  output wire [6:0]    io_occupancy,
  output wire [6:0]    io_availability,
  input  wire          clk_out4,
  input  wire          rstN
);

  wire       [50:0]   logic_ram_spinal_port1;
  wire       [50:0]   _zz_logic_ram_port;
  reg                 _zz_1;
  wire                logic_ptr_doPush;
  wire                logic_ptr_doPop;
  wire                logic_ptr_full;
  wire                logic_ptr_empty;
  reg        [6:0]    logic_ptr_push;
  reg        [6:0]    logic_ptr_pop;
  wire       [6:0]    logic_ptr_occupancy;
  wire       [6:0]    logic_ptr_popOnIo;
  wire                when_Stream_l1269;
  reg                 logic_ptr_wentUp;
  wire                io_push_fire;
  wire                logic_push_onRam_write_valid;
  wire       [5:0]    logic_push_onRam_write_payload_address;
  wire                logic_push_onRam_write_payload_data_write;
  wire       [28:0]   logic_push_onRam_write_payload_data_address;
  wire       [17:0]   logic_push_onRam_write_payload_data_context;
  wire                logic_push_onRam_write_payload_data_burstLast;
  wire       [1:0]    logic_push_onRam_write_payload_data_length;
  wire                logic_pop_addressGen_valid;
  wire                logic_pop_addressGen_ready;
  wire       [5:0]    logic_pop_addressGen_payload;
  wire                logic_pop_addressGen_fire;
  wire                logic_pop_async_readed_write;
  wire       [28:0]   logic_pop_async_readed_address;
  wire       [17:0]   logic_pop_async_readed_context;
  wire                logic_pop_async_readed_burstLast;
  wire       [1:0]    logic_pop_async_readed_length;
  wire       [50:0]   _zz_logic_pop_async_readed_write;
  wire                logic_pop_addressGen_translated_valid;
  wire                logic_pop_addressGen_translated_ready;
  wire                logic_pop_addressGen_translated_payload_write;
  wire       [28:0]   logic_pop_addressGen_translated_payload_address;
  wire       [17:0]   logic_pop_addressGen_translated_payload_context;
  wire                logic_pop_addressGen_translated_payload_burstLast;
  wire       [1:0]    logic_pop_addressGen_translated_payload_length;
  (* ram_style = "distributed" *) reg [50:0] logic_ram [0:63];

  assign _zz_logic_ram_port = {logic_push_onRam_write_payload_data_length,{logic_push_onRam_write_payload_data_burstLast,{logic_push_onRam_write_payload_data_context,{logic_push_onRam_write_payload_data_address,logic_push_onRam_write_payload_data_write}}}};
  always @(posedge clk_out4) begin
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
  assign logic_ptr_full = (((logic_ptr_push ^ logic_ptr_popOnIo) ^ 7'h40) == 7'h0);
  assign logic_ptr_empty = (logic_ptr_push == logic_ptr_pop);
  assign logic_ptr_occupancy = (logic_ptr_push - logic_ptr_popOnIo);
  assign io_push_ready = (! logic_ptr_full);
  assign io_push_fire = (io_push_valid && io_push_ready);
  assign logic_ptr_doPush = io_push_fire;
  assign logic_push_onRam_write_valid = io_push_fire;
  assign logic_push_onRam_write_payload_address = logic_ptr_push[5:0];
  assign logic_push_onRam_write_payload_data_write = io_push_payload_write;
  assign logic_push_onRam_write_payload_data_address = io_push_payload_address;
  assign logic_push_onRam_write_payload_data_context = io_push_payload_context;
  assign logic_push_onRam_write_payload_data_burstLast = io_push_payload_burstLast;
  assign logic_push_onRam_write_payload_data_length = io_push_payload_length;
  assign logic_pop_addressGen_valid = (! logic_ptr_empty);
  assign logic_pop_addressGen_payload = logic_ptr_pop[5:0];
  assign logic_pop_addressGen_fire = (logic_pop_addressGen_valid && logic_pop_addressGen_ready);
  assign logic_ptr_doPop = logic_pop_addressGen_fire;
  assign _zz_logic_pop_async_readed_write = logic_ram_spinal_port1;
  assign logic_pop_async_readed_write = _zz_logic_pop_async_readed_write[0];
  assign logic_pop_async_readed_address = _zz_logic_pop_async_readed_write[29 : 1];
  assign logic_pop_async_readed_context = _zz_logic_pop_async_readed_write[47 : 30];
  assign logic_pop_async_readed_burstLast = _zz_logic_pop_async_readed_write[48];
  assign logic_pop_async_readed_length = _zz_logic_pop_async_readed_write[50 : 49];
  assign logic_pop_addressGen_translated_valid = logic_pop_addressGen_valid;
  assign logic_pop_addressGen_ready = logic_pop_addressGen_translated_ready;
  assign logic_pop_addressGen_translated_payload_write = logic_pop_async_readed_write;
  assign logic_pop_addressGen_translated_payload_address = logic_pop_async_readed_address;
  assign logic_pop_addressGen_translated_payload_context = logic_pop_async_readed_context;
  assign logic_pop_addressGen_translated_payload_burstLast = logic_pop_async_readed_burstLast;
  assign logic_pop_addressGen_translated_payload_length = logic_pop_async_readed_length;
  assign io_pop_valid = logic_pop_addressGen_translated_valid;
  assign logic_pop_addressGen_translated_ready = io_pop_ready;
  assign io_pop_payload_write = logic_pop_addressGen_translated_payload_write;
  assign io_pop_payload_address = logic_pop_addressGen_translated_payload_address;
  assign io_pop_payload_context = logic_pop_addressGen_translated_payload_context;
  assign io_pop_payload_burstLast = logic_pop_addressGen_translated_payload_burstLast;
  assign io_pop_payload_length = logic_pop_addressGen_translated_payload_length;
  assign logic_ptr_popOnIo = logic_ptr_pop;
  assign io_occupancy = logic_ptr_occupancy;
  assign io_availability = (7'h40 - logic_ptr_occupancy);
  always @(posedge clk_out4 or negedge rstN) begin
    if(!rstN) begin
      logic_ptr_push <= 7'h0;
      logic_ptr_pop <= 7'h0;
      logic_ptr_wentUp <= 1'b0;
    end else begin
      if(when_Stream_l1269) begin
        logic_ptr_wentUp <= logic_ptr_doPush;
      end
      if(io_flush) begin
        logic_ptr_wentUp <= 1'b0;
      end
      if(logic_ptr_doPush) begin
        logic_ptr_push <= (logic_ptr_push + 7'h01);
      end
      if(logic_ptr_doPop) begin
        logic_ptr_pop <= (logic_ptr_pop + 7'h01);
      end
      if(io_flush) begin
        logic_ptr_push <= 7'h0;
        logic_ptr_pop <= 7'h0;
      end
    end
  end


endmodule
