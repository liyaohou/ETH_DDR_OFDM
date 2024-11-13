// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : StreamSToP256
// Git hash  : 8328189dc30bec65e02932bc3277d998bd75ec98

`timescale 1ns/1ps
  
module StreamSToP256 (

(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_Serin TDATA" *)	  input  wire [0:0]    s_axis_payload,
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_Serin TVALID" *)	input  wire          s_axis_valid,
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_Serin TREADY" *)	output wire          s_axis_ready,

(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_Parout TDATA" *)	output wire [1:0]    m_axis_payload,
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_Parout TVALID" *)	output wire          m_axis_valid,
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_Parout TREADY" *)	input  wire          m_axis_ready,

  output wire [8:0]    occupancy,
  output wire [8:0]    availability,
  input  wire          clk,
  input  wire          resetn
);

  wire                fifo_io_push_valid;
  wire       [1:0]    fifo_io_push_payload;
  wire                fifo_io_push_ready;
  wire                fifo_io_pop_valid;
  wire       [1:0]    fifo_io_pop_payload;
  wire       [8:0]    fifo_io_occupancy;
  wire       [8:0]    fifo_io_availability;
  wire                s_axis_fire;
  reg                 _zz_s_axis_ready;
  reg        [0:0]    _zz_s_axis_ready_1;
  reg        [0:0]    _zz_s_axis_ready_2;
  wire                _zz_s_axis_ready_3;
  reg        [0:0]    _zz_io_push_payload;

  StreamSToP256Fifo fifo (
    .io_push_valid   (fifo_io_push_valid       ), //i
    .io_push_ready   (fifo_io_push_ready       ), //o
    .io_push_payload (fifo_io_push_payload[1:0]), //i
    .io_pop_valid    (fifo_io_pop_valid        ), //o
    .io_pop_ready    (m_axis_ready             ), //i
    .io_pop_payload  (fifo_io_pop_payload[1:0] ), //o
    .io_flush        (1'b0                     ), //i
    .io_occupancy    (fifo_io_occupancy[8:0]   ), //o
    .io_availability (fifo_io_availability[8:0]), //o
    .clk             (clk                      ), //i
    .resetn          (resetn                   )  //i
  );
  assign s_axis_fire = (s_axis_valid && s_axis_ready);
  always @(*) begin
    _zz_s_axis_ready = 1'b0;
    if(s_axis_fire) begin
      _zz_s_axis_ready = 1'b1;
    end
  end

  assign _zz_s_axis_ready_3 = (_zz_s_axis_ready_2 == 1'b1);
  always @(*) begin
    _zz_s_axis_ready_1 = (_zz_s_axis_ready_2 + _zz_s_axis_ready);
    if(1'b0) begin
      _zz_s_axis_ready_1 = 1'b0;
    end
  end

  assign fifo_io_push_valid = (s_axis_valid && _zz_s_axis_ready_3);
  assign fifo_io_push_payload = {s_axis_payload,_zz_io_push_payload};
  assign s_axis_ready = (! ((! fifo_io_push_ready) && _zz_s_axis_ready_3));
  assign m_axis_valid = fifo_io_pop_valid;
  assign m_axis_payload = fifo_io_pop_payload;
  assign occupancy = fifo_io_occupancy;
  assign availability = fifo_io_availability;
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      _zz_s_axis_ready_2 <= 1'b0;
    end else begin
      _zz_s_axis_ready_2 <= _zz_s_axis_ready_1;
    end
  end

  always @(posedge clk) begin
    if(s_axis_fire) begin
      _zz_io_push_payload <= s_axis_payload;
    end
  end


endmodule

module StreamSToP256Fifo (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [1:0]    io_push_payload,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [1:0]    io_pop_payload,
  input  wire          io_flush,
  output wire [8:0]    io_occupancy,
  output wire [8:0]    io_availability,
  input  wire          clk,
  input  wire          resetn
);

  reg        [1:0]    logic_ram_spinal_port1;
  reg                 _zz_1;
  wire                logic_ptr_doPush;
  wire                logic_ptr_doPop;
  wire                logic_ptr_full;
  wire                logic_ptr_empty;
  reg        [8:0]    logic_ptr_push;
  reg        [8:0]    logic_ptr_pop;
  wire       [8:0]    logic_ptr_occupancy;
  wire       [8:0]    logic_ptr_popOnIo;
  wire                when_Stream_l1269;
  reg                 logic_ptr_wentUp;
  wire                io_push_fire;
  wire                logic_push_onRam_write_valid;
  wire       [7:0]    logic_push_onRam_write_payload_address;
  wire       [1:0]    logic_push_onRam_write_payload_data;
  wire                logic_pop_addressGen_valid;
  reg                 logic_pop_addressGen_ready;
  wire       [7:0]    logic_pop_addressGen_payload;
  wire                logic_pop_addressGen_fire;
  wire                logic_pop_sync_readArbitation_valid;
  wire                logic_pop_sync_readArbitation_ready;
  wire       [7:0]    logic_pop_sync_readArbitation_payload;
  reg                 logic_pop_addressGen_rValid;
  reg        [7:0]    logic_pop_addressGen_rData;
  wire                when_Stream_l393;
  wire                logic_pop_sync_readPort_cmd_valid;
  wire       [7:0]    logic_pop_sync_readPort_cmd_payload;
  wire       [1:0]    logic_pop_sync_readPort_rsp;
  wire                logic_pop_sync_readArbitation_translated_valid;
  wire                logic_pop_sync_readArbitation_translated_ready;
  wire       [1:0]    logic_pop_sync_readArbitation_translated_payload;
  wire                logic_pop_sync_readArbitation_fire;
  reg        [8:0]    logic_pop_sync_popReg;
  reg [1:0] logic_ram [0:255];

  always @(posedge clk) begin
    if(_zz_1) begin
      logic_ram[logic_push_onRam_write_payload_address] <= logic_push_onRam_write_payload_data;
    end
  end

  always @(posedge clk) begin
    if(logic_pop_sync_readPort_cmd_valid) begin
      logic_ram_spinal_port1 <= logic_ram[logic_pop_sync_readPort_cmd_payload];
    end
  end

  always @(*) begin
    _zz_1 = 1'b0;
    if(logic_push_onRam_write_valid) begin
      _zz_1 = 1'b1;
    end
  end

  assign when_Stream_l1269 = (logic_ptr_doPush != logic_ptr_doPop);
  assign logic_ptr_full = (((logic_ptr_push ^ logic_ptr_popOnIo) ^ 9'h100) == 9'h0);
  assign logic_ptr_empty = (logic_ptr_push == logic_ptr_pop);
  assign logic_ptr_occupancy = (logic_ptr_push - logic_ptr_popOnIo);
  assign io_push_ready = (! logic_ptr_full);
  assign io_push_fire = (io_push_valid && io_push_ready);
  assign logic_ptr_doPush = io_push_fire;
  assign logic_push_onRam_write_valid = io_push_fire;
  assign logic_push_onRam_write_payload_address = logic_ptr_push[7:0];
  assign logic_push_onRam_write_payload_data = io_push_payload;
  assign logic_pop_addressGen_valid = (! logic_ptr_empty);
  assign logic_pop_addressGen_payload = logic_ptr_pop[7:0];
  assign logic_pop_addressGen_fire = (logic_pop_addressGen_valid && logic_pop_addressGen_ready);
  assign logic_ptr_doPop = logic_pop_addressGen_fire;
  always @(*) begin
    logic_pop_addressGen_ready = logic_pop_sync_readArbitation_ready;
    if(when_Stream_l393) begin
      logic_pop_addressGen_ready = 1'b1;
    end
  end

  assign when_Stream_l393 = (! logic_pop_sync_readArbitation_valid);
  assign logic_pop_sync_readArbitation_valid = logic_pop_addressGen_rValid;
  assign logic_pop_sync_readArbitation_payload = logic_pop_addressGen_rData;
  assign logic_pop_sync_readPort_rsp = logic_ram_spinal_port1;
  assign logic_pop_sync_readPort_cmd_valid = logic_pop_addressGen_fire;
  assign logic_pop_sync_readPort_cmd_payload = logic_pop_addressGen_payload;
  assign logic_pop_sync_readArbitation_translated_valid = logic_pop_sync_readArbitation_valid;
  assign logic_pop_sync_readArbitation_ready = logic_pop_sync_readArbitation_translated_ready;
  assign logic_pop_sync_readArbitation_translated_payload = logic_pop_sync_readPort_rsp;
  assign io_pop_valid = logic_pop_sync_readArbitation_translated_valid;
  assign logic_pop_sync_readArbitation_translated_ready = io_pop_ready;
  assign io_pop_payload = logic_pop_sync_readArbitation_translated_payload;
  assign logic_pop_sync_readArbitation_fire = (logic_pop_sync_readArbitation_valid && logic_pop_sync_readArbitation_ready);
  assign logic_ptr_popOnIo = logic_pop_sync_popReg;
  assign io_occupancy = logic_ptr_occupancy;
  assign io_availability = (9'h100 - logic_ptr_occupancy);
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      logic_ptr_push <= 9'h0;
      logic_ptr_pop <= 9'h0;
      logic_ptr_wentUp <= 1'b0;
      logic_pop_addressGen_rValid <= 1'b0;
      logic_pop_sync_popReg <= 9'h0;
    end else begin
      if(when_Stream_l1269) begin
        logic_ptr_wentUp <= logic_ptr_doPush;
      end
      if(io_flush) begin
        logic_ptr_wentUp <= 1'b0;
      end
      if(logic_ptr_doPush) begin
        logic_ptr_push <= (logic_ptr_push + 9'h001);
      end
      if(logic_ptr_doPop) begin
        logic_ptr_pop <= (logic_ptr_pop + 9'h001);
      end
      if(io_flush) begin
        logic_ptr_push <= 9'h0;
        logic_ptr_pop <= 9'h0;
      end
      if(logic_pop_addressGen_ready) begin
        logic_pop_addressGen_rValid <= logic_pop_addressGen_valid;
      end
      if(io_flush) begin
        logic_pop_addressGen_rValid <= 1'b0;
      end
      if(logic_pop_sync_readArbitation_fire) begin
        logic_pop_sync_popReg <= logic_ptr_pop;
      end
      if(io_flush) begin
        logic_pop_sync_popReg <= 9'h0;
      end
    end
  end

  always @(posedge clk) begin
    if(logic_pop_addressGen_ready) begin
      logic_pop_addressGen_rData <= logic_pop_addressGen_payload;
    end
  end


endmodule
