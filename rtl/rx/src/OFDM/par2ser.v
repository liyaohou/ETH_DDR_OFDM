`timescale 1ns / 1ps

module Par2Ser#(parameter WIDTH = 4'd8,
				parameter LSB_FIRST = 1'b1)
(
	input 						clk		,
	input						rst_n	,
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_Par2Ser TDATA" *)	input	[WIDTH - 1:0]		din		,
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_Par2Ser TVALID" *)	input						din_vld	,
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_Par2Ser TREADY" *)	output						dout_rdy,

(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_Par2Ser TDATA" *)	output						dout	,
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_Par2Ser TVALID" *)	output	reg					dout_vld,
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_Par2Ser TREADY" *)	input						din_rdy	

);
wire							wr_en	;
wire							rd_en	;
wire							cnt_last;
wire	[$clog2(WIDTH)-1:0]		cnt		;
reg		[WIDTH - 1:0]			din_r	;

assign	wr_en	 = dout_rdy & din_vld ;//与上游握手成功，开始接收数据
assign	rd_en	 = din_rdy & dout_vld ;//与下游握手成功，启动读计数器，开始输出

counter #(.CNT_NUM(WIDTH),
		.ADD(LSB_FIRST))
u_counter_P2S(
	.clk		(clk				),
	.rst_n		(rst_n				),
	.En_cnt		(rd_en				),
	.cnt		(cnt				),
	.cnt_last	(cnt_last			)
);

assign 	dout = din_r[cnt];
always @(posedge clk or negedge rst_n)
	if(!rst_n)begin
		din_r <= 'd0;
		dout_vld <= 1'b0;
	end
	else if(wr_en)begin
		din_r <= din;
		dout_vld <= 1'b1;//写进数据时，输出有效
	end
	else if(rd_en & cnt_last)
		dout_vld <= 1'b0;//输出完成，输出无效；只有在输入数据无效的时候才会进入次判断，保证无气泡传输
		
/* //初始化时，或输出数据完成，可以接收数据
always @(posedge clk or negedge rst_n)
	if(!rst_n)
		dout_rdy <= 1'b1;
	else if(cnt_last & rd_en)
		dout_rdy <= 1'b1;
	else if(wr_en)
		dout_rdy <= 1'b0; */	

//能够接受上游数据仅在两种情况可行：1---dout_vld无效 || 2---din_rdy下游准备好收且一帧发送计数结束
assign dout_rdy = cnt_last & din_rdy | ~dout_vld;



endmodule
