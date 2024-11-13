module Peak_Finding(Clk,Rst_n,DataEnable,AbsoluteData,PeakFinded);

input Clk;
input Rst_n;
input DataEnable;
input [21:0]AbsoluteData;

output PeakFinded;
reg PeakFinded;

//the enable singal buffer
reg BufferEnable;
//the input data buffer
reg [21:0]BufferData;

always @(posedge Clk or negedge Rst_n)
	begin
		if(!Rst_n)
			begin
				BufferEnable <= 0;
				BufferData <= 0;
			end
		else
			begin
				if(DataEnable)
					begin
						BufferEnable <= 1;
						BufferData <= AbsoluteData;
					end
				else
					begin
						BufferEnable <= 0;
						BufferData <= 0;
					end
			end
	end

reg [3:0] STS_end_counter;  /*��ֵ��Ŀ������******//////
always @(posedge Clk or negedge Rst_n)
	begin
		if(!Rst_n)
			begin
				STS_end_counter <= 0;
				PeakFinded <= 0;
			end
		else
			begin
				if(BufferEnable)
					begin      /*absolute_sumλ��22λ(1λ����λ + 7λ����λ + 14λС��λ)******//////
						if(STS_end_counter < 9)
							begin
								if (BufferData > 22'b0000_0001_10_0000_0000_0000)
									begin
										STS_end_counter <= STS_end_counter + 1;  /*������ֵ����������1******//////
									end
								PeakFinded <= 0;
							end
						else
							begin
								PeakFinded <= 1;  /*���ҵ�9����ֵ������ѵ�����еĽ���λ�ã����ź�����******//////
							end
					end
				else
					begin                      /*֡����ʱ���ѼĴ��������ʼֵ******//////
						STS_end_counter <= 0;
						PeakFinded <= 0;
					end
			end
	end

			
endmodule

