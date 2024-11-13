module Symbol_Output(
Clk,Rst_n,

PeakFinded,
DataInRe,DataInIm,

DataOutEnable,
DataOutRe,DataOutIm,

// DataOutReady,
Data_out_index,

// DataSymbol,
Symbol_cnt);


input Clk;
input Rst_n;
//the endness of the STS
input PeakFinded;
input [7:0]DataInRe;
input [7:0]DataInIm;
//the enable signal of the output datas
output reg DataOutEnable;
// input  DataOutReady;
//the output datas: signed 2QN format
output reg [7:0]DataOutRe;
output reg [7:0]DataOutIm;
output reg [5:0]Data_out_index;		
//the symbol counter

output reg [7:0]Symbol_cnt;

reg [7:0]DataSymbol;
// reg [7:0]Symbol_cnt;
reg [6:0]Counter1;
reg [6:0]Counter2;


always @(posedge Clk or negedge Rst_n)
	begin
		if(!Rst_n)
				Data_out_index <= 0;
		else
			begin
				if(Counter1 >= 22 && Counter1 <= 85)
						Data_out_index <= (Counter1 - 'd22);
				else  if(Counter2 >= 16 && Counter2 <= 79)
							Data_out_index <= (Counter2 - 'd16);
				else
							Data_out_index <= 0;
				end
			end

	
//使第二个LTS和data延时16个周期
reg [15:0]  BufferOutEnable;
reg [127:0] BufferDataSymbol;
reg [127:0] BufferDataOutRe;
reg [127:0] BufferDataOutIm;
reg [7:0]TempSymbol;

always @(posedge Clk or negedge Rst_n)
	begin
		if(!Rst_n)
			begin
				Counter1 <= 0;
				Counter2 <= 0;
				DataOutEnable <= 0;
				DataOutRe <= 0;
				DataOutIm <= 0;
				DataSymbol <= 0;
				BufferOutEnable <= 0;
				BufferDataSymbol <= 0;
				BufferDataOutRe <= 0;
				BufferDataOutIm <= 0;
				TempSymbol <= 0;
			end
		else
			begin
				if(PeakFinded)
					begin
						if(Counter1 <= 85)  //the counter is set by 85, because the processing (quantization,correlation,and so on) delay is 10 clock
							begin
								Counter2 <= 0;
								Counter1 <= Counter1 + 1;//////////////////////////////////////////////
								if(Counter1 >= 22 && Counter1 <= 85 )//the cyclix prefix of the LTS is 32, and the delay is 10, thus 32-10=22
									begin
										DataOutEnable <= 1;
										DataOutRe <= DataInRe;
										DataOutIm <= DataInIm;
									end
								else
									begin
										DataOutEnable <= 0;
										DataOutRe <= 0;
										DataOutIm <= 0;
									end
								if(Counter1 == 22)
									begin
										DataSymbol <= DataSymbol + 1;
										TempSymbol <= DataSymbol + 1;
									end
							end
						else
							begin//when the value of counter2 is between 0 and 63, the input datas are the datas we need
							     //and when the valus of counter2 is between 64 and 79, the input datas are the cyclic prefix of the next symbol
								if(Counter2 == 79)
							 		begin
										Counter2 <= 0;
										TempSymbol <= TempSymbol + 1;
									end
								else
									begin
										Counter2 <= Counter2 + 1;
									end
								if(Counter2 >= 0 && Counter2 <= 63 )
									begin
										BufferOutEnable[15] <= 1;
										BufferDataOutRe[127:120] <= DataInRe; 
										BufferDataOutIm[127:120] <= DataInIm;
									  	BufferDataSymbol[127:120] <= TempSymbol + 1;
									end
								else
									begin
										BufferOutEnable[15] <= 0;
										BufferDataOutRe[127:120] <= 0; 
										BufferDataOutIm[127:120] <= 0;
										BufferDataSymbol[127:120] <= 0;
									end
								BufferOutEnable[14:0] <= BufferOutEnable[15:1];
								BufferDataOutRe[119:0] <= BufferDataOutRe[127:8];
								BufferDataOutIm[119:0] <= BufferDataOutIm[127:8];
								DataOutEnable <= BufferOutEnable[0];
								DataOutRe <= BufferDataOutRe[7:0];
								DataOutIm <= BufferDataOutIm[7:0];
								BufferDataSymbol[119:0] <= BufferDataSymbol[127:8];
								DataSymbol <= BufferDataSymbol[7:0];
							end
					end
				else
					begin
						if(Counter2 == 0) //the length of the input datas is an integral multiple of the length of symbol (64)  
							begin					
								BufferOutEnable <= 0;
								BufferDataOutRe <= 0;
								BufferDataOutIm <= 0;
								BufferDataSymbol <= 0;
								DataOutEnable <= 0;
								DataOutRe <= 0;
								DataOutIm <= 0;
								DataSymbol <= 0;
							end
						else     //if not, keeping output until it satifies (the values of counter2 is 79)
							begin
								if(Counter2 == 79)    
									Counter2 <= 0;
								else
								Counter2 <= Counter2 + 1;
								BufferDataSymbol[127:120] <= TempSymbol+1;
								BufferDataSymbol[119:0] <= BufferDataSymbol[127:8];
								DataSymbol <= BufferDataSymbol[7:0];
								BufferOutEnable[14:0] <= BufferOutEnable[15:1];
								BufferDataOutRe[119:0] <= BufferDataOutRe[127:8];
								BufferDataOutIm[119:0] <= BufferDataOutIm[127:8];
								DataOutEnable <= BufferOutEnable[0];
								DataOutRe <= BufferDataOutRe[7:0];
								DataOutIm <= BufferDataOutIm[7:0];
								BufferOutEnable[15] <= 1;
								BufferDataOutRe[127:120] <= DataInRe; 
								BufferDataOutIm[127:120] <= DataInIm;
							end										
						Counter1 <= 0;
					end
			end
	end
	
    always@(*)
    begin
        if (!Rst_n)
        begin
            Symbol_cnt = 0;
            end
		else if (Counter1 == 1) begin
			Symbol_cnt = 0;
		end
        else begin
                if (DataOutEnable)
                    begin
                        Symbol_cnt = DataSymbol;
                    end
                else
                begin
                        Symbol_cnt = Symbol_cnt;		  		  
                    end	 
            end
    end

endmodule

