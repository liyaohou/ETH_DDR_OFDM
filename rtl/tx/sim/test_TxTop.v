`timescale 1ns/1ps
module test_TxTop;


reg         sys_clk = 0;
reg         sys_rst_n = 0;
reg         rgmii_rxc = 0;
reg  [3:0]  rgmii_rxd = 0;
reg         rgmii_rx_ctl = 0;
wire        rgmii_txc   ;
wire        rgmii_txd   ;
wire [3:0]  rgmii_tx_ctl;  
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
// wire        dacClk;

wire [1:0]  ddr3_dqsP;
wire [1:0]  ddr3_dqsN;
wire [15:0] ddr3_dq;
// wire        dac_valid;
// wire        dac_payload_last;
// wire [15:0] dac_payload_fragment;
// reg         dac_ready = 0;
// wire        txEnd;
wire [15:0] dacData;
wire        dacClk;
wire        dacWrt;

TxTop TxTop_u(
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
    // .dac_valid      (dac_valid),
    // .dac_payload_last      (dac_payload_last),
    // .dac_payload_fragment      (dac_payload_fragment),
    // .dac_ready      (dac_ready)
    // .txEnd          (txEnd),
    .dacWrt        (dacWrt),
    .dacClk         (dacClk),
    .dacData        (dacData)
);

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

task automatic udp;
    input [9:0] BYTE_COUNTER; 
    integer i;
    begin
        tx_rgmii(2,16'd1234);
        tx_rgmii(2,16'd1234);
        tx_rgmii(2,BYTE_COUNTER + 8);
        if(BYTE_COUNTER == 64)
        tx_rgmii(2,16'h8da4);
        if(BYTE_COUNTER == 512)
        tx_rgmii(2,16'heda8);
        if(BYTE_COUNTER == 3)
        tx_rgmii(2,16'h7021);
        for(i=0;i<BYTE_COUNTER;i=i+1) begin
            tx_rgmii(1,i[7:0]);
        end
        if(BYTE_COUNTER < 18)
        for(i=0;i<(18-BYTE_COUNTER);i=i+1) begin
            tx_rgmii(1,0);
        end
    end
endtask

task automatic ip;
    input [9:0] BYTE_COUNTER; 
    begin
        tx_rgmii(2,16'h4500);//版本
        tx_rgmii(2,BYTE_COUNTER + 28);//长度
        if(BYTE_COUNTER == 64)
        tx_rgmii(2,16'h48df);//标识
        if(BYTE_COUNTER == 512)
        tx_rgmii(2,16'h48e2);//标识
        if(BYTE_COUNTER == 3)
        tx_rgmii(2,16'h48e3);//标识
        tx_rgmii(2,0);//片
        tx_rgmii(1,64);//生存时间
        tx_rgmii(1,17);//协议
        if(BYTE_COUNTER == 64)
        tx_rgmii(2,16'hada0);//首部校验和
        if(BYTE_COUNTER == 512)
        tx_rgmii(2,16'habdd);//首部校验和
        if(BYTE_COUNTER == 3)
        tx_rgmii(2,16'hadd9);//首部校验和
        tx_rgmii(4,32'hc0a80141);
        tx_rgmii(4,32'hc0a80180);
        udp(BYTE_COUNTER);
    end
endtask

task automatic eth;
    input [9:0] BYTE_COUNTER; 
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
        tx_rgmii(6,48'h112233445566);
        tx_rgmii(6,48'h6c1ff709fa24);//mac
        tx_rgmii(2,16'h0800);
        ip(BYTE_COUNTER);
        if(BYTE_COUNTER == 64)
        tx_rgmii(4,32'hae017646);//crc
        if(BYTE_COUNTER == 512)
        tx_rgmii(4,32'h9270c69f);//crc
        if(BYTE_COUNTER == 3)
        tx_rgmii(4,32'hcf1c7c69);//crc
        rgmii_rx_ctl = 0;
    end
endtask
task automatic eth_config;
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
        tx_rgmii(6,48'h112233445566);
        tx_rgmii(6,48'h6c1ff709fa24);//mac
        tx_rgmii(2,16'h0800);
        tx_rgmii(2,16'h4500);//版本
        tx_rgmii(2,31);//长度
        tx_rgmii(2,16'hde6c);//标识
        tx_rgmii(2,0);//片
        tx_rgmii(1,64);//生存时间
        tx_rgmii(1,17);//协议
        tx_rgmii(2,16'h1850);//首部校验和
        tx_rgmii(4,32'hc0a80141);
        tx_rgmii(4,32'hc0a80180);
        tx_rgmii(2,16'd1234);
        tx_rgmii(2,16'd1234);
        tx_rgmii(2,11);
        tx_rgmii(2,16'h4221);
        tx_rgmii(3,24'h200110);
        for(i=0;i<15;i=i+1) begin
            tx_rgmii(1,0);
        end
        tx_rgmii(4,32'he610ebd8);//crc
        rgmii_rx_ctl = 0;
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
        tx_rgmii(6,48'hffffffffffff);
        tx_rgmii(6,48'h6c1ff709fa24);//mac
        tx_rgmii(2,16'h0806);
        tx_rgmii(2,1);//硬件类型
        tx_rgmii(2,16'h0800);//协议类型
        tx_rgmii(2,16'h0604);//mac/ip长度
        tx_rgmii(2,1);//ARP请求
        tx_rgmii(6,48'h6c1ff709fa24);//mac
        tx_rgmii(4,32'hc0a80141);
        tx_rgmii(6,48'd0);
        tx_rgmii(4,32'hc0a80180);
        for(i=0;i<18;i=i+1) begin
            tx_rgmii(1,0);
        end
        tx_rgmii(4,32'h5f711a1a);//crc
        rgmii_rx_ctl = 0;
    end
endtask
initial begin
    #16;
    sys_rst_n = 1;
    // dac_ready = 1;
    
end
always #10 sys_clk = ~sys_clk;
always #4 rgmii_rxc = ~rgmii_rxc;
initial begin
    #1600;
    arp;
    #3200;
    eth(512);
    #1600;
    eth(512);
    #1600;
    eth(512);
    #1600;
    eth(512);
    #1600;
    eth(64);
    #1600;
    // eth(3);
    eth_config;
end

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