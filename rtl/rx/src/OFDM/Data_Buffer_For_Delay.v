/***********************************/
/*在Energy_Accumulation送出OutputEnable有效下                                              ******//////
/*将输入延时其应时钟(4个时钟周期)输出以保证相关窗口能量计算模块与延时相关计算模块的同步输出******//////


/*输入数据输入数据幅度平方的16个累加                                                       ******//////
/*Sum16Magnituder                                                                          ******//////
/*输出数据21位位宽  1位符号位 8位整数位 12位小数位                                         ******//////
/***********************************/
module Data_Buffer_For_Delay(Clk,Rst_n,
							        InputEnable, DataIn,
			                    OutputEnable, DataOut);
input Clk;
input Rst_n;
/*由SlideWindowForMagnituder8送出的输入数据有效******//////
input InputEnable;
/*输入数据 21位位宽  1位符号位 8位整数位 12位小数位******//////
input [20:0] DataIn;

output OutputEnable;
/*输出数据 21位位宽  1位符号位 8位整数位 12位小数位******//////
output [20:0] DataOut;

reg OutputEnable;
reg [20:0] DataOut;

reg BufferEnable1;
reg [20:0] BufferData1;

reg BufferEnable2;
reg [20:0] BufferData2;

reg BufferEnable3;
reg [20:0] BufferData3;

always @(posedge Clk or negedge Rst_n)
	begin
		if(!Rst_n)
			begin
				BufferEnable1 <= 0;
				BufferData1 <= 0;
				BufferEnable2 <= 0;
				BufferData2 <= 0;
				BufferEnable3 <= 0;
				BufferData3 <= 0;
				OutputEnable <= 0;
				DataOut <= 0;
			end
		else
			begin
				BufferEnable1 <= InputEnable;
				BufferData1 <= DataIn;
				BufferEnable2 <= BufferEnable1;
				BufferData2 <= BufferData1;
				BufferEnable3 <= BufferEnable2;
				BufferData3 <= BufferData2;
				OutputEnable <= BufferEnable3;
				DataOut <= BufferData3;
			end
	end

endmodule

