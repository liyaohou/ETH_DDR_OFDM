//**************************************************************************************************************
//Function descriprion: Approximately replace the magnitude of a complex number with the absolute value sum of
//real part and imag part

//Input: clock,Real,Imag
//Output: absolute_value
//**************************************************************************************************************

`timescale 1ns/10ps

module Magnitude_Simplified_Computing(Clk,Rst_n,DataEnable,DataInRe,DataInIm,AbsoluteEnable,Absolute);
    input Clk;                       /*ϵͳʱ��******//////
	 input Rst_n;                     /*ϵͳ��λ�ź�******////// 
	 input DataEnable;  
    input [20:0] DataInRe;	          /*����ʵ����λ��21λ�������Ʋ����ʾ******//////
    input [20:0] DataInIm;	          /*�����鲿******//////

    output AbsoluteEnable;
	 output [21:0] Absolute;          /*����ֵ�������һ�μӷ���λ���Ϊ22λ������ֵΪ����******//////
	 
    reg [21:0] Absolute;             /*������Ϊ22λλ��������������չΪ22λλ��******//////
	 reg AbsoluteEnable;    
	 
	 reg BufferEnable;
	 reg [20:0] BufferDataRe;
	 reg [20:0] BufferDataIm;

    always @ (posedge Clk or negedge Rst_n)				    /*��������һ�����棬�ӳ�һ��ʱ������******//////
	    begin
		    if (!Rst_n)
			   begin
					BufferEnable <= 0;
               BufferDataRe <= 0;
			      BufferDataIm <= 0;			      
				end
			 else
			   begin					         	                /*���������Ϊ�������ݵľ���ֵ******//////
				   if(DataEnable)
						begin
							BufferEnable <= 1;
							if(DataInRe[20] == 0)                /*����λΪ0����ʾΪ����������ֵ��Ϊ������******//////
					  			begin
				        			BufferDataRe <= DataInRe;
					  			end
							else								          /*����λΪ1����ʾΪ����������ֵΪ������ȡ����1******//////
					  			begin
					     			BufferDataRe <= ~ DataInRe + 1;
					  			end

				   		if (DataInIm[20] == 0)			       /*�鲿����ͬʵ��******//////
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
						/*��ȡʵ�����鲿�ľ���ֵ֮��******//////
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

