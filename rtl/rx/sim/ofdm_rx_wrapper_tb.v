`timescale 1ns / 1ps
module ofdm_rx_wrapper_tb();

    parameter		PATH 	= "C:/Users/xy314/Desktop/ofdm_rx/frame_detect2/frame_detect.srcs/";//闁跨喐鏋婚幏宄版絻
    parameter 		T = 20			;
    parameter      DATA_NUM = 960   ;
     
  
      reg  sys_clk_50m;  
      wire locked;
      
      reg [15:0]ADC_data_20m_0;//////////////////
      wire clk_125m;
    //   wire DataOutEnable_0;
    //   wire [7:0]DataOutIm_0;
    //   wire [7:0]DataOutRe_0;
    //   wire [7:0]DataSymbol_0;
      reg Rst_n_0;
      wire clk_20m;   
      reg [7:0]bitInI_0;
      reg [7:0]bitInR_0;

        wire [7:0]fft_dout_im_0;
        wire [7:0]fft_dout_index_0;
        wire [7:0]fft_dout_re_0;
        wire fft_dout_vld_0;
   
        wire [$clog2(DATA_NUM)-1:0]   cnt_r;
        reg  [$clog2(DATA_NUM)-1:0]   cnt;
        reg  [15:0]	             test_data_byte [DATA_NUM-1:0];
        wire [15:0]              test_data_in;
//        wire [13:0]              dac_data_out;
        reg cnt_vld;
        assign cnt_r  =  cnt;  
        assign test_data_in = cnt_r == DATA_NUM ?0 :test_data_byte[cnt_r];
//        assign dac_data_out = {test_data_in[15:9],test_data_in[7:1]   };
    
       always #(T/2) sys_clk_50m = ~sys_clk_50m;   
       
      clk_wiz_0 clk_wiz_inst
           (
            // Clock out ports
            .clk_out1(clk_125m),     // output clk_out1
            .clk_out2(clk_20m),     // output clk_out2
            // Status and control signals
            .reset(~Rst_n_0), // input reset
            .locked(locked),       // output locked
           // Clock in ports
            .clk_in1(sys_clk_50m)      // input clk_in1
        );

    initial begin
        sys_clk_50m = 1'b0;
        Rst_n_0 = 1'b0;
        $readmemb({PATH,"dac_data_out.txt"},test_data_byte);
        #(10*T)
        Rst_n_0 = 1'b1;
        
    end       
    
    always @(posedge clk_20m or negedge Rst_n_0)begin
        if(!Rst_n_0)begin
            bitInI_0 <= 0;
            bitInR_0 <= 0;
        end
        else if(cnt_vld)begin
            bitInI_0 <= test_data_in[7:0];
            bitInR_0 <= test_data_in[15:8];
          end            
        end
    
    //闁跨喐鏋婚幏鐑芥晸閺傘倖瀚归柨鐔告灮閿燂拷?
    always @(posedge clk_20m or negedge Rst_n_0)begin
        if(!Rst_n_0)begin
            cnt <= 0;
            cnt_vld <= 1;
            end
        else if(cnt == DATA_NUM )begin
                cnt <= 0;
                cnt_vld <=0 ;
                end
            else if (cnt_vld)begin
                cnt <= cnt + 1'b1;
                cnt_vld <= cnt_vld;
                end
        end  

     Sync_FFT Sync_FFT_inst
       (
        .Clk_0              (clk_20m           ),
        // .DataOutEnable_0    (DataOutEnable_0    ),
        // .DataOutIm_0        (DataOutIm_0        ),
        // .DataOutRe_0        (DataOutRe_0        ),
        // .DataSymbol_0       (DataSymbol_0       ),
        .Rst_n_0            (Rst_n_0            ),
        .bitInI_0          (bitInI_0           ),
        .bitInR_0           (bitInR_0),
        .fft_dout_im_0      (fft_dout_im_0),
        .fft_dout_index_0   (fft_dout_index_0),
        .fft_dout_re_0      (fft_dout_re_0),
        .fft_dout_vld_0     (fft_dout_vld_0)
    );
  

endmodule
