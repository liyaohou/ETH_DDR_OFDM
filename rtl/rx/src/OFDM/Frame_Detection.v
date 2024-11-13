module Frame_Detection(
    input                   Clk,
    input                   Rst_n,
    //杈撳叆鏁版嵁锛屽疄閮ㄥ拰铏氶儴
//    input                   bitIn_vld,
    input [7:0]             bitInR,
    input [7:0]             bitInI,
    //甯ф暟鎹娇鑳?
    output                  FrameEnable,
    //鎺ュ彈鐨勫抚鏁版嵁
    output [7:0]            bitOutR,
    output [7:0]            bitOutI
                       );

//甯у悓姝ヤ俊鍙?
wire                        FrameFinded;
//鏁版嵁缂撳瓨鍣ㄨ緭鍑轰娇鑳斤紝杈撳嚭甯ф暟鎹?
wire                        DataBufferOutputEnable;
//甯ф娴嬫ā鍧椾娇鑳?
wire                        FrameDetectionEnable;


Top_Control Top_Control (
    .Clk(Clk), 
    .Rst_n(Rst_n), 
    .FrameFinded(FrameFinded), 
    .DataBufferOutputEnable(DataBufferOutputEnable), 
    .FrameDetectionEnable(FrameDetectionEnable)
    );

//鏁版嵁缂撳瓨浣胯兘淇″彿
wire                        Buffer_Enable;
//褰撳墠鏁版嵁
wire [7:0]                  DataARe;  
wire [7:0]                  DataAIm;
//寤惰繜鍚庢暟鎹?
wire [7:0]DataBRe;
wire [7:0]DataBIm;

Data_Buffer_Shiftram Data_Buffer_Shiftram (
    .Clk(Clk), 
    .Rst_n(Rst_n), 
    .InputEnable(FrameDetectionEnable), 
    .DataInRe(bitInR), 
    .DataInIm(bitInI), 
    .Buffer_Enable(Buffer_Enable), 
    .DataARe(DataARe), 
    .DataAIm(DataAIm), 
    .DataBRe(DataBRe), 
    .DataBIm(DataBIm), 
    .FrameFinded(DataBufferOutputEnable), 
    .OutputEnable(FrameEnable), 
    .DataOutRe(bitOutR), 
    .DataOutIm(bitOutI)
    );

//寤舵椂鐩稿叧姹傚拰浣胯兘
wire SumDelayCorrelationMagnituderEnable;
//寤舵椂鐩稿叧鍜岀殑澶у皬
wire [20:0] SumDelayCorrelationMagnituder;
//寤惰繜鐩稿叧鑳介噺璁＄畻妯″潡
Delay_Correlation_Energy_Computing Delay_Correlation_Energy_Computing (
    .Clk(Clk), 
    .Rst_n(Rst_n), 
    .InputEnable(Buffer_Enable), 
    .DataInARe(DataARe), 
    .DataInAIm(DataAIm), 
    .DataInBRe(DataBRe), 
    .DataInBIm(DataBIm), 
    .OutputEnable(SumDelayCorrelationMagnituderEnable), 
    .SumDelayCorrelationMagnituder(SumDelayCorrelationMagnituder)
    );

wire Sum16MagnituderEnable;
//鑳介噺鍜岃绠楁ā鍧?
wire [20:0] Sum16Magnituder;
Correlation_Window_Energy_Computing Correlation_Window_Energy_Computing (
    .Clk(Clk), 
    .Rst_n(Rst_n), 
    .InputEnable(Buffer_Enable), 
    .DataInARe(DataARe), 
    .DataInAIm(DataAIm), 
    .OutputEnable(Sum16MagnituderEnable), 
    .Sum16Magnituder(Sum16Magnituder)
    );

//甯ф娴嬫ā鍧?
Frame_Finding Frame_Finding (
    .Clk(Clk), 
    .Rst_n(Rst_n), 
    .SumMagnituderEnable(Sum16MagnituderEnable), 
    .SumMagnituder(Sum16Magnituder), 
    .SumDelayCorrelationEnable(SumDelayCorrelationMagnituderEnable), 
    .SumDelayCorrelation(SumDelayCorrelationMagnituder), 
    .FrameFind(FrameFinded)
    );

endmodule
