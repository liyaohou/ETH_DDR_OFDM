/****************************************************/
/*计算 A*conj(B)******//////
//Zr+Zi*j=(Ar+Ai*j)*(Br+Bi*j)
//=>Zr=ArBr-AiBi=Ar*(Br+Bi)-Bi*(Ar+Ai)
//  Zi=ArBi+AiBr=Ar*(Br+Bi)-Br*(Ar-Ai)
/*InputEnable由DataBufferForDetection64模块送入的输入数据有效******//////
/*输入数据DataInARe, DataInAIm, DataInBRe, DataInBIm******//////
/*数据输入 8位位宽 1位符号位 1位整数位 6位小数位 ******//////

/*OutputEnable输出数据有效******//////
/*数据输DataCorrelationOutRe, DataCorrelationOutIm******//////
/*数据输出 16位位宽 1位符号位 3位整数位 12位小数位******//////
/****************************************************/
module Delay_Correlation_Computing(Clk,Rst_n, 
                             		InputEnable,
									DataInARe,DataInAIm,
									DataInBRe,DataInBIm, 
					                OutputEnable,
									DataOutRe,DataOutIm);

input Clk;
input Rst_n;

/*由Data Buffer模块送出的输入数据有效******//////
input InputEnable;
/*数据输入 8位位宽 1位符号位 1位整数位 6位小数位 ******//////
input [7:0] DataInARe;
input [7:0] DataInAIm;
input [7:0] DataInBRe;
input [7:0] DataInBIm;

/*由本模块送出的输出数据有效******//////
output OutputEnable;
/*数据输出 16位位宽 1位符号位 3位整数位 12位小数位******//////
output [15:0] DataOutRe;
output [15:0] DataOutIm; 

reg OutputEnable;
reg [15:0] DataOutRe;
reg [15:0] DataOutIm;

//the input datas buffer
reg [7:0] BufferDataARe;
reg [7:0] BufferDataAIm;
reg [7:0] BufferDataBRe;
reg [7:0] BufferDataBIm;
//the enable singal buffer
reg BufferEnable;

//输入缓冲
always @(posedge Clk or negedge Rst_n)
	begin
		if(!Rst_n)
			begin
				BufferEnable <= 0;
				BufferDataARe <= 0;
				BufferDataAIm <= 0;
				BufferDataBRe <= 0;
				BufferDataBIm <= 0;
			end
		else
			begin
				if(InputEnable)
					begin
						BufferEnable <= 1;
						BufferDataARe <= DataInARe;
						BufferDataAIm <= DataInAIm;
						BufferDataBRe <= DataInBRe;
						BufferDataBIm <= DataInBIm;
					end
				else
					begin
						BufferEnable <= 0;
						BufferDataARe <= 0;
						BufferDataAIm <= 0;
						BufferDataBRe <= 0;
						BufferDataBIm <= 0;
					end
			end
	end

//
reg [8:0] TempSumA;
reg [8:0] TempDifferenceA;
reg [8:0] TempSumB;
reg [7:0] TempARe;
reg [7:0] TempBRe;
reg [7:0] TempBIm;
reg Temp_En;
//compute Ar+Ai,Ar-Ai, and Br+Bi
always @(posedge Clk or negedge Rst_n)
	begin
		if(!Rst_n)
			begin
				Temp_En <= 0;
				TempSumA <= 0;
				TempDifferenceA <= 0;
				TempSumB <= 0;
				TempARe <= 0;
				TempBRe <= 0;
				TempBIm <= 0;
			end
		else
			begin
				if(BufferEnable)
					begin
						Temp_En <= 1;
						TempSumA <= {BufferDataARe[7],BufferDataARe} + {BufferDataAIm[7],BufferDataAIm};
						TempDifferenceA <= {BufferDataARe[7],BufferDataARe} - {BufferDataAIm[7],BufferDataAIm};
						TempSumB <= {BufferDataBRe[7],BufferDataBRe} + {BufferDataBIm[7],BufferDataBIm};
						TempARe <= BufferDataARe;
						TempBRe <= BufferDataBRe;
						TempBIm <= BufferDataBIm;
					end
				else
					begin
						Temp_En <= 0;
						TempSumA <= 0;
						TempDifferenceA <= 0;
						TempSumB <= 0;
						TempARe <= 0;
						TempBRe <= 0;
						TempBIm <= 0;
					end
			end
	end

wire [16:0] SumA_mult_Bi;
wire [16:0] DifferenceA_mult_Br;
wire [16:0] SumB_mult_Ar;

//compute Bi*(Ar+Ai)
width9_multiply_width8 SumAmultiplyBi (
  .CLK(Clk),  // input wire CLK
  .A(TempSumA),      // input wire [8 : 0] A
  .B(TempBIm),      // input wire [7 : 0] B
  .CE(Temp_En),    // input wire CE
  .P(SumA_mult_Bi)      // output wire [16 : 0] P
);	 
//compute Ar*(Br+Bi)
width9_multiply_width8 SumBmultiplyAr (
  .CLK(Clk),  // input wire CLK
  .A(TempSumB),      // input wire [8 : 0] A
  .B(TempARe),      // input wire [7 : 0] B
  .CE(Temp_En),    // input wire CE
  .P(SumB_mult_Ar)      // output wire [16 : 0] P
);
//compute Br*(Ar-Ai)
width9_multiply_width8 DifferenceAmultiplyBr (
  .CLK(Clk),  // input wire CLK
  .A(TempDifferenceA),      // input wire [8 : 0] A
  .B(TempBRe),      // input wire [7 : 0] B
  .CE(Temp_En),    // input wire CE
  .P(DifferenceA_mult_Br)      // output wire [16 : 0] P
);
reg [17:0] TempRe;
reg [17:0] TempIm;
reg TempEnable;

//compute Ar*(Br+Bi)- Br*(Ar-Ai) and Bi*(Ar+Ai) - Ar*(Br+Bi)
always @(posedge Clk or negedge Rst_n)
	begin
		if(!Rst_n)
			begin
				TempEnable <= 1'b0;
				TempRe <= 0;
				TempIm <= 0;
			end
		else
			begin
				if(Temp_En)
					begin
						TempRe <= {SumB_mult_Ar[16],SumB_mult_Ar} - {SumA_mult_Bi[16],SumA_mult_Bi};
						TempIm <= {DifferenceA_mult_Br[16],DifferenceA_mult_Br} - {SumB_mult_Ar[16],SumB_mult_Ar};
						TempEnable <= 1'b1;
					end
				else
					begin
						TempRe <= 0;
						TempIm <= 0;
						TempEnable <= 1'b0;
					end
			end
	end
				
always @(posedge Clk or negedge Rst_n)
	begin
		if(!Rst_n)
			begin
				OutputEnable <= 0;
				DataOutRe <= 0;
				DataOutIm <= 0;
			end
		else
			begin
				if(TempEnable)
					begin
						OutputEnable <= 1;
						DataOutRe <= {TempRe[17],TempRe[14:0]};
						DataOutIm <= {TempIm[17],TempIm[14:0]};
					end
				else
					begin
						OutputEnable <= 0;
						DataOutRe <= 0;
						DataOutIm <= 0;
					end
			end
	end
						

endmodule

