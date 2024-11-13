/****************************************************************/
/*在Energy_Computing送出的OutputEnable有效下                   ******//////
/*计算Sum16Magnituder = Sum16Magnituder + MagnituderBuffer[0]  ******//////
/*                            - MagnituderBuffer[16]           ******//////
/*输入有效InputEnable由Magnituder8送出                         ******//////
/*输入数据幅度平方DataInMagnituder                             ******//////
/*输入数据17位位宽  1位符号位 4位整数位 12位小数位             ******//////
 
/*Sum16Magnituder 	输入数据幅度平方的16个累加                ******//////
/*输出数据Sum16Magnituder                                      ******//////
/*输出数据21位位宽  1位符号位 8位整数位 12位小数位             ******//////


/*用移位寄存器代替数据缓存                                     ******//////
    
/****************************************************************/
module Energy_Accumulation(Clk, Rst_n,
                                 InputEnable, DataInMagnituder,
						               OutputEnable, Sum16Magnituder);
input Clk;
input Rst_n;

/*由Magnituder8送出的输入数据有效******//////
input InputEnable;
/*输入数据 数据幅度平方 17位位宽  1位符号位 4位整数位 12位小数位******//////
input [16:0] DataInMagnituder;

/*输出数据 数据幅度平方的16个累加有效******//////
output OutputEnable;
/*输出数据 数据幅度平方的16个累加  20位位宽  1位符号位 8位整数位 12位小数位******//////
output [20:0] Sum16Magnituder;

reg OutputEnable;
reg [20:0] Sum16Magnituder;

/******************************************************************************************/
/**************************把输入数据有效和数据进行缓存************************************/
reg BufferInputEnable;
reg [16:0] BufferMagnituder;

always@(posedge Clk or negedge Rst_n)
	begin
   	if (!Rst_n)
      	begin
	    		BufferInputEnable <= 0;
	    		BufferMagnituder <= 17'b0;
	 		end
   	else
      	begin
	    		if (InputEnable)
	       		begin
		  				BufferInputEnable <= 1;
						BufferMagnituder <= DataInMagnituder;
		  			end
	    		else
	       		begin
	          		BufferInputEnable <= 0;
	          		BufferMagnituder <= 17'b00000000_00000000;	  		  
		  			end
	 		end
	end
/******************************************************************************************/
wire [16:0]ShiftMagnituder;

shiftramlength16width17 ShiftRamLength16width16_DataRe (
    .CLK(Clk),
    .D(BufferMagnituder),
    .Q(ShiftMagnituder),
    .CE(BufferInputEnable));

/****************************把移位寄存器的输出缓存****************************************/
/*Compute Sum16Magnituder = Sum16Magnituder + MagnituderBuffer[0] ******//////
/*                            - MagnituderBuffer[16]          ******//////   
reg TempEnable;
reg [17:0]TempMagnituder;
//compute MagnituderBuffer[0]-MagnituderBuffer[16]
always @(posedge Clk or negedge Rst_n)
	begin
		if(!Rst_n)
			begin
				TempEnable <= 0;
				TempMagnituder <= 0;
			end
		else
			begin
				if(BufferInputEnable)
					begin
						TempEnable <= 1;
						TempMagnituder <= {BufferMagnituder[16],BufferMagnituder} - {ShiftMagnituder[16],ShiftMagnituder};
					end
				else
					begin
						TempEnable <= 0;
						TempMagnituder <= 0;
					end
			end
	end

always@(posedge Clk or negedge Rst_n)
begin
   if (!Rst_n)
      begin
			OutputEnable <= 0;
			Sum16Magnituder <= 0;
		end
	else
		begin
			if(TempEnable)
				begin
					OutputEnable <= 1;
					Sum16Magnituder <= Sum16Magnituder + {{3{TempMagnituder[17]}},TempMagnituder};
				end
			else
				begin
					OutputEnable <= 0;
					Sum16Magnituder <= 0;
				end
		end
end

/******************************************************************************************/


endmodule

