`timescale 1ns / 1ps
/*cnt加到CNT_NUM - 1后置零，cnt_last拉高一次*/
module counter #(parameter CNT_NUM = 4'd8,
				parameter	ADD = 1'b1)
(	
	input									clk			,
	input									rst_n		,
	input									En_cnt		,
	output	reg	[$clog2(CNT_NUM) - 1:0]		cnt			,
	output									cnt_last			
);

wire	end_cnt;

always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt <= ADD ? 'd0 : CNT_NUM - 1;
    end
    else if(En_cnt)begin
        if(end_cnt)begin
            cnt <= ADD ? 'd0 : CNT_NUM - 1;
		end
        else begin
            cnt <= ADD ? cnt + 1'b1 : cnt - 1'b1;
		end
    end
end

assign end_cnt = ADD ? cnt == CNT_NUM - 1 : cnt == 0;
assign cnt_last = end_cnt ? 1'b1:1'b0;
endmodule
