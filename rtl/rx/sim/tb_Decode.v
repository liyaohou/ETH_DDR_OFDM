`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/08 21:43:08
// Design Name: 
// Module Name: tb_Decode
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




module tb_Decode();

parameter PERIOD  = 10;
reg   clk                                  = 1 ;
reg   rst_n                                = 0 ;
reg   areset_n                             = 0 ;
initial
begin
    forever #(PERIOD/2)  clk=~clk;
end
initial
begin
    #(PERIOD*2) rst_n  =  1;areset_n = 1;
end

parameter PATH="C:/Users/xy314/Desktop/";
parameter NUM = 960;
reg    read_data01[NUM-1:0] ;
initial begin
    #1000;
    $readmemb({PATH,"u_intv2_out.txt"}, read_data01);
end


reg            din          =0;
reg            din_vld      =0;
reg            din_rdy      =0;
reg    [7:0]   din_symb_cnt =0;


wire           dout;
wire           dout_vld;
wire           dout_rdy;
wire    [7:0]  dout_symb_cnt;


reg     [4:0]       cnt             =0;
reg     [16:0]       i               =0;

reg     [0:31]      data_to_send  =32'b11000110_00010110_00000011_10011010;
// reg     [31:0]      data_to_send    =32'b10101010_01010101_11110000_01010101;
parameter   LONG_PERIOD = PERIOD*600;
parameter   PERIOD8     = PERIOD*8;

initial begin
    #LONG_PERIOD;
    #PERIOD;
    din_symb_cnt = 4;
    din_rdy  =1;

    while(i<NUM)begin
        while(!dout_rdy)begin
            #PERIOD;
        end
        din = read_data01[i];       // Output the current digit
        i=i+1;

        din_vld = 1;      // Valid data for one clock cycle
        #PERIOD;                    // Wait for one clock period
    end
    i=0;
    din_vld=0;

    #LONG_PERIOD;
    areset_n = 0;
    #PERIOD;#PERIOD;
    areset_n = 1;
    #LONG_PERIOD;

    while(i<NUM)begin
        while(!dout_rdy)begin
            #PERIOD;
        end
        din = read_data01[i];       // Output the current digit
        i=i+1;

        din_vld = 1;      // Valid data for one clock cycle
        #PERIOD;                    // Wait for one clock period
    end
    din_vld=0;

    #LONG_PERIOD;
    #LONG_PERIOD;
    $finish;
end


Decode u_tb_Decode_1
(
    .clk(clk),
    .rst_n(rst_n),

    .deintv2_din            (din),
    .deintv2_din_vld        (din_vld),
    .deintv2_dout_rdy       (dout_rdy),
    .deintv2_din_symb_cnt   (din_symb_cnt),

    .descram_dout           (dout),
    .descram_dout_vld       (dout_vld),
    .descram_din_rdy        (din_rdy),
    .descram_dout_symb_cnt  (dout_symb_cnt)
);

endmodule
