//**************************************************************************************************************
//Function description: Simplify the complex multiplication operation to the addition operation

//Input: clock,reset,counter,multiplier_Real,multiplier_Imag,known_Real,known_Imag
//Output: output_Real,output_Imag

/*参考《中山大学论文》，得将已知STS取共轭之后再与量化结果相乘*****//////
//Example：conjugate{(a + i*b)}= (a - i*b)
//       conj{(a+i*b)}*(1+i) = (a+b)+i*(a-b)
//       conj{(a+i*b)}*(1-i) = (a-b)+i*(-a-b) 
//       conj{(a+i*b)}*(-1+i)= (-a+b)+i*(a+b)
//       conj{(a+i*b)}*(-1-i)= (-a-b)+i*(-a+b)
//**************************************************************************************************************
`timescale 1ns/10ps

module Simple_Correlation(Clk,Rst_n,inEn,multiplier_Real,multiplier_Imag,known_Real,known_Imag,output_Real,output_Imag,OutputEnable);
    input Clk;						        /*系统时钟*****//////
	 input Rst_n;						     /*系统复位信号******//////
	 input inEn;
    input  multiplier_Real;		     /*移位寄存器实部******//////
    input  multiplier_Imag;		     /*移位寄存器虚部******//////
	 input [15:0] known_Real;		     /*本地已知短训练序列实部，二进制补码表示*******///////
	 input [15:0] known_Imag;		     /*短训练序列虚部*******///////

    output [16:0] output_Real;	     /*输出实部，扩展为17位输出，输出为二进制补码表示*******///////
    output [16:0] output_Imag;	     /*输出虚部*******///////
	 output OutputEnable;

	 reg [16:0] output_Real;
	 reg [16:0] output_Imag;
	 reg OutputEnable;

  /*输入的multiplier等于0表示正数，等于1表示负数*****//////

  always @ (posedge Clk or negedge Rst_n)	
    begin
	    if (!Rst_n)
		   begin
				output_Real <= 0;
				output_Imag <= 0;
				OutputEnable <= 0;
			end
	    else if (inEn)
		   begin
				OutputEnable <= 1;		  								              
			   if (multiplier_Real == 0 && multiplier_Imag == 0)			 
				  begin
                 output_Real <= {{1{known_Real[15]}},known_Real} + {{1{known_Imag[15]}},known_Imag};
					  output_Imag <= {{1{known_Real[15]}},known_Real} - {{1{known_Imag[15]}},known_Imag};
				  end
			   else if (multiplier_Real == 0 && multiplier_Imag == 1)
				  begin
                 output_Real <= {{1{known_Real[15]}},known_Real} - {{1{known_Imag[15]}},known_Imag};
					  output_Imag <= - {{1{known_Real[15]}},known_Real} - {{1{known_Imag[15]}},known_Imag};
				  end
			   else if (multiplier_Real == 1 && multiplier_Imag == 0)
				  begin
				     output_Real <= - {{1{known_Real[15]}},known_Real} + {{1{known_Imag[15]}},known_Imag};
					  output_Imag <= {{1{known_Real[15]}},known_Real} + {{1{known_Imag[15]}},known_Imag};
				  end
			   else  //(buffer_multiplier_Real==1 && buffer_multiplier_Imag==1)
				  begin
				     output_Real <= - {{1{known_Real[15]}},known_Real} - {{1{known_Imag[15]}},known_Imag};
					  output_Imag <= - {{1{known_Real[15]}},known_Real} + {{1{known_Imag[15]}},known_Imag};
				  end
			end
	   else		 
			begin
		      output_Real <= 0;
		      output_Imag <= 0;
				OutputEnable <= 0;
		   end            
	 end
endmodule
