`timescale 1ns/1ps
module test_RxTop;

reg         sys_clk = 0;
reg         sys_rst_n = 0;
reg         rgmii_rxc = 0;
reg  [3:0]  rgmii_rxd = 0;
reg         rgmii_rx_ctl = 0;
wire        rgmii_txc   ;
wire [3:0]  rgmii_txd   ;
wire        rgmii_tx_ctl;  
wire        rgmii_rst_n ;
wire        ddr3_ckP   ;
wire        ddr3_ckN   ;
wire        ddr3_cke   ;
wire        ddr3_resetN;
wire        ddr3_rasN  ;
wire        ddr3_casN  ;
wire        ddr3_weN   ;
wire        ddr3_csN   ;
wire [2:0]  ddr3_ba    ;
wire [14:0] ddr3_addr  ;
wire        ddr3_odt   ;
wire [1:0]  ddr3_dm    ;
// reg         inputDataEn = 0;
// reg  [7:0]  inputDataR = 0;
// reg  [7:0]  inputDataI = 0;
// reg  [7:0]  inputSymbol = 0;
// wire        axisIn_ready;
// reg         axisIn_valid = 0;
// reg  [7:0]  axisIn_payload_data = 0;
// reg         axisIn_payload_last = 0;
// reg         axisIn_payload_user = 0;
// wire        dacClk;

wire [1:0]   ddr3_dqsP;
wire [1:0]   ddr3_dqsN;
wire [15:0]  ddr3_dq;
reg  [15:0]  adcData = 0;
wire          adcClk;
// wire        working_clk;
// reg        rxEnd = 0;
// wire [15:0] dacData;
always #10 sys_clk = ~sys_clk;
RxTop RxTop_u(
    .sys_clk        (sys_clk),
    .sys_rst_n      (sys_rst_n),
    .rgmii_rxc      (rgmii_rxc),
    .rgmii_rxd      (rgmii_rxd),
    .rgmii_rx_ctl   (rgmii_rx_ctl),
    .rgmii_txc      (rgmii_txc),
    .rgmii_txd      (rgmii_txd),
    .rgmii_tx_ctl   (rgmii_tx_ctl),
    .rgmii_rst_n    (rgmii_rst_n),
    .ddr3_ckP       (ddr3_ckP   ),
    .ddr3_ckN       (ddr3_ckN   ),
    .ddr3_cke       (ddr3_cke   ),
    .ddr3_resetN    (ddr3_resetN),
    .ddr3_rasN      (ddr3_rasN  ),
    .ddr3_casN      (ddr3_casN  ),
    .ddr3_weN       (ddr3_weN   ),
    .ddr3_csN       (ddr3_csN   ),
    .ddr3_ba        (ddr3_ba    ),
    .ddr3_addr      (ddr3_addr  ),
    .ddr3_odt       (ddr3_odt   ),
    .ddr3_dm        (ddr3_dm    ),
    .ddr3_dqsP      (ddr3_dqsP),
    .ddr3_dqsN      (ddr3_dqsN),
    .ddr3_dq        (ddr3_dq),
    .adcData        (adcData),
    .adcClk         (adcClk)
    // .rxEnd          (rxEnd),
    // .inputDataEn    (inputDataEn),
    // .inputDataR     (inputDataR),
    // .inputDataI     (inputDataI),
    // .inputSymbol    (inputSymbol),
    // .working_clk    (working_clk)
    // .axisIn_valid   (axisIn_valid),
    // .axisIn_ready   (axisIn_ready),
    // .axisIn_payload_data(axisIn_payload_data),
    // .axisIn_payload_last(axisIn_payload_last),
    // .axisIn_payload_user(axisIn_payload_user)
    // .dacClk         (dacClk),
    // .dacData        (dacData)
);
// task automatic inputData;
//     input [15:0] data;
//     begin
//         inputDataEn = 1;
//         inputDataR = data[15:8];
//         inputDataI = data[7:0];
//         #8;
//         inputDataEn = 0;
//         #24;
//         inputDataR = 0;
//         inputDataI = 0;
//     end
// endtask

task automatic tx_rgmii;
    input [5:0] BYTE_COUNTER; 
    input [47:0] value;
    integer i;
    begin
        for(i=0;i<BYTE_COUNTER*2;i=i+1) begin
            rgmii_rxd = (value >> ((BYTE_COUNTER-1-i/2)*8)) >> (4*(i%2));
            #4;
        end
    end
endtask

task automatic arp;
    integer i;
    begin
        wait(rgmii_rxc);
        wait(~rgmii_rxc);
        #2;
        rgmii_rx_ctl = 1;
        for(i=0;i<7;i=i+1) begin
            tx_rgmii(1,8'h55);
        end
        tx_rgmii(1,8'hD5);
        tx_rgmii(6,48'h665544332211);
        tx_rgmii(6,48'h6c1ff709fa24);//mac
        tx_rgmii(2,16'h0806);
        tx_rgmii(2,1);//硬件类型
        tx_rgmii(2,16'h0800);//协议类型
        tx_rgmii(2,16'h0604);//mac/ip长度
        tx_rgmii(2,2);//ARP响应
        tx_rgmii(6,48'h6c1ff709fa24);
        tx_rgmii(4,32'hc0a80141);
        tx_rgmii(6,48'h665544332211);//mac
        tx_rgmii(4,32'hc0a80178);
        for(i=0;i<18;i=i+1) begin
            tx_rgmii(1,0);
        end
        tx_rgmii(4,32'h61253f0f);//crc
        rgmii_rx_ctl = 0;
    end
endtask


initial begin
    #16;
    sys_rst_n = 1;
    
end

always #4 rgmii_rxc = ~rgmii_rxc;


initial begin
    wait(rgmii_tx_ctl);
    #4000;
    arp;
    
end
parameter DATA_NUM = 960;
parameter PATH = "E:/86152/FPGA/Verilog/file_management/temp/Receive1.0/sim/";
parameter PATH1 = "E:/86152/FPGA/Verilog/file_management/temp/Receive1.0/sim/";
// reg [1:0]       longmem[63:0];
// reg [15:0]      datamem[NUM-1:0];
reg  [15:0]	             test_data_byte [DATA_NUM-1:0];
initial begin
    // #80;
    // Rst_n = 1;
    // io_axisOut_ready = 1;
    // $readmemb({PATH,"long.txt"}, longmem);
    // $readmemb({PATH1,"pilot_data_out.txt"}, datamem);
    $readmemb({PATH,"dac_data_out.txt"},test_data_byte);
end
// task automatic OPCNT;
//     input [5:0]  num;
//     integer i;
//     integer j;
//     begin
//         for(i=0;i<num;i=i+1) begin
//             for(j=0;j<64;j=j+1) begin
//                 inputData(datamem[(i<<6)+j]);
//             end
//             inputSymbol = i + 4;
//             #120;
//         end
//     end
// endtask
task automatic inputAdcData;
    input [15:0] data;
    begin
        wait(adcClk);
        adcData = data[15:8];
    end
endtask
task automatic adcOPCNT;
    input [5:0]  num;
    integer i;
    integer j;
    begin
        for(i=0;i<num;i=i+1) begin
            for(j=0;j<64;j=j+1) begin
                inputAdcData(test_data_byte[(i<<6)+j]);
            end
        end
    end
endtask
initial begin
    #1600;
    wait(sys_rst_n);
    #800;
    adcOPCNT(DATA_NUM/64);
    #4800;
end

// task automatic long;
//     input [1:0] data;
//     begin
//         inputDataEn = 1;
//         inputDataR[7:6] = data;
//         inputDataR[5:0] = 0;
//         inputDataI = 0;
//         #8;
//         inputDataEn = 0;
//         #24;
//         inputDataR = 0;
//         inputDataI = 0;
//     end
// endtask

// integer m;
// initial begin
//     #1600;
//     wait(sys_rst_n);
//     wait(!working_clk);
//     wait(working_clk);
//     #800;
//     inputSymbol = 1;
//     for(m=0;m<64;m=m+1) begin
//         long(longmem[m]);
//     end
//     inputSymbol = 2;
//     #120;
//     for(m=0;m<64;m=m+1) begin
//         long(longmem[m]);
//     end
//     inputSymbol = 3;
//     #120;
//     OPCNT(NUM/64);
//     #800;
// end

parameter CLC = 32;
reg  [1:0] flag=0;
integer i;
integer j;
integer k;
initial begin : wait_rden
  wait(!ddr3_csN & ddr3_rasN & !ddr3_casN & ddr3_weN)
  # (CLC*4 + CLC/2);
  force ddr3_dqsP = 2'd0;
  force ddr3_dqsN = 2'd3;
  force ddr3_dq = 16'hfffe;
  # CLC;
end

initial fork 
    begin:flag_0
        while(1) begin
            wait(flag == 0)
            wait(!ddr3_csN & ddr3_rasN & !ddr3_casN & ddr3_weN)
            # (CLC*2);
            flag = flag + 1;
            # (CLC*3 + CLC/2);
            for(i=0;i<8;i=i+1) begin:read0
                force ddr3_dqsP = ~ddr3_dqsP;
                force ddr3_dqsN = ~ddr3_dqsN;
                force ddr3_dq[15:8] = ddr3_dq[15:8] + 8'd2;
                force ddr3_dq[7:0] = ddr3_dq[7:0] + 8'd2;
                # (CLC/2);
            end
        end
    end begin:flag_1
        while(1) begin
            wait(flag == 1)
            wait(!ddr3_csN & ddr3_rasN & !ddr3_casN & ddr3_weN)
            # (CLC*2);
            flag = flag + 1;
            # (CLC*3 + CLC/2);
            for(j=0;j<8;j=j+1) begin:read1
                force ddr3_dqsP = ~ddr3_dqsP;
                force ddr3_dqsN = ~ddr3_dqsN;
                force ddr3_dq[15:8] = ddr3_dq[15:8] + 8'd2;
                force ddr3_dq[7:0] = ddr3_dq[7:0] + 8'd2;
                # (CLC/2);
            end
        end
    end begin:flag_2
        while(1) begin
            wait(flag == 2)
            wait(!ddr3_csN & ddr3_rasN & !ddr3_casN & ddr3_weN)
            # (CLC*2);
            flag = 0;
            # (CLC*3 + CLC/2);
            for(k=0;k<8;k=k+1) begin:read1
                force ddr3_dqsP = ~ddr3_dqsP;
                force ddr3_dqsN = ~ddr3_dqsN;
                force ddr3_dq[15:8] = ddr3_dq[15:8] + 8'd2;
                force ddr3_dq[7:0] = ddr3_dq[7:0] + 8'd2;
                # (CLC/2);
            end
        end
    end 
join


endmodule