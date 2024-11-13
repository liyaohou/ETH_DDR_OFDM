`timescale 1ns / 1ps
module Frame_Detection_tb();

parameter		PATH 	= "C:/Users/Administrator/Desktop/frame_detect/v/";//锟斤拷址
parameter 		T = 8			;
//integer         dac_data_out;  
//integer         i;
  
reg                   Clk;
reg                   Rst_n;
//锟斤拷锟斤拷锟斤拷锟捷ｏ拷实锟斤拷锟斤拷锟介�?
reg [7:0]             bitInR;
reg [7:0]             bitInI;
//帧锟斤拷锟斤拷使锟斤�?
wire                  FrameEnable;
//锟斤拷锟杰碉拷帧锟斤拷锟斤拷
wire [7:0]            bitOutR;
wire [7:0]            bitOutI;

reg   	  [15:0]	test_data_byte [719:0];
wire     [15:0]  test_data_in;

Frame_Detection Frame_Detection_inst(
    .Clk    (Clk),
    .Rst_n  (Rst_n),
    .bitInR (bitInR),
    .bitInI (bitInI),
    .FrameEnable(FrameEnable),
    .bitOutR(bitOutR),
    .bitOutI(bitOutI)
);

    always #(T/2) Clk = ~Clk;


    wire [$clog2(720)-1:0]                 cnt_r;
    reg  [$clog2(720)-1:0]                 cnt;
    reg cnt_vld;
    assign cnt_r  =  cnt;  
    assign test_data_in = cnt_r == 720 ?0 :test_data_byte[cnt_r];
    always @(posedge Clk or negedge Rst_n)begin
        if(!Rst_n)begin
          bitInR <= 0;
          bitInI <= 0;
        end
        else if(cnt_vld)begin
          bitInR <= test_data_in[15:8];
          bitInI <= test_data_in[7:0];
          end            
        end

initial begin
	Clk = 1'b0;
	Rst_n = 1'b0;
    $readmemb({PATH,"dac_data_out.txt"},test_data_byte);
	#(10*T)
	Rst_n = 1'b1;
	
end

//锟斤拷锟斤拷锟斤�?
    always @(posedge Clk or negedge Rst_n)begin
        if(!Rst_n)begin
            cnt <= 0;
            cnt_vld <= 1;
            end
        else if(cnt == 720 )begin
                cnt <= 0;
                cnt_vld <=0 ;
                end
            else if (cnt_vld)begin
                cnt <= cnt + 1'b1;
                cnt_vld <= cnt_vld;
                end
        end  
    
endmodule
