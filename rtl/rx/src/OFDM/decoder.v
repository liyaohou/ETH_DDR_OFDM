`timescale  1ns / 1ps  
module decoder (
																				input               clk,
																				input               rst_n,
																				
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_dencoder TDATA" *)	input      [1:0]    decoder_din,
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_dencoder TVALID" *)	input               decoder_din_valid,
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_dencoder TREADY" *)	output              decoder_dout_ready,

																				input 	   [7:0]	decoder_din_symb_cnt,       //symbol_cnt计数值

(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_dencoder TDATA" *)	output              decoder_dout,
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_dencoder TVALID" *)	output              decoder_dout_valid,
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_dencoder TREADY" *)	input               decoder_din_ready,

																				output	   [7:0]	decoder_dout_symb_cnt		//symbol_cnt计数值
);

wire wr_en;
wire rd_en;
assign wr_en = decoder_din_valid&decoder_dout_ready;
assign rd_en = decoder_dout_valid&decoder_din_ready;

reg  [7:0] din_symb_cnt_reg = 0;
wire 	   cnt_en;
wire       cnt_rst_n;
wire [9:0] cnt;
reg  [9:0] cnt_Max = 10'd1023;
wire       cnt_last;
wire       symb_end1;
wire       symb_end2;
wire 	   symb_end;

//对输入与输出进行计数，判断还有多少数据需要推出。
parameter   en_cnt          = 1;
reg [31:0]  decoder_in_cnt  = 0;
always @(posedge clk or negedge rst_n)begin
	if(rst_n==1'b0)
		decoder_in_cnt<= 0;
	else begin
		if(decoder_din_valid) begin
			if(~decoder_dout_valid)
				decoder_in_cnt  <= decoder_in_cnt+1;
		end
		else begin
			if(decoder_in_cnt!=0 && decoder_dout_valid)
				decoder_in_cnt <= decoder_in_cnt-1;
		end
	end 
end 


assign cnt_en 		=  decoder_dout_ready;
assign cnt_rst_n 	=  rst_n&(din_symb_cnt_reg==decoder_din_symb_cnt);
counter_in #(.CNT_NUM('d1024),
		.ADD(1'b1))
u_counter_decode(
.clk		(clk		),	
.rst_n		(cnt_rst_n	),
.En_cnt		(cnt_en			), 
.cnt_din	(cnt_Max		),     
.cnt		(cnt			),	
.cnt_last	(cnt_last		)
);

//延时一个周期信号
always @(posedge clk) begin din_symb_cnt_reg<=decoder_din_symb_cnt;end
//生成帧结束信号
parameter end_latecy = 10'd270;//指的是从对输入时钟进行计数，每次symb_cnt更新都会复位
assign  symb_end1 = din_symb_cnt_reg>0 && decoder_din_symb_cnt==0;
assign  symb_end2 = (cnt>end_latecy)?1'b1:1'b0;
assign  symb_end  = ( symb_end1|symb_end2 ) ? (decoder_in_cnt>2?1'b1:1'b0) : 1'b0;


/**根据计数信息重新进行输入有效信号与输入数据的组合**/
wire         decoder_din_valid_latency 	;
wire  [1:0]  decoder_din_latency		;
assign decoder_din_latency          =  (en_cnt & symb_end) ? (  2'b00  ) : decoder_din;
assign decoder_din_valid_latency    =  (en_cnt & symb_end) ? (  1'b1   ) : decoder_din_valid;

viterbi_0 u_viterbi_1 (
.aclk                     (clk),                            // input wire aclk
.aresetn                  (rst_n),                          // input wire aresetn
//面向输入的接口
.s_axis_data_tdata        ({7'b0,decoder_din_latency[1],7'b0,decoder_din_latency[0]}), // input wire [15 : 0] s_axis_data_tdata
.s_axis_data_tvalid       (decoder_din_valid_latency),    // input wire s_axis_data_tvalid
.s_axis_data_tready       (decoder_dout_ready),    // output wire s_axis_data_tready

.m_axis_data_tdata        (decoder_dout),         // output wire [7 : 0] m_axis_data_tdata
.m_axis_data_tvalid       (decoder_dout_valid),   // output wire m_axis_data_tvalid
.m_axis_data_tready       (decoder_din_ready)    // input wire m_axis_data_tready
);




StreamDecodeFifo Fifo_stream(
	.io_push_valid  ( wr_en ),//写使能
	.io_push_payload( decoder_din_symb_cnt ),

	.io_pop_ready   ( rd_en ),//读使能
	.io_pop_payload ( decoder_dout_symb_cnt ),

	.clk(clk),
	.resetn(rst_n)
);


parameter		PATH0 = "C:/Users/fire/Desktop/par2/";
integer 		decode_out_data;
initial begin
	decode_out_data  =  $fopen({PATH0,"decode_out_data.txt"});
end
always@(posedge clk)
begin
if(decoder_dout_valid & decoder_din_ready)
	begin
	$fdisplay(decode_out_data,"%b",decoder_dout);
	end
end


endmodule //decoder



// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : StreamFifo
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

module StreamDecodeFifo (
input  wire          io_push_valid,
output wire          io_push_ready,
input  wire          io_push_payload_last,
input  wire [7:0]    io_push_payload,

output wire          io_pop_valid,
input  wire          io_pop_ready,
output wire          io_pop_payload_last,
output wire [7:0]    io_pop_payload,

input  wire          io_flush,
output wire [8:0]    io_occupancy,
output wire [8:0]    io_availability,

input  wire          clk,
input  wire          resetn
);

reg        [8:0]    logic_ram_spinal_port1;
wire       [8:0]    _zz_logic_ram_port;
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
wire                logic_push_onRam_write_payload_data_last;
wire       [7:0]    logic_push_onRam_write_payload_data_fragment;
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
wire                logic_pop_sync_readPort_rsp_last;
wire       [7:0]    logic_pop_sync_readPort_rsp_fragment;
wire       [8:0]    _zz_logic_pop_sync_readPort_rsp_last;
wire                logic_pop_sync_readArbitation_translated_valid;
wire                logic_pop_sync_readArbitation_translated_ready;
wire                logic_pop_sync_readArbitation_translated_payload_last;
wire       [7:0]    logic_pop_sync_readArbitation_translated_payload_fragment;
wire                logic_pop_sync_readArbitation_fire;
reg        [8:0]    logic_pop_sync_popReg;
reg [8:0] logic_ram [0:255];

assign _zz_logic_ram_port = {logic_push_onRam_write_payload_data_fragment,logic_push_onRam_write_payload_data_last};
always @(posedge clk) begin
	if(_zz_1) begin
	logic_ram[logic_push_onRam_write_payload_address] <= _zz_logic_ram_port;
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
assign logic_push_onRam_write_payload_data_last = io_push_payload_last;
assign logic_push_onRam_write_payload_data_fragment = io_push_payload;
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
assign _zz_logic_pop_sync_readPort_rsp_last = logic_ram_spinal_port1;
assign logic_pop_sync_readPort_rsp_last = _zz_logic_pop_sync_readPort_rsp_last[0];
assign logic_pop_sync_readPort_rsp_fragment = _zz_logic_pop_sync_readPort_rsp_last[8 : 1];
assign logic_pop_sync_readPort_cmd_valid = logic_pop_addressGen_fire;
assign logic_pop_sync_readPort_cmd_payload = logic_pop_addressGen_payload;
assign logic_pop_sync_readArbitation_translated_valid = logic_pop_sync_readArbitation_valid;
assign logic_pop_sync_readArbitation_ready = logic_pop_sync_readArbitation_translated_ready;
assign logic_pop_sync_readArbitation_translated_payload_last = logic_pop_sync_readPort_rsp_last;
assign logic_pop_sync_readArbitation_translated_payload_fragment = logic_pop_sync_readPort_rsp_fragment;
assign io_pop_valid = logic_pop_sync_readArbitation_translated_valid;
assign logic_pop_sync_readArbitation_translated_ready = io_pop_ready;
assign io_pop_payload_last = logic_pop_sync_readArbitation_translated_payload_last;
assign io_pop_payload = logic_pop_sync_readArbitation_translated_payload_fragment;
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
