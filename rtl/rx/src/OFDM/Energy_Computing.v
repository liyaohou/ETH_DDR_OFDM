/****************************************************/
/*计算 A*conj(A)                                          ******//////

/*InputEnable由Data_Buffer_Shiftram模块送入的输入数据有效 ******//////
/*输入数据DataInARe, DataInAIm                            ******//////
/*数据输入 8位位宽 1位符号位 1位整数位 6位小数位          ******//////

/*OutputEnable输出数据有效                                ******//////
/*数据输DataMagnitude                                     ******//////
/*数据输出 17位位宽 1位符号位 4位整数位 12位小数位        ******//////
/****************************************************/
module Energy_Computing(Clk,Rst_n, 
                        InputEnable, DataInARe, DataInAIm,
			               OutputEnable, DataMagnitude);
input Clk;
input Rst_n;
/*由DataBufferForDetection64模块送出的输入数据有效******//////
input InputEnable;
/*数据输入 8位位宽 1位符号位 1位整数位 6位小数位******//////
input [7:0] DataInARe;
input [7:0] DataInAIm;

/*由本模块送出的输出数据有效******//////
output OutputEnable;
/*数据输出 16位位宽 1位符号位 3位整数位 12位小数位******//////
output [16:0] DataMagnitude;

reg OutputEnable;
reg [16:0] DataMagnitude;

reg BufferEnable;
reg [7:0]BufferDataRe;
reg [7:0]BufferDataIm;

always @(posedge Clk or negedge Rst_n)
	begin
		if(!Rst_n)
			begin
				BufferEnable <= 0;
				BufferDataRe <= 0;
				BufferDataIm <= 0;
			end
		else
			begin
				if(InputEnable)
					begin
						BufferEnable <= 1;
						BufferDataRe <= DataInARe;
						BufferDataIm <= DataInAIm;
					end
				else
					begin
						BufferEnable <= 0;
						BufferDataRe <= 0;
						BufferDataIm <= 0;
					end
			end
	end	
wire [15:0] TempSumA;
wire [15:0] TempSumB;
// wire rdy1;
// wire rdy2;

//width8_multiply_width8 multiplierRe (
//    .clk(Clk),
//    .a(BufferDataRe),
//    .b(BufferDataRe),
//    .q(TempSumA),
//    .nd(BufferEnable),
//    .rdy(rdy1));
    
width8_multiply_width8 multiplierRe (
  .CLK(Clk),  // input wire CLK
  .A(BufferDataRe),      // input wire [7 : 0] A
  .B(BufferDataRe),      // input wire [7 : 0] B
  .CE(BufferEnable),    // input wire CE
  .P(TempSumA)      // output wire [15 : 0] P
);
//width8_multiply_width8 multiplierIm (
//    .clk(Clk),
//    .a(BufferDataIm),
//    .b(BufferDataIm),
//    .q(TempSumB),
//    .nd(BufferEnable),
//    .rdy(rdy2));
width8_multiply_width8 multiplierIm (
  .CLK(Clk),  // input wire CLK
  .A(BufferDataIm),      // input wire [7 : 0] A
  .B(BufferDataIm),      // input wire [7 : 0] B
  .CE(BufferEnable),    // input wire CE
  .P(TempSumB)      // output wire [15 : 0] P
);
always @(posedge Clk or negedge Rst_n)
	begin
		if(!Rst_n)
			begin
				OutputEnable <= 0;
				DataMagnitude <= 0;
			end
		else
			begin
				if(BufferEnable)
					begin
						OutputEnable <= 1;
						DataMagnitude <= {TempSumA[15],TempSumA} + {TempSumB[15],TempSumB};
					end
				else
					begin
						OutputEnable <= 0;
						DataMagnitude <= 0;
					end
			end
	end

endmodule


