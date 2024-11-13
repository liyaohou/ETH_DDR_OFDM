/*在全局复位后                                           ******//////
/*送出分组检测模块有效信号给Data_Buffer_Shiftram         ******//////

/*DataBufferOutputEnable	 找到分组起始后的数据输出有效 ******////// 

/*FrameDetectionEnable    分组检测模块有效               ******//////

/*接收来自Frame_Finding module                           ******//////
/*FrameFind  分组起始找到有效                            ******//////
/**************************************/
module Top_Control(
	input 				Clk,
	input 				Rst_n,
	/*接收来自 Frame_Finding******//////
	/*FrameFind  分组起始找到有效******//////
	/*然后输出FrameDetectionEnable无效******//////
	input 				FrameFinded,
	/*DataBufferOutputEnable	 找到分组起始后的数据输出有效******//////
	output 			reg 	DataBufferOutputEnable,
	/*FrameDetectionEnable    分组检测模块有效******//////
	output 			reg	FrameDetectionEnable
	);

// reg 					FrameDetectionEnable;

// reg 					DataBufferOutputEnable;//

always@(posedge Clk or negedge Rst_n)
	begin
   	if (!Rst_n)	
      	begin
	    		/*DataBufferOutputEnable	 找到分组起始后的数据输出无效******//////
	    		DataBufferOutputEnable <= 0;
	    		/*FrameDetectionEnable    分组检测模块无效******//////
	    		FrameDetectionEnable <= 0; 
	 		end
   else
      begin
	    /*全局复位后 开始运行******//////
       /*分组检测模块保持有效 ******//////
	    FrameDetectionEnable <= 1; 	    
	    if (FrameFinded)  /*来自 Frame_Finding 的分组起始找到有效FrameFinded******//////
		 	begin
				/*找到分组起始后的数据输鲇行?*****//////
				DataBufferOutputEnable <= 1;
		  	end
       else	/*分组起始没有找到******//////
       	begin
		  		/*没有找到分组起始后的数据输出无效******//////
				DataBufferOutputEnable <= 0;
		  	end
 		end
	end
endmodule

