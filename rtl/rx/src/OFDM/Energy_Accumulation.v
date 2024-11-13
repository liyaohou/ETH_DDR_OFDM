/****************************************************************/
/*��Energy_Computing�ͳ���OutputEnable��Ч��                   ******//////
/*����Sum16Magnituder = Sum16Magnituder + MagnituderBuffer[0]  ******//////
/*                            - MagnituderBuffer[16]           ******//////
/*������ЧInputEnable��Magnituder8�ͳ�                         ******//////
/*�������ݷ���ƽ��DataInMagnituder                             ******//////
/*��������17λλ��  1λ����λ 4λ����λ 12λС��λ             ******//////
 
/*Sum16Magnituder 	�������ݷ���ƽ����16���ۼ�                ******//////
/*�������Sum16Magnituder                                      ******//////
/*�������21λλ��  1λ����λ 8λ����λ 12λС��λ             ******//////


/*����λ�Ĵ����������ݻ���                                     ******//////
    
/****************************************************************/
module Energy_Accumulation(Clk, Rst_n,
                                 InputEnable, DataInMagnituder,
						               OutputEnable, Sum16Magnituder);
input Clk;
input Rst_n;

/*��Magnituder8�ͳ�������������Ч******//////
input InputEnable;
/*�������� ���ݷ���ƽ�� 17λλ��  1λ����λ 4λ����λ 12λС��λ******//////
input [16:0] DataInMagnituder;

/*������� ���ݷ���ƽ����16���ۼ���Ч******//////
output OutputEnable;
/*������� ���ݷ���ƽ����16���ۼ�  20λλ��  1λ����λ 8λ����λ 12λС��λ******//////
output [20:0] Sum16Magnituder;

reg OutputEnable;
reg [20:0] Sum16Magnituder;

/******************************************************************************************/
/**************************������������Ч�����ݽ��л���************************************/
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

/****************************����λ�Ĵ������������****************************************/
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

