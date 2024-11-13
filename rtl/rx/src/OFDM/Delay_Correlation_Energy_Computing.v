module Delay_Correlation_Energy_Computing
    (Clk,
    Rst_n,
    InputEnable,
    DataInARe,DataInAIm,
    DataInBRe,DataInBIm,
    OutputEnable,
    SumDelayCorrelationMagnituder);

input Clk;
input Rst_n;

/*由Data Buffer模块送出的输入数据有�?******//////
input InputEnable;
/*数据输入 8位位�? 1位符号位 1位整数位 6位小数位******////// 
input [7:0] DataInARe; /*当前输入数据******//////
input [7:0] DataInAIm;
input [7:0] DataInBRe; /*当前输入数据前第16个数�?******//////
input [7:0] DataInBIm;

/*输出数据  16个窗口长度的延时相关求和幅度有效******//////
output OutputEnable;
/*输出数据 16个窗口长度的延时相关求和幅度  21位位�?  1位符号位 8位整数位 12位小数位******//////
output [20:0] SumDelayCorrelationMagnituder;


//the enable signal of the correlation results
wire DelayCorrelationEnable;
//the delay correlation results
wire [15:0] DelayCorrelationRe;
wire [15:0] DelayCorrelationIm;
//Delay Correlation Computation Module
Delay_Correlation_Computing Delay_Correlation_Computing (
    .Clk(Clk), 
    .Rst_n(Rst_n), 
    .InputEnable(InputEnable), 
    .DataInARe(DataInARe), 
    .DataInAIm(DataInAIm), 
    .DataInBRe(DataInBRe), 
    .DataInBIm(DataInBIm), 
    .OutputEnable(DelayCorrelationEnable), 
    .DataOutRe(DelayCorrelationRe), 
    .DataOutIm(DelayCorrelationIm)
    );

//the enable signal of the sum
wire Sum16DelayCorrelationEnable;
//the sum of the delay correlation results
wire [19:0] Sum16DelayCorrelationRe;
wire [19:0] Sum16DelayCorrelationIm;
// Correlation Accumulation Module
Correlation_Accumulation_frame Correlation_Accumulation (
    .Clk(Clk), 
    .Rst_n(Rst_n), 
    .InputEnable(DelayCorrelationEnable), 
    .DelayCorrelationRe(DelayCorrelationRe), 
    .DelayCorrelationIm(DelayCorrelationIm), 
    .OutputEnable(Sum16DelayCorrelationEnable), 
    .Sum16DelayCorrelationRe(Sum16DelayCorrelationRe), 
    .Sum16DelayCorrelationIm(Sum16DelayCorrelationIm)
    );

// Range Simplified Computation Module
Range_Simplified_Computing Range_Simplified_Computing (
    .Clk(Clk), 
    .Rst_n(Rst_n), 
    .InputEnable(Sum16DelayCorrelationEnable), 
    .SumDelayCorrelationDataInRe(Sum16DelayCorrelationRe), 
    .SumDelayCorrelationDataInIm(Sum16DelayCorrelationIm), 
    .OutputEnable(OutputEnable), 
    .SumDelayCorrelationMagnituder(SumDelayCorrelationMagnituder)
    );

endmodule
