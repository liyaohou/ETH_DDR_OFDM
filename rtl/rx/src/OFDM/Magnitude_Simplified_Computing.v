//**************************************************************************************************************
//Function descriprion: Approximately replace the magnitude of a complex number with the absolute value sum of
//real part and imag part

//Input: clock,Real,Imag
//Output: absolute_value
//**************************************************************************************************************

`timescale 1ns/10ps

module Magnitude_Simplified_Computing(Clk,Rst_n,DataEnable,DataInRe,DataInIm,AbsoluteEnable,Absolute);
    input Clk;                       /*系统时钟******//////
	 input Rst_n;                     /*系统复位信号******////// 
	 input DataEnable;  
    input [20:0] DataInRe;	          /*输入实部，位宽21位，二进制补码表示******//////
    input [20:0] DataInIm;	          /*输入虚部******//////

    output AbsoluteEnable;
	 output [21:0] Absolute;          /*绝对值输出，经一次加法后，位宽变为22位，绝对值为正数******//////
	 
    reg [21:0] Absolute;             /*输出结果为22位位宽，操作数首先扩展为22位位宽******//////
	 reg AbsoluteEnable;    
	 
	 reg BufferEnable;
	 reg [20:0] BufferDataRe;
	 reg [20:0] BufferDataIm;

    always @ (posedge Clk or negedge Rst_n)				    /*输入增加一级缓存，延迟一个时钟周期******//////
	    begin
		    if (!Rst_n)
			   begin
					BufferEnable <= 0;
               BufferDataRe <= 0;
			      BufferDataIm <= 0;			      
				end
			 else
			   begin					         	                /*缓存的数据为输入数据的绝对值******//////
				   if(DataEnable)
						begin
							BufferEnable <= 1;
							if(DataInRe[20] == 0)                /*符号位为0，表示为正数，绝对值即为输入数******//////
					  			begin
				        			BufferDataRe <= DataInRe;
					  			end
							else								          /*符号位为1，表示为负数，绝对值为输入数取反加1******//////
					  			begin
					     			BufferDataRe <= ~ DataInRe + 1;
					  			end

				   		if (DataInIm[20] == 0)			       /*虚部运算同实部******//////
					  			begin
				        			BufferDataIm <= DataInIm;
					  			end
							else
					  			begin
					     			BufferDataIm <= ~ DataInIm + 1;
					  			end
						end
					else
						begin
							BufferEnable <= 0;
							BufferDataRe <= 0;
							BufferDataIm <= 0;
						end
				end
		 end

    always @ (posedge Clk or negedge Rst_n) 
      begin
	      if (!Rst_n)
	   	  begin
				  Absolute <= 0;
				  AbsoluteEnable <= 0;
			  end
		   else
			  begin						 
			     if(BufferEnable)
				  	begin
						/*求取实部与虚部的绝对值之和******//////
						Absolute <= {BufferDataRe[20],BufferDataRe} + {BufferDataIm[20],BufferDataIm};    
						AbsoluteEnable <= 1;
					end
				  else
				  	begin
						Absolute <= 0;
						AbsoluteEnable <= 0;
					end
			  end
       end							 
endmodule

