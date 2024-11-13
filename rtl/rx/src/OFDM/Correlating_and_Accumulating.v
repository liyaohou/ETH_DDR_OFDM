module Correlating_and_Accumulating(Clk,Rst_n,
                      QuanEnable,QuanDataR,QuanDataI,
							 CorrelationSumR,CorrelationSumI,CorrelationEnable);

input Clk;
input Rst_n;
input QuanEnable;
input [15:0]QuanDataR;
input [15:0]QuanDataI;

//the enable signal of the sum
output CorrelationEnable;
reg CorrelationEnable;

//the sum of correlation
output [20:0]CorrelationSumR;
output [20:0]CorrelationSumI;
reg [20:0]CorrelationSumR;
reg [20:0]CorrelationSumI;


/************************本地已知短训练序列************************/
	 /*16位二进制补码表示（1位符号位 + 1位整数位 + 14位小数位   ******///////
	 parameter sts_R0 = 16'b0000_0010_1111_0001;
	 parameter sts_R1 = 16'b1111_0111_1000_1110; 
	 parameter sts_R2 = 16'b1111_1111_0010_1100; 
	 parameter sts_R3 = 16'b0000_1001_0010_0110; 
	 parameter sts_R4 = 16'b0000_0101_1110_0011; 
	 parameter sts_R5 = 16'b0000_1001_0010_0110; 
	 parameter sts_R6 = 16'b1111_1111_0010_1100; 
	 parameter sts_R7 = 16'b1111_0111_1000_1110; 
	 parameter sts_R8 = 16'b0000_0010_1111_0001; 
	 parameter sts_R9 = 16'b0000_0000_0010_0000; 
	 parameter sts_R10 = 16'b1111_1010_1111_0010; 
	 parameter sts_R11 = 16'b1111_1111_0010_1100; 
	 parameter sts_R12 = 16'b0;
	 parameter sts_R13 = 16'b1111_1111_0010_1100;	 
	 parameter sts_R14 = 16'b1111_1010_1111_0010;  
	 parameter sts_R15 = 16'b0000_0000_0010_0000;

	 parameter sts_I0 = 16'b0000_0010_1111_0001;
	 parameter sts_I1 = 16'b0000_0000_0010_0000;
	 parameter sts_I2 = 16'b1111_1010_1111_0010;		
	 parameter sts_I3 = 16'b1111_1111_0010_1100;		 
	 parameter sts_I4 = 16'b0;
	 parameter sts_I5 = 16'b1111_1111_0010_1100;		 
	 parameter sts_I6 = 16'b1111_1010_1111_0010;		 
	 parameter sts_I7 = 16'b0000_0000_0010_0000;		 
	 parameter sts_I8 = 16'b0000_0010_1111_0001;		 
	 parameter sts_I9 = 16'b1111_0111_1000_1110;		 
	 parameter sts_I10 = 16'b1111_1111_0010_1100;		 
	 parameter sts_I11 = 16'b0000_1001_0010_0110;		 
	 parameter sts_I12 = 16'b0000_0101_1110_0011;		 
	 parameter sts_I13 = 16'b0000_1001_0010_0110;		 
	 parameter sts_I14 = 16'b1111_1111_0010_1100;		 
	 parameter sts_I15 = 16'b1111_0111_1000_1110;
    /************************本地已知短训练序列************************/
	 

//the enable signal Buffer
reg BufferEnable;
//the input datas buffer
reg [15:0]BufferDataR;
reg [15:0]BufferDataI;

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
				if(QuanEnable)
					begin
						BufferEnable <= 1;
						BufferDataR <= QuanDataR;
						BufferDataI <= QuanDataI;
					end
				else
					begin
						BufferEnable <= 0;
						BufferDataR <= 0;
						BufferDataI <= 0;
					end
			end
	end

reg [4:0]Counter;
reg TempEnable;
always @(posedge Clk or negedge Rst_n)
	begin
		if(!Rst_n)
			begin
				Counter <= 0;
				TempEnable <= 0;
			end
		else
			begin
				if(BufferEnable)
					begin
						if(Counter < 15)  //when the counter is 16, the enable of correlation is set high, beacuse the lenght of the STS is 16 
							Counter <= Counter + 1;
						else
							TempEnable <= 1;
					end
				else
					begin
						Counter <= 0;
						TempEnable <= 0;
					end
			end
	end

