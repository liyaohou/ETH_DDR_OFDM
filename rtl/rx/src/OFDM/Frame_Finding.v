/***************************************************/
/*比较Correlation_Window_Energy_Computing输出的当前信号幅度平方求和的结果******//////
/*和Delay_Correlation_Energy_Comuting 输出的当前信号延时相关求和的结果   ******//////

/*连续32个点 Magnituder * 0.5 < DelayCorrelation                         ******//////
/*则分组起始出现了                                                       ******//////
/*输入数据SumMagnituder       当前信号幅度平方求和的结�?                 ******//////
/*输入数据SumDelayCorrelation 当前信号延时相关求和的结�?                 ******//////
/*输入数据21位位�?  1位符号位 8位整数位 12位小数位                       ******//////
 
/***************************************************/
module Frame_Finding(Clk, Rst_n,
                    SumMagnituderEnable, SumMagnituder, 
					SumDelayCorrelationEnable, SumDelayCorrelation,
					FrameFind);
input Clk;

/*全局复位******//////
input Rst_n;

/*输入当前信号幅度平方求和有效******//////
input SumMagnituderEnable;
/*输入当前信号幅度平方求和******//////
/*输入数据21位位�?  1位符号位 8位整数位 12位小数位 ******//////
input [20:0] SumMagnituder;


/*输入当前信号延时相关求和有效******//////
input SumDelayCorrelationEnable;
/*输入当前信号延时相关求和******//////
/*输入数据21位位�?  1位符号位 8位整数位 12位小数位******//////
input [20:0] SumDelayCorrelation;

output FrameFind;
reg FrameFind;

reg [20:0] BufferSumMagnituder;
reg [20:0] BufferSumDelayCorrelation;
reg BufferEnable;

always @(posedge Clk or negedge Rst_n)
	begin
		if(!Rst_n)
			begin
				BufferEnable <= 0;
				BufferSumMagnituder <= 0;
				BufferSumDelayCorrelation <= 0;
			end
		else
			begin
				if((SumMagnituderEnable)&&(SumDelayCorrelationEnable) ) /*两路信号同时有效******//////
					begin
						BufferEnable <= 1;
						BufferSumMagnituder <= SumMagnituder;
						BufferSumDelayCorrelation <= SumDelayCorrelation;
					end
				else
					begin
						BufferEnable <= 0;
						BufferSumMagnituder <= 0;
						BufferSumDelayCorrelation <= 0;
					end
			end
	end

reg TempDetection;
reg [31:0] BufferForDetection;

/*分组结束的寻�?******//////
reg frame_end_search;
reg [47:0] frame_end_buffer;

