//*************************************************************************
// /* Function: descramble
// /* Input: clk,rst_n,inEn,dataIn,inSymCount
// /* Output: outEn,dataOut,outSymCount

//*       ________________________________
//*      |                                |
//*  ____|dataIn<3:0>	        dataOut<7:0>|____
//*      |							           |
//*  ____|inSymCount<7:0>			        |
//*      |									     |
//*  ____|clk		       outSymcount<7:0>|____
//*      |					       			  |
//*  ____|inEn								     |
//*      |										  |
//*  ____|rst_n					      outEn|____
//*		  |________________________________|

//**************************************************************************/


`timescale 1ns/10ps

module descrambler(
																				input   				clk,                    	/*时钟******//////
																				input   				rst_n,                  	/*系统复位信号，低电平有效******//////

(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_descram TDATA" *)	input   				descram_din,	        /*输入有效信号，高电平表明dataIn有数据输入******//////
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_descram TVALID" *)  input   				descram_din_vld		,           /*输入数据信号，串行输入******//////
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_descram TREADY" *)	output 	    			descram_dout_rdy,           /*输出有效信号******//////

																				input  	 		[7:0] 	descram_din_symb_cnt,         		/*当前输入所属symbol的序号******////// 

(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_descram TDATA" *)	output 	         		descram_dout,	    		/*解码后输出数据，每个时钟1位输出******//////
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_descram TVALID" *)  output	 			    descram_dout_vld,
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_descram TREADY" *)	input					descram_din_rdy,

																				output					descram_dout_symb_last,
																				output 			[7:0] 	descram_dout_symb_cnt     			/*当前传输symbol的序号******//////
);
//移位寄存器操作
reg		[6:0] 	shift_reg_7 	= 0 ;
always @(posedge clk or negedge rst_n)begin
	if(rst_n==0)begin
		shift_reg_7 <= 7'b1011101;
	end
	else begin
		if(descram_din_symb_cnt==3)
			shift_reg_7 <= 7'b1011101;
		else if(descram_din_symb_cnt>3 && descram_din_vld)
			shift_reg_7 <= {shift_reg_7[5:0],shift_reg_7[6]+shift_reg_7[3]};
	end
end
//面向输入AXI接口
assign descram_dout_rdy = descram_din_rdy;
//面向输出AXI接口
assign descram_dout_symb_cnt = descram_din_symb_cnt;
assign descram_dout = (descram_din_symb_cnt==3) ? descram_din : shift_reg_7[6]+shift_reg_7[3]+descram_din ;
assign descram_dout_vld = descram_din_rdy & descram_din_vld;



/****************************以下操作---产生symb_cnt_last(只会一个时钟周期)*********************************/

//1、握手信号
wire wr_en;
wire rd_en;
assign wr_en = descram_din_vld & descram_dout_rdy;
assign rd_en = descram_dout_vld & descram_din_rdy;

//2、延时后的 din_symb_cnt 信号
reg  [7:0] 	descram_din_symb_cnt_reg = 0;
always@(posedge clk)descram_din_symb_cnt_reg<=descram_din_symb_cnt;

//3、通过比较获得 symb_cnt_changed 信号
wire 		symb_cnt_changed;
assign 		symb_cnt_changed = descram_din_symb_cnt != descram_din_symb_cnt_reg;

//4、对 symb_length 进行计数，握手时+1，change时归零
reg [7:0] 	symb_length = 0;
always @(posedge clk or negedge rst_n)begin
	if(rst_n==0)
		symb_length <= 0;
	else if(symb_cnt_changed)
		symb_length <= 0;
	else if(wr_en)
		symb_length <= symb_length+1;
end

/*************参数定义***************/
parameter signal_length = 10'd96;
parameter max_latecy = 3'd3;

//5、产生计数使能信号
wire   cnt_en	;
assign cnt_en = (symb_length==signal_length-1'b1) ? 1'b1 : 1'b0;

//6、对在 symb_length 等于符号长度减一 时进行计数，若一定几个时钟周期内未拉高则判断结束。
reg [2:0] cnt = 0;
always @(posedge clk or negedge rst_n)begin
	if(rst_n==0)
		cnt <= 0;
	else if(cnt_en)begin
		if(cnt > max_latecy) cnt <= cnt;
		else cnt <= cnt+1;
	end
	else
		cnt <= 0;
end
assign descram_dout_symb_last =  (cnt==max_latecy) ? 1'b1 :1'b0;






parameter		PATH0 = "C:/Users/fire/Desktop/par2/";
integer 		descram_out_data;
initial begin
	descram_out_data  =  $fopen({PATH0,"descram_dout.txt"});
end
always@(posedge clk)
begin
  if(descram_dout_vld & descram_din_rdy)
    begin
      $fdisplay(descram_out_data,"%b",descram_dout);
    end
end






endmodule