//the simple correlation results
wire [16:0] CorrelationR0,CorrelationR1,CorrelationR2,CorrelationR3,
	         CorrelationR4,CorrelationR5,CorrelationR6,CorrelationR7,
	         CorrelationR8,CorrelationR9,CorrelationR10,CorrelationR11,
			   CorrelationR12,CorrelationR13,CorrelationR14,CorrelationR15;

wire [16:0] CorrelationI0,CorrelationI1,CorrelationI2,CorrelationI3,
	         CorrelationI4,CorrelationI5,CorrelationI6,CorrelationI7,
	         CorrelationI8,CorrelationI9,CorrelationI10,CorrelationI11,
				CorrelationI12,CorrelationI13,CorrelationI14,CorrelationI15;
//the enable signal of the simple correlation results
wire CorrelationEn0,CorrelationEn1,CorrelationEn2,CorrelationEn3,
     CorrelationEn4,CorrelationEn5,CorrelationEn6,CorrelationEn7,
	  CorrelationEn8,CorrelationEn9,CorrelationEn10,CorrelationEn11,
	  CorrelationEn12,CorrelationEn13,CorrelationEn14,CorrelationEn15;

// Simple Correlation Module
Simple_Correlation Simple_Correlation0 (
    .Clk(Clk), 
    .Rst_n(Rst_n), 
    .inEn(BufferEnable), 
    .multiplier_Real(BufferDataR[0]), 
    .multiplier_Imag(BufferDataI[0]), 
    .known_Real(sts_R0), 
    .known_Imag(sts_I0), 
    .output_Real(CorrelationR0), 
    .output_Imag(CorrelationI0), 
    .OutputEnable(CorrelationEn0)
    );
	 
// Simple Correlation Module
Simple_Correlation Simple_Correlation1 (
    .Clk(Clk), 
    .Rst_n(Rst_n), 
    .inEn(BufferEnable), 
    .multiplier_Real(BufferDataR[1]), 
    .multiplier_Imag(BufferDataI[1]), 
    .known_Real(sts_R1), 
    .known_Imag(sts_I1), 
    .output_Real(CorrelationR1), 
    .output_Imag(CorrelationI1), 
    .OutputEnable(CorrelationEn1)
    );

Simple_Correlation Simple_Correlation2 (
    .Clk(Clk), 
    .Rst_n(Rst_n), 
    .inEn(BufferEnable), 
    .multiplier_Real(BufferDataR[2]), 
    .multiplier_Imag(BufferDataI[2]), 
    .known_Real(sts_R2), 
    .known_Imag(sts_I2), 
    .output_Real(CorrelationR2), 
    .output_Imag(CorrelationI2), 
    .OutputEnable(CorrelationEn2)
    );

Simple_Correlation Simple_Correlation3 (
    .Clk(Clk), 
    .Rst_n(Rst_n), 
    .inEn(BufferEnable), 
    .multiplier_Real(BufferDataR[3]), 
    .multiplier_Imag(BufferDataI[3]), 
    .known_Real(sts_R3), 
    .known_Imag(sts_I3), 
    .output_Real(CorrelationR3), 
    .output_Imag(CorrelationI3), 
    .OutputEnable(CorrelationEn3)
    );

Simple_Correlation Simple_Correlation4 (
    .Clk(Clk), 
    .Rst_n(Rst_n), 
    .inEn(BufferEnable), 
    .multiplier_Real(BufferDataR[4]), 
    .multiplier_Imag(BufferDataI[4]), 
    .known_Real(sts_R4), 
    .known_Imag(sts_I4), 
    .output_Real(CorrelationR4), 
    .output_Imag(CorrelationI4), 
    .OutputEnable(CorrelationEn4)
    );

Simple_Correlation Simple_Correlation (
    .Clk(Clk), 
    .Rst_n(Rst_n), 
    .inEn(BufferEnable), 
    .multiplier_Real(BufferDataR[5]), 
    .multiplier_Imag(BufferDataI[5]), 
    .known_Real(sts_R5), 
    .known_Imag(sts_I5), 
    .output_Real(CorrelationR5), 
    .output_Imag(CorrelationI5), 
    .OutputEnable(CorrelationEn5)
    );

