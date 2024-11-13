/*********************************/
/*在Correlation_Accumulation送出OutputEnable有效下                                          ******//////
/*计算SumDelayCorrelationMagnituder = |SumDelayCorrelationDataInRe|                         ******////// 
/*							  + |SumDelayCorrelationDataInIm|                                      ******//////
/*输入有效InputEnable 由Correlation_Accumulation送出                                        ******//////
/*输入数据16个窗口长度的延时相关求和 SumDelayCorrelationDataInRe SumDelayCorrelationDataInIm******//////
/*输入数据20位位宽  1位符号位 7位整数位 12位小数位                                          ******//////

/*SumDelayCorrelationMagnituder 输入数据[18:0]的和                                          ******//////
/*输出数据SumDelayCorrelationMagnituder                                                     ******//////
/*输入数据20位位宽  1位符号位 7位整数位 12位小数位                                          ******//////
/*********************************/
module Range_Simplified_Computing(Clk,Rst_n, 
                                  InputEnable, SumDelayCorrelationDataInRe, SumDelayCorrelationDataInIm,
				                      OutputEnable, SumDelayCorrelationMagnituder);
input Clk;
input Rst_n;
/*由SlideWindowForCorrelation送出的输入数据有效******//////
input InputEnable;
/*输入数据 16个窗口长度的延时相关求和 20位位宽  1位符号位 7位整数位 12位小数位******//////
input [19:0] SumDelayCorrelationDataInRe;
input [19:0] SumDelayCorrelationDataInIm;

/*输出数据  16个窗口长度的延时相关求和幅度有效******//////
output OutputEnable;
/*输出数据 16个窗口长度的延时相关求和幅度 21位位宽  1位符号位 8位整数位 12位小数位******//////
output [20:0] SumDelayCorrelationMagnituder;

reg OutputEnable;
reg [20:0] SumDelayCorrelationMagnituder;


/*Compute TempSumMagnituder = |SumDelayCorrelationDataInRe| + |SumDelayCorrelationDataInIm|******//////

reg [19:0] TempDataRe;
reg [19:0] TempDataIm;
reg TempEnable;
//Compute |SumDelayCorrelationDataInRe| and |SumDelayCorrelationDataInIm|
always @(posedge Clk or negedge Rst_n)
	begin
		if(!Rst_n)
			begin
				TempEnable <= 0;
				TempDataRe <= 0;
				TempDataIm <= 0;
			end
		else
			begin
				if(InputEnable)
					begin
						TempEnable <= 1;
						if(SumDelayCorrelationDataInRe[19])
							TempDataRe <= ~SumDelayCorrelationDataInRe + 1;
						else
							TempDataRe <= SumDelayCorrelationDataInRe;
						if(SumDelayCorrelationDataInIm[19])
							TempDataIm <= ~SumDelayCorrelationDataInIm + 1;
						else
							TempDataIm <= SumDelayCorrelationDataInIm;
					end
				else
					begin
						TempEnable <= 0;
						TempDataRe <= 0;
						TempDataIm <= 0;
					end
			end
	end

always @(posedge Clk or negedge Rst_n)
	begin
		if(!Rst_n)
			begin
				OutputEnable <= 0;
				SumDelayCorrelationMagnituder <= 0;
			end
		else
			begin
				if(TempEnable)
					begin
						OutputEnable <= 1;
						SumDelayCorrelationMagnituder <= {TempDataRe[19],TempDataRe} + {TempDataIm[19],TempDataIm};
					end
				else
					begin
						OutputEnable <= 0;
						SumDelayCorrelationMagnituder <= 0;
					end
			end
	end

endmodule

