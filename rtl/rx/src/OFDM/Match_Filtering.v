module Match_Filtering(Clk,Rst_n,QuanEnable,QuanDataRe,QuanDataIm,PeakFinded);

input Clk;
input Rst_n;
input QuanEnable;
input [15:0]QuanDataRe;
input [15:0]QuanDataIm;

output PeakFinded;

//the enable signal of the sum
wire CorrelationEnable;
//the sum of the correlation results
wire [20:0]CorrelationSumR;
wire [20:0]CorrelationSumI;

// Correlation and Accumulation Module
Correlating_and_Accumulating Correlating_and_Accumulating (
    .Clk(Clk), 
    .Rst_n(Rst_n), 
    .QuanEnable(QuanEnable), 
    .QuanDataR(QuanDataRe), 
    .QuanDataI(QuanDataIm), 
    .CorrelationSumR(CorrelationSumR), 
    .CorrelationSumI(CorrelationSumI), 
    .CorrelationEnable(CorrelationEnable)
    );

wire AbsoluteEnable;
//the magnitude of the sum
wire [21:0] Absolute;
//Magnitude Simplified Computation Module
Magnitude_Simplified_Computing Magnitude_Simplified_Computing (
    .Clk(Clk), 
    .Rst_n(Rst_n), 
    .DataEnable(CorrelationEnable), 
    .DataInRe(CorrelationSumR), 
    .DataInIm(CorrelationSumI), 
    .AbsoluteEnable(AbsoluteEnable), 
    .Absolute(Absolute)
    );
	 
//Peak Finding Module
Peak_Finding Peak_Finding (
    .Clk(Clk), 
    .Rst_n(Rst_n), 
    .DataEnable(AbsoluteEnable), 
    .AbsoluteData(Absolute), 
    .PeakFinded(PeakFinded)
    );

endmodule