Simple_Correlation Simple_Correlation6 (
    .Clk(Clk), 
    .Rst_n(Rst_n), 
    .inEn(BufferEnable), 
    .multiplier_Real(BufferDataR[6]), 
    .multiplier_Imag(BufferDataI[6]), 
    .known_Real(sts_R6), 
    .known_Imag(sts_I6), 
    .output_Real(CorrelationR6), 
    .output_Imag(CorrelationI6), 
    .OutputEnable(CorrelationEn6)
    );

Simple_Correlation Simple_Correlation7 (
    .Clk(Clk), 
    .Rst_n(Rst_n), 
    .inEn(BufferEnable), 
    .multiplier_Real(BufferDataR[7]), 
    .multiplier_Imag(BufferDataI[7]), 
    .known_Real(sts_R7), 
    .known_Imag(sts_I7), 
    .output_Real(CorrelationR7), 
    .output_Imag(CorrelationI7), 
    .OutputEnable(CorrelationEn7)
    );

Simple_Correlation Simple_Correlation8 (
    .Clk(Clk), 
    .Rst_n(Rst_n), 
    .inEn(BufferEnable), 
    .multiplier_Real(BufferDataR[8]), 
    .multiplier_Imag(BufferDataI[8]), 
    .known_Real(sts_R8), 
    .known_Imag(sts_I8), 
    .output_Real(CorrelationR8), 
    .output_Imag(CorrelationI8), 
    .OutputEnable(CorrelationEn8)
    );

Simple_Correlation Simple_Correlation9 (
    .Clk(Clk), 
    .Rst_n(Rst_n), 
    .inEn(BufferEnable), 
    .multiplier_Real(BufferDataR[9]), 
    .multiplier_Imag(BufferDataI[9]), 
    .known_Real(sts_R9), 
    .known_Imag(sts_I9), 
    .output_Real(CorrelationR9), 
    .output_Imag(CorrelationI9), 
    .OutputEnable(CorrelationEn9)
    );

Simple_Correlation Simple_Correlation10 (
    .Clk(Clk), 
    .Rst_n(Rst_n), 
    .inEn(BufferEnable), 
    .multiplier_Real(BufferDataR[10]), 
    .multiplier_Imag(BufferDataI[10]), 
    .known_Real(sts_R10), 
    .known_Imag(sts_I10), 
    .output_Real(CorrelationR10), 
    .output_Imag(CorrelationI10), 
    .OutputEnable(CorrelationEn10)
    );

Simple_Correlation Simple_Correlation11 (
    .Clk(Clk), 
    .Rst_n(Rst_n), 
    .inEn(BufferEnable), 
    .multiplier_Real(BufferDataR[11]), 
    .multiplier_Imag(BufferDataI[11]), 
    .known_Real(sts_R11), 
    .known_Imag(sts_I11), 
    .output_Real(CorrelationR11), 
    .output_Imag(CorrelationI11), 
    .OutputEnable(CorrelationEn11)
    );

Simple_Correlation Simple_Correlation12 (
    .Clk(Clk), 
    .Rst_n(Rst_n), 
    .inEn(BufferEnable), 
    .multiplier_Real(BufferDataR[12]), 
    .multiplier_Imag(BufferDataI[12]), 
    .known_Real(sts_R12), 
    .known_Imag(sts_I12), 
    .output_Real(CorrelationR12), 
    .output_Imag(CorrelationI12), 
    .OutputEnable(CorrelationEn12)
    );

Simple_Correlation Simple_Correlation13 (
    .Clk(Clk), 
    .Rst_n(Rst_n), 
    .inEn(BufferEnable), 
    .multiplier_Real(BufferDataR[13]), 
    .multiplier_Imag(BufferDataI[13]), 
    .known_Real(sts_R13), 
    .known_Imag(sts_I13), 
    .output_Real(CorrelationR13), 
    .output_Imag(CorrelationI13), 
    .OutputEnable(CorrelationEn13)
    );

