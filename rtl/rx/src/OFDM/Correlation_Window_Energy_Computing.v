module Correlation_Window_Energy_Computing(Clk,Rst_n, 
                        InputEnable, DataInARe, DataInAIm,
								OutputEnable, Sum16Magnituder);

input Clk;
input Rst_n;
/*��DataBufferForDetection64ģ���ͳ�������������Ч******//////
input InputEnable;
/*�������� 8λλ�� 1λ����λ 1λ����λ 6λС��λ******//////
input [7:0] DataInARe;
input [7:0] DataInAIm;

/*������� ���ݷ���ƽ����16���ۼ���Ч******//////
output OutputEnable;
/*������� ���ݷ���ƽ����16���ۼ�  20λλ��  1λ����λ 8λ����λ 12λС��λ******//////
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
