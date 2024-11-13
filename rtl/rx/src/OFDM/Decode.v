`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/08 21:14:17
// Design Name: 
// Module Name: Decode
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


module Decode(
    input       clk,
    input       rst_n,

    input       deintv2_din,
    input       deintv2_din_vld,
    output      deintv2_dout_rdy,
    input [7:0] deintv2_din_symb_cnt,
    input [1:0] deintv2_din_Map_Type,

    output      descram_dout,
    output      descram_dout_vld,
    input       descram_din_rdy,
    output      descram_dout_last,
    output [7:0]descram_dout_symb_cnt
    );



// deinterleaver_2 Outputs
wire  deintv2_dout                         ;
wire  deintv2_dout_vld                     ;
wire  deintv2_din_rdy                      ;
wire  [7:0]  deintv2_dout_symb_cnt         ;
wire  [1:0]  deintv2_dout_Map_Type         ;
// deinterleaver_2
deinterleaver_2  u_deinterleaver_2 (
    .clk                     ( clk                          ),
    .rst_n                   ( rst_n                        ),

    .deintv2_din             ( deintv2_din                  ),
    .deintv2_din_vld         ( deintv2_din_vld              ),
    .deintv2_dout_rdy        ( deintv2_dout_rdy             ),
    .deintv2_din_symb_cnt    ( deintv2_din_symb_cnt   [7:0] ),
    .deintv2_din_Map_Type    ( deintv2_din_Map_Type   [1:0] ),

    .deintv2_dout            ( deintv2_dout                 ),
    .deintv2_dout_vld        ( deintv2_dout_vld             ),
    .deintv2_din_rdy         ( deintv2_din_rdy              ),
    .deintv2_dout_symb_cnt   ( deintv2_dout_symb_cnt  [7:0] ),
    .deintv2_dout_Map_Type   ( deintv2_dout_Map_Type  [1:0] )
);


// deinterleaver_1 Inputs
wire   deintv1_din                          ;
wire   deintv1_din_vld                      ;
wire   deintv1_dout_rdy                     ;
wire   [7:0]  deintv1_din_symb_cnt          ;
wire   [1:0]  deintv1_din_Map_Type          ;

assign deintv1_din = deintv2_dout;
assign deintv1_din_vld = deintv2_dout_vld;
assign deintv2_din_rdy = deintv1_dout_rdy;
assign deintv1_din_symb_cnt = deintv2_dout_symb_cnt;
assign deintv1_din_Map_Type = deintv2_dout_Map_Type;

// deinterleaver_1 Outputs
wire  deintv1_dout                         ;
wire  deintv1_dout_vld                     ;
wire  deintv1_din_rdy                      ;
wire  [7:0]  deintv1_dout_symb_cnt         ;

deinterleaver_1  u_deinterleaver_1 (
    .clk                     ( clk                          ),
    .rst_n                   ( rst_n                        ),

    .deintv1_din             ( deintv1_din                  ),
    .deintv1_din_vld         ( deintv1_din_vld              ),
    .deintv1_dout_rdy        ( deintv1_dout_rdy             ),
    .deintv1_din_symb_cnt    ( deintv1_din_symb_cnt   [7:0] ),
    .deintv1_din_Map_Type    ( deintv1_din_Map_Type   [1:0] ),

    .deintv1_dout            ( deintv1_dout                 ),
    .deintv1_dout_vld        ( deintv1_dout_vld             ),
    .deintv1_din_rdy         ( deintv1_din_rdy              ),
    .deintv1_dout_symb_cnt   ( deintv1_dout_symb_cnt  [7:0] )
);


// decoder_in_S2P Inputs
wire  din_Ser                              ;
wire  din_vld                              ;
wire  dout_rdy                             ;
assign din_Ser = deintv1_dout;
assign din_vld = deintv1_dout_vld;
assign deintv1_din_rdy = dout_rdy;
// decoder_in_S2P Outputs
wire  [1:0]  dout_Par                      ;
wire  dout_vld                             ;
wire  din_rdy                              ;

decoder_in_S2P  u_decoder_in_S2P (

    .clk                     ( clk             ),
    .rst_n                   ( rst_n           ),

    .din_Ser                 ( din_Ser         ),
    .din_vld                 ( din_vld         ),
    .dout_rdy                ( dout_rdy        ),

    .dout_Par                ( dout_Par  [1:0] ),
    .dout_vld                ( dout_vld        ),
    .din_rdy                 ( din_rdy         )

);



// decoder Inputs
wire   [1:0]  decoder_din                   ;
wire   decoder_din_valid                    ;
wire   decoder_dout_ready                   ;
wire   [7:0]  decoder_din_symb_cnt          ;

assign decoder_din = dout_Par;
assign decoder_din_valid = dout_vld;
assign din_rdy = decoder_dout_ready;
assign decoder_din_symb_cnt = deintv1_dout_symb_cnt;

// decoder Outputs
wire  decoder_dout                         ;
wire  decoder_dout_valid                   ;
wire   decoder_din_ready                    ;
wire  [7:0]  decoder_dout_symb_cnt         ;



decoder u_decoder (
    .clk                     ( clk              ),
    .rst_n                   ( rst_n           ),

    .decoder_din             ( decoder_din            [1:0] ),
    .decoder_din_valid       ( decoder_din_valid            ),
    .decoder_dout_ready      ( decoder_dout_ready           ),
    .decoder_din_symb_cnt    ( decoder_din_symb_cnt   [7:0] ),

    .decoder_dout            ( decoder_dout                 ),
    .decoder_dout_valid      ( decoder_dout_valid           ),
    .decoder_din_ready       ( decoder_din_ready            ),
    .decoder_dout_symb_cnt   ( decoder_dout_symb_cnt  [7:0] )
);

// descrambler Inputs
wire   descram_din                           ;
wire   descram_din_vld                       ;
wire   descram_dout_rdy                      ;
wire   [7:0]  descram_din_symb_cnt           ;
assign descram_din = decoder_dout;
assign descram_din_vld = decoder_dout_valid;
assign decoder_din_ready = descram_dout_rdy;
assign descram_din_symb_cnt = decoder_dout_symb_cnt;

descrambler  u_descrambler (
    .clk                     ( clk                          ),
    .rst_n                   ( rst_n                        ),

    .descram_din             ( descram_din                  ),
    .descram_din_vld         ( descram_din_vld              ),
    .descram_dout_rdy        ( descram_dout_rdy             ),
    .descram_din_symb_cnt    ( descram_din_symb_cnt   [7:0] ),

    .descram_dout            ( descram_dout                 ),
    .descram_dout_vld        ( descram_dout_vld             ),
    .descram_din_rdy         ( descram_din_rdy              ),
    .descram_dout_symb_last  (descram_dout_last),
    .descram_dout_symb_cnt   ( descram_dout_symb_cnt  [7:0] )
);


    
endmodule
