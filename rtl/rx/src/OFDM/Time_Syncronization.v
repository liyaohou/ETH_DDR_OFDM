module Time_Syncronization(
Clk,Rst_n,

DataInRe,DataInIm,
DataInEnable,

DataOutEnable,
DataOutRe,DataOutIm,
Data_out_index,

DataSymbol);

//moduel clock
input Clk;
//the reset signal
input Rst_n;
//the enable signal of the input datas
input DataInEnable;
//the input datas from the CFO_Correlation module: signed 1QN format
input [7:0]DataInRe;
input [7:0]DataInIm;

//the enable signal of the output datas
output DataOutEnable;
//the output datas: signed 1QN format
output [7:0]DataOutRe;
output [7:0]DataOutIm;
output [5:0]Data_out_index;
//the symbol counter
output [7:0]DataSymbol;

//the enable signal of the Quantization results 
wire QuantizationEnable;
//the quantization results
wire [15:0]Quantization_Result_Real;
wire [15:0]Quantization_Result_Imag;

// Quantization Module
Quantization Quantization (
    .Clk(Clk), 
    .Rst_n(Rst_n), 
    .inEn(DataInEnable), 
    .bitInR(DataInRe), 
    .bitInI(DataInIm), 
    .QuantizationEnable(QuantizationEnable), 
    .Quantization_Result_Real(Quantization_Result_Real), 
    .Quantization_Result_Imag(Quantization_Result_Imag)
    );

//the endness of the STS
wire PeakFinded;
// Mathc filter Module
Match_Filtering MatchFiltering (
    .Clk(Clk), 
    .Rst_n(Rst_n), 
    .QuanEnable(QuantizationEnable), 
    .QuanDataRe(Quantization_Result_Real), 
    .QuanDataIm(Quantization_Result_Imag), 
    .PeakFinded(PeakFinded)
    );

//Symbol Output Module
Symbol_Output SymbolOutput (
    .Clk(Clk), 
    .Rst_n(Rst_n), 

    .PeakFinded(PeakFinded),    
    .DataInRe(DataInRe), 
    .DataInIm(DataInIm), 

    .DataOutEnable(DataOutEnable), 
    .DataOutRe(DataOutRe), 
    .DataOutIm(DataOutIm), 

    .Data_out_index(Data_out_index),
    
    .Symbol_cnt(DataSymbol)
    );

endmodule

