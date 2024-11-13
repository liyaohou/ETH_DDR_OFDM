//**************************************************************************************************************
//Function description: Simplify the complex multiplication operation to the addition operation

//Input: clock,reset,counter,multiplier_Real,multiplier_Imag,known_Real,known_Imag
//Output: output_Real,output_Imag

/*�ο�����ɽ��ѧ���ġ����ý���֪STSȡ����֮����������������*****//////
//Example��conjugate{(a + i*b)}= (a - i*b)
//       conj{(a+i*b)}*(1+i) = (a+b)+i*(a-b)
//       conj{(a+i*b)}*(1-i) = (a-b)+i*(-a-b) 
//       conj{(a+i*b)}*(-1+i)= (-a+b)+i*(a+b)
//       conj{(a+i*b)}*(-1-i)= (-a-b)+i*(-a+b)
//**************************************************************************************************************
`timescale 1ns/10ps

module Simple_Correlation(Clk,Rst_n,inEn,multiplier_Real,multiplier_Imag,known_Real,known_Imag,output_Real,output_Imag,OutputEnable);
    input Clk;						        /*ϵͳʱ��*****//////
	 input Rst_n;						     /*ϵͳ��λ�ź�******//////
	 input inEn;
    input  multiplier_Real;		     /*��λ�Ĵ���ʵ��******//////
    input  multiplier_Imag;		     /*��λ�Ĵ����鲿******//////
	 input [15:0] known_Real;		     /*������֪��ѵ������ʵ���������Ʋ����ʾ*******///////
	 input [15:0] known_Imag;		     /*��ѵ�������鲿*******///////

    output [16:0] output_Real;	     /*���ʵ������չΪ17λ��������Ϊ�����Ʋ����ʾ*******///////
    output [16:0] output_Imag;	     /*����鲿*******///////
	 output OutputEnable;

	 reg [16:0] output_Real;
	 reg [16:0] output_Imag;
	 reg OutputEnable;

  /*�����multiplier����0��ʾ����������1��ʾ����*****//////

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
