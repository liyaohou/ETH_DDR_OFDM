`timescale 1ns / 1ps

module Ser2Par#(parameter WIDTH = 4'd8,
				parameter LSB_FIRST = 1'b1)
(
	input 						clk		,
	input						rst_n	,
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_Ser2Par TDATA" *)	input						din		,
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_Ser2Par TVALID" *)	input						din_vld	,
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_Ser2Par TREADY" *)	input						din_rdy	,
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_Ser2Par TDATA" *)	output	reg	[WIDTH - 1:0]	dout	,
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_Ser2Par TVALID" *)	output	reg					dout_vld,
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_Ser2Par TREADY" *)	output	   					dout_rdy
);

wire							wr_en	;
wire							cnt_last;
wire	[$clog2(WIDTH)-1:0]		cnt		;


assign	wr_en	 = dout_rdy & din_vld	;//输入有效且准备好接收数据，开始接收
assign	rd_en	 = dout_vld & din_rdy	;//与下游握手成功

//该部分对dout_rdy的处理有逻辑错误
//初始化时或下游可以接收数据，此时开始准备接收数据		
// always @(posedge clk or negedge rst_n)
// 	if(!rst_n)
// 		dout_rdy <= 1'b1;
// 	else if(cnt_last & wr_en)
// 		dout_rdy <= 1'b0;
// 	else if(rd_en)
// 		dout_rdy <= 1'b1;	


//!-!-!-!-!-!对dout_rdy的处理为简单的直接拉高，可能需要其他操作。
// assign dout_rdy = din_vld;
assign dout_rdy = din_rdy | din_vld;

counter #(.CNT_NUM(WIDTH),
		.ADD(LSB_FIRST))
u_counter(
.clk		(clk				),	
.rst_n		(rst_n				),
.En_cnt		(wr_en				),    
.cnt		(cnt				),	
.cnt_last	(cnt_last			)
);

//接收完毕，输出数据有效;若下游接收数据后，没有新数据vaild拉低
always @(posedge clk or negedge rst_n)
	if(!rst_n)begin
		dout_vld <= 1'b0;
	end
	else if(cnt_last & wr_en)
		dout_vld <= 1'b1;
	else if(rd_en)
		dout_vld <= 1'b0;

always @(posedge clk or negedge rst_n)
	if(!rst_n)
		dout <= 'd0;
	else if(wr_en)
		dout[cnt] <= din;
	else
		dout <= dout;

endmodule
