`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/07 18:58:11
// Design Name: 
// Module Name: decoder_in_S2P
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module decoder_in_S2P(

(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_dencoder_in_S2P TDATA" *)	input din_Ser,
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_dencoder_in_S2P TVALID" *)	input din_vld,
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_dencoder_in_S2P TREADY" *)	output dout_rdy,

(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_dencoder_in_S2P TDATA" *)	output [1:0] dout_Par,
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_dencoder_in_S2P TVALID" *)	output dout_vld,
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_dencoder_in_S2P TREADY" *)	input din_rdy,

    input clk,
    input rst_n

);



wire [0:0]    s_axis_payload    ;
wire          s_axis_valid      ;
wire          s_axis_ready      ;
wire [1:0]    m_axis_payload    ;
wire          m_axis_valid      ;
wire          m_axis_ready      ;

wire [8:0]    occupancy         ;
wire [8:0]    availability      ;

//编码器输出与FIFO的接口
assign  s_axis_payload = din_Ser;
assign  s_axis_valid = din_vld ;
assign  dout_rdy = s_axis_ready;


StreamSToP256 u_S2P(
    .s_axis_payload     (s_axis_payload),
    .s_axis_valid       (s_axis_valid),
    .s_axis_ready       (s_axis_ready), 

    .m_axis_payload     (m_axis_payload),
    .m_axis_valid       (m_axis_valid),
    .m_axis_ready       (m_axis_ready),

    .occupancy          (occupancy),
    .availability       (availability),
    .clk                (clk),
    .resetn             (rst_n)
);


assign dout_Par = m_axis_payload;
assign dout_vld = m_axis_valid  ;
assign m_axis_ready = din_rdy   ;


endmodule

