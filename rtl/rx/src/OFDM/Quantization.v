module Quantization(
    Clk,Rst_n,   
    inEn,
    bitInR,bitInI,
    
    QuantizationEnable,
    Quantization_Result_Real,Quantization_Result_Imag
);

input Clk;
input Rst_n;
//the enable signal of the input datas
input inEn;
input [7:0]bitInR;
input [7:0]bitInI;

//the enable signal of the Quantization results 
output  reg QuantizationEnable;
output reg [15:0]Quantization_Result_Real;
output reg [15:0]Quantization_Result_Imag;

//the enable signal buffer
reg BufferEnable;
reg [7:0]BufferDataR;
reg [7:0]BufferDataI;

always @(posedge Clk or negedge Rst_n)
	begin
		if(!Rst_n)
			begin
				BufferEnable <= 0;
				BufferDataR <= 0;
				BufferDataI <= 0;
			end
		else
			begin
				if(inEn)
					begin
						BufferEnable <= 1;
						BufferDataR <= bitInR;
						BufferDataI <= bitInI;
					end
				else
					begin
						BufferEnable <= 0;
						BufferDataR <= 0;
						BufferDataI <= 0;
					end
			end
	end

/*持续累加用寄存器 *//////
reg [191:0] Continual_Accumulation_Real;		  
reg [191:0] Continual_Accumulation_Imag;
/*持续累加有效信号 *//////
reg AddEnable;	
//********************************取得量化结果********************************//
always @ (posedge Clk or negedge Rst_n)
	begin
   	if (!Rst_n)
			begin
				Continual_Accumulation_Real <= 0;	
				Continual_Accumulation_Imag <= 0;
				AddEnable <= 0;
			end
		else
			begin
				if(BufferEnable)
					begin
						/*持续累加移位寄存器左移一个单元 12 *****//////
						Continual_Accumulation_Real[191:12] <= Continual_Accumulation_Real[179:0];	  
						Continual_Accumulation_Imag[191:12] <= Continual_Accumulation_Imag[179:0];
						/*最高一个单元与输入数据的12位扩展相加赋值给最低一个单元****//////
						Continual_Accumulation_Real[11:0] <= {{4{BufferDataR[7]}},BufferDataR} + Continual_Accumulation_Real[191:180]; 
						Continual_Accumulation_Imag[11:0] <= {{4{BufferDataI[7]}},BufferDataI} + Continual_Accumulation_Imag[191:180];
						AddEnable <= 1;
					end
				else
					begin
						Continual_Accumulation_Real <= 0;
						Continual_Accumulation_Imag <= 0;
						AddEnable <= 0;
					end
			end
	end

always @(posedge Clk or negedge Rst_n)
	begin
		if(!Rst_n)
			begin
				Quantization_Result_Real <= 0;
				Quantization_Result_Imag <= 0;	
				QuantizationEnable <= 0;
			end
		else
			begin
				if(AddEnable)
					begin
						QuantizationEnable <= 1;
						/*量化结果移位******//////
						Quantization_Result_Real[14:0] <= Quantization_Result_Real[15:1];			
						Quantization_Result_Imag[14:0] <= Quantization_Result_Imag[15:1];
						/*最高位为0，表正，量化为+1, 在此用0代替，下面语句只是用于判断******//////
						Quantization_Result_Real[15] <= Continual_Accumulation_Real[11];
						/*最高位为1，表负，量化为-1，在此用1表示******//////
						Quantization_Result_Imag[15] <= Continual_Accumulation_Imag[11];	 
					end
				else
					begin
						Quantization_Result_Real <= 0;
						Quantization_Result_Imag <= 0;	
						QuantizationEnable <= 0;
					end
			end
	end

endmodule
