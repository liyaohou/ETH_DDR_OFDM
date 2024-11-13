/*********************************/
/*��Correlation_Accumulation�ͳ�OutputEnable��Ч��                                          ******//////
/*����SumDelayCorrelationMagnituder = |SumDelayCorrelationDataInRe|                         ******////// 
/*							  + |SumDelayCorrelationDataInIm|                                      ******//////
/*������ЧInputEnable ��Correlation_Accumulation�ͳ�                                        ******//////
/*��������16�����ڳ��ȵ���ʱ������ SumDelayCorrelationDataInRe SumDelayCorrelationDataInIm******//////
/*��������20λλ��  1λ����λ 7λ����λ 12λС��λ                                          ******//////

/*SumDelayCorrelationMagnituder ��������[18:0]�ĺ�                                          ******//////
/*�������SumDelayCorrelationMagnituder                                                     ******//////
/*��������20λλ��  1λ����λ 7λ����λ 12λС��λ                                          ******//////
/*********************************/
module Range_Simplified_Computing(Clk,Rst_n, 
                                  InputEnable, SumDelayCorrelationDataInRe, SumDelayCorrelationDataInIm,
				                      OutputEnable, SumDelayCorrelationMagnituder);
input Clk;
input Rst_n;
/*��SlideWindowForCorrelation�ͳ�������������Ч******//////
input InputEnable;
/*�������� 16�����ڳ��ȵ���ʱ������ 20λλ��  1λ����λ 7λ����λ 12λС��λ******//////
input [19:0] SumDelayCorrelationDataInRe;
input [19:0] SumDelayCorrelationDataInIm;

/*�������  16�����ڳ��ȵ���ʱ�����ͷ�����Ч******//////
output OutputEnable;
/*������� 16�����ڳ��ȵ���ʱ�����ͷ��� 21λλ��  1λ����λ 8λ����λ 12λС��λ******//////
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

