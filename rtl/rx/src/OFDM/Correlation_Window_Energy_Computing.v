module Correlation_Window_Energy_Computing(Clk,Rst_n, 
                        InputEnable, DataInARe, DataInAIm,
								OutputEnable, Sum16Magnituder);

input Clk;
input Rst_n;
/*由DataBufferForDetection64模块送出的输入数据有效******//////
input InputEnable;
/*数据输入 8位位宽 1位符号位 1位整数位 6位小数位******//////
input [7:0] DataInARe;
input [7:0] DataInAIm;

/*输出数据 数据幅度平方的16个累加有效******//////
output OutputEnable;
/*输出数据 数据幅度平方的16个累加  20位位宽  1位符号位 8位整数位 12位小数位******//////
output [20:0] Sum16Magnituder;

//the enable signal of the data magnitue
wire DataMagnitudeEnable;
//the data magnitude
wire [16:0]DataMagnitude;
//Energy Computation Module
Energy_Computing Energy_Computing (
    .Clk(Clk), 
    .Rst_n(Rst_n), 
    .InputEnable(InputEnable), 
    .DataInARe(DataInARe), 
    .DataInAIm(DataInAIm), 
    .OutputEnable(DataMagnitudeEnable), 
    .DataMagnitude(DataMagnitude)
    );

//the enable of the sum
wire SumMagnituderEnable;
//the sum of the data magnitude
wire [20:0] SumMagnituder;
//Energy Accumulation Module
Energy_Accumulation Energy_Accumulation (
    .Clk(Clk), 
    .Rst_n(Rst_n), 
    .InputEnable(DataMagnitudeEnable), 
    .DataInMagnituder(DataMagnitude), 
    .OutputEnable(SumMagnituderEnable), 
    .Sum16Magnituder(SumMagnituder)
    );

//Data Buffer for Delay Module
Data_Buffer_For_Delay Data_Buffer_For_Delay (
    .Clk(Clk), 
    .Rst_n(Rst_n), 
    .InputEnable(SumMagnituderEnable), 
    .DataIn(SumMagnituder), 
    .OutputEnable(OutputEnable), 
    .DataOut(Sum16Magnituder)
    );

endmodule
