// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : StreamFifo_5
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module StreamFifo_5 (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire          io_push_payload_last,
  input  wire [31:0]   io_push_payload_fragment_data,
  input  wire [17:0]   io_push_payload_fragment_context,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire          io_pop_payload_last,
  output wire [31:0]   io_pop_payload_fragment_data,
  output wire [17:0]   io_pop_payload_fragment_context,
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
  wire                logic_push_onRam_write_payload_data_last;
  wire       [31:0]   logic_push_onRam_write_payload_data_fragment_data;
  wire       [17:0]   logic_push_onRam_write_payload_data_fragment_context;
  wire                logic_pop_addressGen_valid;
  wire                logic_pop_addressGen_ready;
  wire       [5:0]    logic_pop_addressGen_payload;
  wire                logic_pop_addressGen_fire;
  wire                logic_pop_async_readed_last;
  wire       [31:0]   logic_pop_async_readed_fragment_data;
  wire       [17:0]   logic_pop_async_readed_fragment_context;
  wire       [50:0]   _zz_logic_pop_async_readed_last;
  wire       [49:0]   _zz_logic_pop_async_readed_fragment_data;
  wire                logic_pop_addressGen_translated_valid;
  wire                logic_pop_addressGen_translated_ready;
  wire                logic_pop_addressGen_translated_payload_last;
  wire       [31:0]   logic_pop_addressGen_translated_payload_fragment_data;
  wire       [17:0]   logic_pop_addressGen_translated_payload_fragment_context;
  (* ram_style = "distributed" *) reg [50:0] logic_ram [0:63];

  assign _zz_logic_ram_port = {{logic_push_onRam_write_payload_data_fragment_context,logic_push_onRam_write_payload_data_fragment_data},logic_push_onRam_write_payload_data_last};
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
  assign logic_push_onRam_write_payload_data_last = io_push_payload_last;
  assign logic_push_onRam_write_payload_data_fragment_data = io_push_payload_fragment_data;
  assign logic_push_onRam_write_payload_data_fragment_context = io_push_payload_fragment_context;
  assign logic_pop_addressGen_valid = (! logic_ptr_empty);
  assign logic_pop_addressGen_payload = logic_ptr_pop[5:0];
  assign logic_pop_addressGen_fire = (logic_pop_addressGen_valid && logic_pop_addressGen_ready);
  assign logic_ptr_doPop = logic_pop_addressGen_fire;
  assign _zz_logic_pop_async_readed_last = logic_ram_spinal_port1;
  assign logic_pop_async_readed_last = _zz_logic_pop_async_readed_last[0];
  assign _zz_logic_pop_async_readed_fragment_data = _zz_logic_pop_async_readed_last[50 : 1];
  assign logic_pop_async_readed_fragment_data = _zz_logic_pop_async_readed_fragment_data[31 : 0];
  assign logic_pop_async_readed_fragment_context = _zz_logic_pop_async_readed_fragment_data[49 : 32];
  assign logic_pop_addressGen_translated_valid = logic_pop_addressGen_valid;
  assign logic_pop_addressGen_ready = logic_pop_addressGen_translated_ready;
  assign logic_pop_addressGen_translated_payload_last = logic_pop_async_readed_last;
  assign logic_pop_addressGen_translated_payload_fragment_data = logic_pop_async_readed_fragment_data;
  assign logic_pop_addressGen_translated_payload_fragment_context = logic_pop_async_readed_fragment_context;
  assign io_pop_valid = logic_pop_addressGen_translated_valid;
  assign logic_pop_addressGen_translated_ready = io_pop_ready;
  assign io_pop_payload_last = logic_pop_addressGen_translated_payload_last;
  assign io_pop_payload_fragment_data = logic_pop_addressGen_translated_payload_fragment_data;
  assign io_pop_payload_fragment_context = logic_pop_addressGen_translated_payload_fragment_context;
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