always@(posedge Clk or negedge Rst_n)
	begin
   	if (!Rst_n)	/*全局复位******//////
	 		begin
	    		TempDetection <=0;
		 		frame_end_search <=0;
	 		end
   	else
      	begin
	    		if (BufferEnable)
	       		begin
		     		if ((BufferSumMagnituder>>10) < BufferSumDelayCorrelation)
							begin
			   	 			TempDetection <= 1;
							end
            		else
							begin
			   	 			TempDetection <= 0;
							end

			
					if (BufferSumMagnituder < 21'b0000111_0000_0000_0001)
							begin
								frame_end_search <= 1;
							end
					else
							begin
								frame_end_search <= 0;
							end
					end
			end
	end

always@(posedge Clk or negedge Rst_n)
	begin
		if(!Rst_n)
			begin
				BufferForDetection <= 32'b00000000_00000000_00000000_00000000;
 	    
				frame_end_buffer <= 48'b00000000_00000000_00000000_00000000_00000000_00000000;
			end
		else
			begin
				BufferForDetection[31] <= BufferForDetection[30];
				BufferForDetection[30] <= BufferForDetection[29];
			
				BufferForDetection[29] <= BufferForDetection[28];
				BufferForDetection[28] <= BufferForDetection[27];
				BufferForDetection[27] <= BufferForDetection[26];
				BufferForDetection[26] <= BufferForDetection[25];
				BufferForDetection[25] <= BufferForDetection[24];
				BufferForDetection[24] <= BufferForDetection[23];
				BufferForDetection[23] <= BufferForDetection[22];
				BufferForDetection[22] <= BufferForDetection[21];
         		BufferForDetection[21] <= BufferForDetection[20];
				BufferForDetection[20] <= BufferForDetection[19];
			
				BufferForDetection[19] <= BufferForDetection[18];
				BufferForDetection[18] <= BufferForDetection[17];
				BufferForDetection[17] <= BufferForDetection[16];
				BufferForDetection[16] <= BufferForDetection[15];
				BufferForDetection[15] <= BufferForDetection[14];
				BufferForDetection[14] <= BufferForDetection[13];
				BufferForDetection[13] <= BufferForDetection[12];
				BufferForDetection[12] <= BufferForDetection[11];
         		BufferForDetection[11] <= BufferForDetection[10];
				BufferForDetection[10] <= BufferForDetection[9];
			
				BufferForDetection[9] <= BufferForDetection[8];
				BufferForDetection[8] <= BufferForDetection[7];
				BufferForDetection[7] <= BufferForDetection[6];
				BufferForDetection[6] <= BufferForDetection[5];
				BufferForDetection[5] <= BufferForDetection[4];
				BufferForDetection[4] <= BufferForDetection[3];
				BufferForDetection[3] <= BufferForDetection[2];
				BufferForDetection[2] <= BufferForDetection[1];
         		BufferForDetection[1] <= BufferForDetection[0];
				BufferForDetection[0] <= TempDetection;


				/*分组结束位置的寻�?******//////

				frame_end_buffer[47] <= frame_end_buffer[46];
				frame_end_buffer[46] <= frame_end_buffer[45];
				frame_end_buffer[45] <= frame_end_buffer[44];
				frame_end_buffer[44] <= frame_end_buffer[43];
				frame_end_buffer[43] <= frame_end_buffer[42];
				frame_end_buffer[42] <= frame_end_buffer[41];
				frame_end_buffer[41] <= frame_end_buffer[40];
				frame_end_buffer[40] <= frame_end_buffer[39];
			
				frame_end_buffer[39] <= frame_end_buffer[38];
				frame_end_buffer[38] <= frame_end_buffer[37];
				frame_end_buffer[37] <= frame_end_buffer[36];
				frame_end_buffer[36] <= frame_end_buffer[35];
				frame_end_buffer[35] <= frame_end_buffer[34];
				frame_end_buffer[34] <= frame_end_buffer[33];
				frame_end_buffer[33] <= frame_end_buffer[32];
				frame_end_buffer[32] <= frame_end_buffer[31];
				frame_end_buffer[31] <= frame_end_buffer[30];
				frame_end_buffer[30] <= frame_end_buffer[29];
			
				frame_end_buffer[29] <= frame_end_buffer[28];
				frame_end_buffer[28] <= frame_end_buffer[27];
				frame_end_buffer[27] <= frame_end_buffer[26];
				frame_end_buffer[26] <= frame_end_buffer[25];
				frame_end_buffer[25] <= frame_end_buffer[24];
				frame_end_buffer[24] <= frame_end_buffer[23];
				frame_end_buffer[23] <= frame_end_buffer[22];
				frame_end_buffer[22] <= frame_end_buffer[21];
         	frame_end_buffer[21] <= frame_end_buffer[20];
				frame_end_buffer[20] <= frame_end_buffer[19];
			
				frame_end_buffer[19] <= frame_end_buffer[18];
				frame_end_buffer[18] <= frame_end_buffer[17];
				frame_end_buffer[17] <= frame_end_buffer[16];
				frame_end_buffer[16] <= frame_end_buffer[15];
				frame_end_buffer[15] <= frame_end_buffer[14];
				frame_end_buffer[14] <= frame_end_buffer[13];
				frame_end_buffer[13] <= frame_end_buffer[12];
				frame_end_buffer[12] <= frame_end_buffer[11];
         	frame_end_buffer[11] <= frame_end_buffer[10];
				frame_end_buffer[10] <= frame_end_buffer[9];
			
				frame_end_buffer[9] <= frame_end_buffer[8];
				frame_end_buffer[8] <= frame_end_buffer[7];
				frame_end_buffer[7] <= frame_end_buffer[6];
				frame_end_buffer[6] <= frame_end_buffer[5];
				frame_end_buffer[5] <= frame_end_buffer[4];
				frame_end_buffer[4] <= frame_end_buffer[3];
				frame_end_buffer[3] <= frame_end_buffer[2];
				frame_end_buffer[2] <= frame_end_buffer[1];
         		frame_end_buffer[1] <= frame_end_buffer[0];
				frame_end_buffer[0] <= frame_end_search;
			end
	end


			
always@(posedge Clk or negedge Rst_n)
begin
	if(!Rst_n)
		begin
			FrameFind<=0;
		end
	else
		begin
			if (BufferEnable) /*两路信号同时有效******//////
				begin
					if (BufferForDetection == 32'b11111111_11111111_11111111_11111111)
						begin
							FrameFind <= 1;
						end
					else 	if ( frame_end_buffer == 48'b11111111_11111111__11111111_11111111_11111111_11111111)
						begin
							FrameFind <= 0;
						end
				end
         else /*两路信号没有同时有效******//////
	       begin
				FrameFind <= 0;
			 end
		end
end

endmodule


