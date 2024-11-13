`timescale 1ns / 1ps
//二级解交�?//
//只有data域会用到二级解交�?
module deinterleaver_2(    
																				input               clk             		    ,  
																				input               rst_n          			    , 
																				
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_deintv2 TDATA" *)	input               deintv2_din       		    ,  
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_deintv2 TVALID" *)  input               deintv2_din_vld  			,
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_deintv2 TREADY" *)	output           	deintv2_dout_rdy  		    ,

																				input		[7:0]	deintv2_din_symb_cnt		,//symbol_cnt计数�?
																				input       [1:0]   deintv2_din_Map_Type		,

(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_deintv2 TDATA" *)	output           	deintv2_dout      		    , 
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_deintv2 TVALID" *)  output           	deintv2_dout_vld			,   
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_deintv2 TREADY" *)	input				deintv2_din_rdy			    ,

																				output	reg [7:0]	deintv2_dout_symb_cnt		,//symbol_cnt计数�?
																				output  reg [1:0]   deintv2_dout_Map_Type
); 

wire			En_cnt		;
wire	[4:0]	cnt			;
wire			cnt_last	;

wire			S2P_din_vld	;
wire			S2P_din_rdy	;
wire	[1:0]	S2P_dout	;
wire			S2P_dout_vld;
wire			S2P_dout_rdy;

wire	[1:0]	u1_P2S_din		;
wire			u1_P2S_din_vld	;
wire			u1_P2S_din_rdy	;
wire			u1_P2S_dout		;
wire			u1_P2S_dout_vld	;
wire			u1_P2S_dout_rdy ; 

wire	[1:0]	u2_P2S_din		;
wire			u2_P2S_din_vld	;
wire			u2_P2S_din_rdy	;
wire			u2_P2S_dout		;
wire			u2_P2S_dout_vld	;
wire			u2_P2S_dout_rdy ;

assign	deintv2_dout_rdy 	= S2P_dout_rdy;
// assign	deintv2_dout 		= cnt < 12 | (deintv2_din_symb_cnt==3) ? u1_P2S_dout : u2_P2S_dout;
// assign	deintv2_dout_vld    = cnt < 12 | (deintv2_din_symb_cnt==3) ? u1_P2S_dout_vld : u2_P2S_dout_vld;
assign	deintv2_dout 		= cnt < 12  ? u1_P2S_dout : u2_P2S_dout;
assign	deintv2_dout_vld    = cnt < 12  ? u1_P2S_dout_vld : u2_P2S_dout_vld;

assign	En_cnt = (u2_P2S_dout_vld & u2_P2S_din_rdy) | u1_P2S_dout_vld & u1_P2S_din_rdy;

counter #(.CNT_NUM('d24),
		.ADD(1'b1))
u_counter(
	.clk		(clk				),	
	.rst_n		(rst_n				),
	.En_cnt		(En_cnt				),      
	.cnt		(cnt				),	
	.cnt_last	(cnt_last			)
);

assign	S2P_din		 	= deintv2_din    		;
assign	S2P_din_vld  	= deintv2_din_vld		;
assign  S2P_din_rdy		= u1_P2S_dout_rdy &	u2_P2S_dout_rdy;

Ser2Par	#(	.WIDTH		(2),
			.LSB_FIRST	(1'b1))
u_Ser2Par_deintv2(
	.clk		(clk			),
	.rst_n		(rst_n			),
	.din		(S2P_din		),
	.din_vld	(S2P_din_vld	),
	.din_rdy	(S2P_din_rdy	),
	.dout		(S2P_dout		),
	.dout_vld	(S2P_dout_vld	),
	.dout_rdy   (S2P_dout_rdy	)
);

assign u1_P2S_din		= S2P_dout			;
assign u1_P2S_din_vld 	= S2P_dout_vld		;
assign u1_P2S_din_rdy	= deintv2_din_rdy		;

Par2Ser	#(	.WIDTH		(2),
			.LSB_FIRST	(1))
u1_Par2Ser_deintv2(
	.clk		(clk			),
	.rst_n		(rst_n			),
	.din		(u1_P2S_din		),
	.din_vld	(u1_P2S_din_vld	),
	.din_rdy	(u1_P2S_din_rdy	),
	.dout		(u1_P2S_dout	),
	.dout_vld	(u1_P2S_dout_vld),
	.dout_rdy   (u1_P2S_dout_rdy)
);

assign u2_P2S_din		= S2P_dout			;
assign u2_P2S_din_vld 	= S2P_dout_vld		;
assign u2_P2S_din_rdy	= deintv2_din_rdy		;

Par2Ser	#(	.WIDTH		(2),
			.LSB_FIRST	(0))
u2_Par2Ser_deintv2(
	.clk		(clk			),
	.rst_n		(rst_n			),
	.din		(u2_P2S_din		),
	.din_vld	(u2_P2S_din_vld	),
	.din_rdy	(u2_P2S_din_rdy	),
	.dout		(u2_P2S_dout	),
	.dout_vld	(u2_P2S_dout_vld),
	.dout_rdy   (u2_P2S_dout_rdy)
);

//
always@(posedge clk or negedge rst_n ) begin
    if(!rst_n) begin     
		deintv2_dout_symb_cnt <= 0;
		deintv2_dout_Map_Type <= 2'b00;
    end    
    else 
		deintv2_dout_symb_cnt <= deintv2_din_symb_cnt ;
		deintv2_dout_Map_Type <= deintv2_din_Map_Type;
end 





parameter		PATH0 = "E:/86152/FPGA/Verilog/file_management/temp/Receive1.0/";
integer 				deintv2_din_data		;
integer 				deintv2_dout_data		;
initial begin
	deintv2_din_data  =  $fopen({PATH0,"deintv2_din_data.txt"});
	deintv2_dout_data  =  $fopen({PATH0,"deintv2_dout_data.txt"});
end
always@(posedge clk)
begin
  if(deintv2_dout_rdy & deintv2_din_vld)
    begin
      $fdisplay(deintv2_din_data,"%b",deintv2_din);
    end
end
always@(posedge clk)
begin
  if(deintv2_dout_vld & deintv2_din_rdy)
    begin
      $fdisplay(deintv2_dout_data,"%b",deintv2_dout);
    end
end





endmodule


