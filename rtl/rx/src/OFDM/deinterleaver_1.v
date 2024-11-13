`timescale 1ns / 1ps
//一级解交织，signal和data都会用到
//分组交织器的解交织器：行写列出                               
module deinterleaver_1(    
																				input               clk             	,  
																				input               rst_n          		,

(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_deintv1 TDATA" *)	input               deintv1_din      		,   
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_deintv1 TVALID" *)	input               deintv1_din_vld  		,
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_deintv1 TREADY" *)	output          	deintv1_dout_rdy		,
																				
																				input		[7:0]	deintv1_din_symb_cnt	,//symbol_cnt计数值
																				input       [1:0]   deintv1_din_Map_Type    ,

(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_deintv1 TDATA" *)	output 		        deintv1_dout     		,
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_deintv1 TVALID" *)	output          	deintv1_dout_vld		,    
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_deintv1 TREADY" *)	input				deintv1_din_rdy		    ,

																				output	reg [7:0]	deintv1_dout_symb_cnt	//symbol_cnt计数值
); 



localparam  N_48 =2'b00,
            N_96 =2'b01,
            N_192=2'b10,
            N_288=2'b11;


//-----双口RAM乒乓缓存区---//
reg		[287:0]	bufferA		;
reg		[287:0]	bufferB		;
reg				bufferA_full;
reg				bufferB_full;
reg				buffer_flag	;

wire			wr_en		;
wire			rd_en		;
//---------------------------------valid-ready握手--------------------------------//
assign	wr_en	 = deintv1_dout_rdy & deintv1_din_vld ;//与上游握手成功，开始接收数据
assign	rd_en	 = deintv1_din_rdy & deintv1_dout_vld ;//与下游握手成功，开始输出

assign	deintv1_dout_rdy = (~bufferA_full | ~bufferB_full) ? 1'b1 : 1'b0;
assign	deintv1_dout_vld = ( bufferA_full |  bufferB_full) ? 1'b1 : 1'b0;
//---------------------------------------------------------------------------------//
reg		[8:0]	cnt_Max		;

wire	[8:0]	w_cnt	  	;
wire			w_cnt_last	;
reg		[8:0]	w_addr		;

wire	[8:0]	r_cnt	  	;
wire			r_cnt_last	;
reg		[8:0]	r_addr		;

//-----------1、根据符号长度选择写计数值------------//	
always@( * ) begin  
    case ( deintv1_din_Map_Type )
		N_48 	:  	cnt_Max = 48 -1	; 
		N_96 	:  	cnt_Max = 96 -1	;  
		N_192	:  	cnt_Max = 192 -1;  
		N_288	:  	cnt_Max = 288 -1;  
		default	:	cnt_Max = 48 -1	;
    endcase 
end


//------------2、buffer读写控制----------------//	
always@(posedge clk or negedge rst_n ) begin
	if(!rst_n)
		buffer_flag <= 1'b0;		//0为A区，1为B区
	else if(w_cnt_last & wr_en)
		buffer_flag <= ~buffer_flag;//0为A区，1为B区
end

//-----------3、buffer写满和读空控制------------//	
always @(posedge clk or negedge rst_n)begin
	if(!rst_n)
		bufferA_full <= 1'b0;
	else if(w_cnt_last & wr_en & ~buffer_flag)
		bufferA_full <= 1'b1;
	else if(r_cnt_last & rd_en & bufferA_full)
		bufferA_full <= 1'b0;
end

always @(posedge clk or negedge rst_n)begin
	if(!rst_n)
		bufferB_full <= 1'b0;
	else if(w_cnt_last & wr_en & buffer_flag)
		bufferB_full <= 1'b1;
	else if(r_cnt_last & rd_en & bufferB_full)
		bufferB_full <= 1'b0;
end
//------buffer写入操作，以行顺序写入------//
counter_in #(.CNT_NUM('d288),
		.ADD(1'b1))
u_counter_w(
.clk		(clk				),	
.rst_n		(rst_n				),
.En_cnt		(wr_en				), 
.cnt_din	(cnt_Max			),     
.cnt		(w_cnt				),	
.cnt_last	(w_cnt_last			)
);

always@(*) begin
	if(!rst_n) 
		w_addr <= 0 ; 
	else begin
        w_addr <= w_cnt;
	end	
end

always@(posedge clk or negedge rst_n ) begin
	if(!rst_n)begin
		bufferA <= 'd0;
		bufferB <= 'd0;	
	end
	else if(wr_en)begin
		if(buffer_flag)
			bufferB[w_addr] <= deintv1_din;
		else
			bufferA[w_addr] <= deintv1_din;
	end	
end
//------buffer读取操作，以列读取------//
counter_in #(.CNT_NUM('d288),
		.ADD(1'b1))
u_counter_r(
.clk		(clk				),	
.rst_n		(rst_n				),
.En_cnt		(rd_en				), 
.cnt_din	(cnt_Max			),     
.cnt		(r_cnt				),	
.cnt_last	(r_cnt_last			)
);

always@(*) begin
	if(!rst_n) 
		r_addr = 0; 
	else begin
		case(deintv1_din_Map_Type)
			N_48	: r_addr =  r_cnt[3:0] + (     r_cnt[3:0]<<1) + r_cnt[8:4] ; //N = 48//w_cnt *3	  
			N_96	: r_addr = (r_cnt[3:0]<<1)  + (r_cnt[3:0]<<2) + r_cnt[8:4] ;//N = 96 //w_cnt *6
			N_192	: r_addr = (r_cnt[3:0]<<3)  + (r_cnt[3:0]<<2) + r_cnt[8:4]; //N = 192//w_cnt *12
			N_288	: r_addr = (r_cnt[3:0]<<4)  + (r_cnt[3:0]<<1) + r_cnt[8:4]; //N = 288//w_cnt *18
			default	: r_addr =  r_cnt[3:0] + (     r_cnt[3:0]<<1) + r_cnt[8:4] ; //N = 48//w_cnt *3
		endcase
	end	
end
wire witch_buff;
assign witch_buff = (rd_en & buffer_flag) ;
assign	deintv1_dout = witch_buff ? bufferA[r_addr] : bufferB[r_addr];

//输出Map_Type
always@(posedge clk or negedge rst_n ) begin
    if(!rst_n) begin 
		deintv1_dout_symb_cnt <= 0;
    end    
    else if(deintv1_dout_vld) begin 
		deintv1_dout_symb_cnt <= deintv1_din_symb_cnt ;
    end   
end 

parameter		PATH0 = "C:/Users/fire/Desktop/par2/";
integer 				deintv1_din_data		;
integer 				deintv1_dout_data		;
initial begin
	deintv1_din_data  =  $fopen({PATH0,"deintv1_din_data.txt"});
	deintv1_dout_data  =  $fopen({PATH0,"deintv1_dout_data.txt"});
end
always@(posedge clk)
begin
  if(deintv1_dout_rdy & deintv1_din_vld)
    begin
      $fdisplay(deintv1_din_data,"%b",deintv1_din);
    end
end
always@(posedge clk)
begin
  if(deintv1_dout_vld & deintv1_din_rdy)
    begin
      $fdisplay(deintv1_dout_data,"%b",deintv1_dout);
    end
end

endmodule
