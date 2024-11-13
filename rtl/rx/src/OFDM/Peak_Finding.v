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

reg [3:0] STS_end_counter;  /*峰值数目计数器******//////
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
					begin      /*absolute_sum位宽22位(1位符号位 + 7位整数位 + 14位小数位)******//////
						if(STS_end_counter < 9)
							begin
								if (BufferData > 22'b0000_0001_10_0000_0000_0000)
									begin
										STS_end_counter <= STS_end_counter + 1;  /*大于阈值，计数器加1******//////
									end
								PeakFinded <= 0;
							end
						else
							begin
								PeakFinded <= 1;  /*当找到9个峰值，即短训练序列的结束位置，把信号拉高******//////
							end
					end
				else
					begin                      /*帧结束时，把寄存器赋予初始值******//////
						STS_end_counter <= 0;
						PeakFinded <= 0;
					end
			end
	end

			
endmodule