Simple_Correlation Simple_Correlation14 (
    .Clk(Clk), 
    .Rst_n(Rst_n), 
    .inEn(BufferEnable), 
    .multiplier_Real(BufferDataR[14]), 
    .multiplier_Imag(BufferDataI[14]), 
    .known_Real(sts_R14), 
    .known_Imag(sts_I14), 
    .output_Real(CorrelationR14), 
    .output_Imag(CorrelationI14), 
    .OutputEnable(CorrelationEn14)
    );

Simple_Correlation Simple_Correlation15 (
    .Clk(Clk), 
    .Rst_n(Rst_n), 
    .inEn(BufferEnable), 
    .multiplier_Real(BufferDataR[15]), 
    .multiplier_Imag(BufferDataI[15]), 
    .known_Real(sts_R15), 
    .known_Imag(sts_I15), 
    .output_Real(CorrelationR15), 
    .output_Imag(CorrelationI15), 
    .OutputEnable(CorrelationEn15)
    );

always @(posedge Clk or negedge Rst_n)
	begin
		if(!Rst_n)
			begin
				CorrelationEnable <= 0;
				CorrelationSumR <= 0;
				CorrelationSumI <= 0;
			end
		else
			begin
				if(TempEnable&CorrelationEn0&CorrelationEn1&CorrelationEn2&CorrelationEn3&CorrelationEn4&CorrelationEn5
				   &CorrelationEn6&CorrelationEn7&CorrelationEn8&CorrelationEn9&CorrelationEn10&CorrelationEn11
					&CorrelationEn12&CorrelationEn13&CorrelationEn14&CorrelationEn15)
					begin
						/*赋值语句右边的操作数位宽已扩展为21位，跟左边的结果位宽一致，保证带符号位二进制加法运算的正确性*******//////
						CorrelationSumR <= ((({{4{CorrelationR0[16]}},CorrelationR0} + {{4{CorrelationR1[16]}},CorrelationR1}) 
						                   + ({{4{CorrelationR2[16]}},CorrelationR2} + {{4{CorrelationR3[16]}},CorrelationR3})) 
						                   + (({{4{CorrelationR4[16]}},CorrelationR4} + {{4{CorrelationR5[16]}},CorrelationR5})
												 + ({{4{CorrelationR6[16]}},CorrelationR6} + {{4{CorrelationR7[16]}},CorrelationR7}))) 
												 + ((({{4{CorrelationR8[16]}},CorrelationR8} + {{4{CorrelationR9[16]}},CorrelationR9})
												 + ({{4{CorrelationR10[16]}},CorrelationR10} + {{4{CorrelationR11[16]}},CorrelationR11})) 
												 + (({{4{CorrelationR12[16]}},CorrelationR12} + {{4{CorrelationR13[16]}},CorrelationR13})
												 + ({{4{CorrelationR14[16]}},CorrelationR14} + {{4{CorrelationR15[16]}},CorrelationR15})));
	   			   CorrelationSumI <= ((({{4{CorrelationI0[16]}},CorrelationI0} + {{4{CorrelationI1[16]}},CorrelationI1}) 
						                   + ({{4{CorrelationI2[16]}},CorrelationI2} + {{4{CorrelationI3[16]}},CorrelationI3})) 
						                   + (({{4{CorrelationI4[16]}},CorrelationI4} + {{4{CorrelationI5[16]}},CorrelationI5})
												 + ({{4{CorrelationI6[16]}},CorrelationI6} + {{4{CorrelationI7[16]}},CorrelationI7}))) 
												 + ((({{4{CorrelationI8[16]}},CorrelationI8} + {{4{CorrelationI9[16]}},CorrelationI9})
												 + ({{4{CorrelationI10[16]}},CorrelationI10} + {{4{CorrelationI11[16]}},CorrelationI11})) 
												 + (({{4{CorrelationI12[16]}},CorrelationI12} + {{4{CorrelationI13[16]}},CorrelationI13})
												 + ({{4{CorrelationI14[16]}},CorrelationI14} + {{4{CorrelationI15[16]}},CorrelationI15})));
						CorrelationEnable <= 1;
					end
				else
					begin
						CorrelationEnable <= 0;
						CorrelationSumR <= 0;
						CorrelationSumI <= 0;
					end
			end
	end

endmodule

