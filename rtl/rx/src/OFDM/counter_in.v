`timescale 1ns / 1ps

module counter_in #(parameter CNT_NUM = 4'd8,//最大计数值
				    parameter ADD = 1'b1)
(	
	input							    clk			,
	input							    rst_n		,
	input							    En_cnt		,
	input	[$clog2(CNT_NUM) - 1:0]	    cnt_din		,//所需计数最大值输入
	
	output	reg	[$clog2(CNT_NUM) - 1:0]	cnt		    ,
	output							    cnt_last			
);

wire	end_cnt;

always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt <= ADD ? 'd0 : cnt_din;
    end
    else if(En_cnt)begin
        if(end_cnt)begin
            cnt <= ADD ? 'd0 : cnt_din ;
		end
        else begin
            cnt <= ADD ? cnt + 1'b1 : cnt - 1'b1;
		end
    end
end

assign end_cnt = ADD ? cnt == cnt_din : cnt == 0;
assign cnt_last = end_cnt ? 1'b1:1'b0;
endmodule
