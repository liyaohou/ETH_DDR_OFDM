/********************************************************/
/*分组检测模块中的数据缓存子模块                   ******//////
/*用移位寄存器来代替                               ******//////
/*shiftramlength16: 16级移位寄存器,用于完成16级延迟******//////
/*shiftramlenght48: 48级移位寄存器,用于完成46级延迟******//////

/*shiftramlength16 在分组检测有效下                ******//////
/*送出2路用于分组检测的数据                        ******//////

/*shiftramlength48 在分组检测完成下                ******//////
/*送出分组检测完成后的输出数据                    ******//////
/********************************************************/
module Data_Buffer_Shiftram(Clk,Rst_n,
                            InputEnable,DataInRe,DataInIm,  
						          Buffer_Enable, DataARe, DataAIm, DataBRe, DataBIm,
									 FrameFinded,						  						 
						          OutputEnable, DataOutRe, DataOutIm);

input Clk;
input Rst_n; /*全局复位******////// 
input InputEnable;//由总体模块送入的输入数据有效******//////
/*输入数据有DataInRe DataInIm两部分******//////
/*输入数据8位位宽 1位符号位 1位整数位 6位小数位******//////
input [7:0] DataInRe, DataInIm; 

output Buffer_Enable;
/*数据送出到延时相关运算器 和 幅度平方运算器******//////
output [7:0] DataARe, DataAIm, DataBRe, DataBIm;
reg Buffer_Enable;
reg [7:0] DataARe, DataAIm, DataBRe, DataBIm;


input FrameFinded; /*总体模块发出的找到数据分组，输出数据有效******//////
/*本模块标志输出有效******//////
output OutputEnable; 
/*输出数据有DataOutRe DataOutIm两部分******//////
/*输出数据8位位宽 1位符号位 1位整数位 6位小数位******//////
output [7:0] DataOutRe, DataOutIm;
reg 	OutputEnable;
reg	[7:0] DataOutRe, DataOutIm;


/*************************************************************************************************/
/******************************分组检测数据有效和数据输入缓存*************************************/
/*输入数据有效的缓存******//////
reg TempInputEnable;
/*输入数据的缓存******//////
reg [7:0] TempDataInRe, TempDataInIm;
always@(posedge Clk or negedge Rst_n)
begin
	if (!Rst_n)
   	begin
	   	TempInputEnable <= 0;
	   	TempDataInRe <= 8'b00000000;
	   	TempDataInIm <= 8'b00000000;
		end
	else
		begin
			if (InputEnable)
				begin
		     	/*在输入数据有效下 把输入数据有效和数据缓存******//////
					TempInputEnable <= 1;
					TempDataInRe <= DataInRe;
					TempDataInIm <= DataInIm;
		  		end
	    	else
	       	begin
	         	TempInputEnable <= 0;
	         	TempDataInRe <= 8'b00000000;
	          	TempDataInIm <= 8'b00000000;		  		  
		  		end	 
	 	end
end
/*************************************************************************************************/


/*************************************************************************************************/
/***************************************移位寄存器模块********************************************/
/*16级移位寄存器的功能******//////
/*当前输入数据和其前面第16个输入数据成对输出******//////
wire [7:0] BufferDataRe;
wire [7:0] BufferDataIm;
shiftramlength16width8 DataRe_shiftramlength16 (
    .CLK(Clk),
    .D(TempDataInRe),
    .Q(BufferDataRe),
    .CE(TempInputEnable));

shiftramlength16width8 DataIm_shiftramlength16 (
    .CLK(Clk),
    .D(TempDataInIm),
    .Q(BufferDataIm),
    .CE(TempInputEnable));


/*//用经过缓存的分组检测有效信号******//////
always@(posedge Clk or negedge Rst_n)
begin
	if (!Rst_n)
   	begin
	   	Buffer_Enable <= 0;
	    	DataARe <= 8'b0;
	    	DataAIm <= 8'b0;
	    	DataBRe <= 8'b0;
	    	DataBIm <= 8'b0;
	 	end
	else
      begin
	   	if (TempInputEnable)	/*在分组检测有效下 ******//////
				begin
		  			Buffer_Enable <= 1;                  
				 	/*当前输入数据的缓存******//////
				 	DataARe <= TempDataInRe;
				 	DataAIm <= TempDataInIm;
				 	/*移位寄存器的输出******//////				 
				 	DataBRe <= BufferDataRe;
				 	DataBIm <= BufferDataIm;
			   end
			else
			   begin
	            Buffer_Enable <= 0;
	            DataARe <= 8'b00000000;
	            DataAIm <= 8'b00000000;
	            DataBRe <= 8'b00000000;
	            DataBIm <= 8'b00000000;			   
			   end
		end
end
/*************************************************************************************************/


/*************************************************************************************************/
/**********************把16级移位寄存器的输出继续送入48级移位寄存器中*****************************/
wire [7:0] ReceiveDataRe;
wire [7:0] ReceiveDataIm;

shiftramlength48width8 DataRe_shiftramlength48 (
    .CLK(Clk),
    .D(BufferDataRe),
    .Q(ReceiveDataRe),
    .CE(TempInputEnable));

shiftramlength48width8 DataIm_shiftramlength48 (
    .CLK(Clk),
    .D(BufferDataIm),
    .Q(ReceiveDataIm),
    .CE(TempInputEnable));
/*************************************************************************************************/

/*************************************************************************************************/
/*****************************在分组检测完成后 从移位寄存器中输出数据*****************************/
always@(posedge Clk or negedge Rst_n)
begin
   if (!Rst_n)
   	begin
	    	OutputEnable <= 0;
	    	DataOutRe <= 8'b00000000;
	    	DataOutIm <= 8'b00000000;
	 	end
   else
      begin
	    	if (FrameFinded) /*在分组检测完成下******//////？？？？？
	       	begin
					OutputEnable <= 1;
					DataOutRe <= ReceiveDataRe;
				 	DataOutIm <= ReceiveDataIm;
			   end
			else
			   begin
	            OutputEnable <= 0;
	            DataOutRe <= 8'b00000000;
	            DataOutIm <= 8'b00000000;			   
			   end
		end
end
/*************************************************************************************************/
endmodule


