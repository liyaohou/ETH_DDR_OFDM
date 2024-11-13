// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : TxTop
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module TxTop (
  input  wire          sys_clk,
  input  wire          sys_rst_n,
  input  wire          rgmii_rxc,
  input  wire [3:0]    rgmii_rxd,
  input  wire          rgmii_rx_ctl,
  output wire          rgmii_txc,
  output wire [3:0]    rgmii_txd,
  output wire          rgmii_tx_ctl,
  output wire          rgmii_rst_n,
  output wire [0:0]    ddr3_ckP,
  output wire [0:0]    ddr3_ckN,
  output wire [0:0]    ddr3_cke,
  output wire [0:0]    ddr3_resetN,
  output wire [0:0]    ddr3_rasN,
  output wire [0:0]    ddr3_casN,
  output wire [0:0]    ddr3_weN,
  output wire [0:0]    ddr3_csN,
  output wire [2:0]    ddr3_ba,
  output wire [14:0]   ddr3_addr,
  output wire [0:0]    ddr3_odt,
  output wire [1:0]    ddr3_dm,
  inout  wire [1:0]    ddr3_dqsP,
  inout  wire [1:0]    ddr3_dqsN,
  inout  wire [15:0]   ddr3_dq,
  output wire          dacClk,
  output wire          dacWrt,
  output wire [15:0]   dacData
);

  reg                 workClockArea_ethMacRx_port_udp_rx_hdr_ready;
  wire       [0:0]    workClockArea_configRx_io_udpAxisIn_payload_user;
  wire       [0:0]    workClockArea_ddr3AxisTxIf_io_axisWr_payload_user;
  wire       [0:0]    workClockArea_ethMacTx_port_udp_tx_axis_payload_user;
  wire       [0:0]    workClockArea_harMatch_io_signalIn_payload_axis_user;
  wire       [0:0]    workClockArea_axisTxRateCtrl_io_axiIn_payload_user;
  wire                pll_clk_1_locked;
  wire                pll_clk_1_clk_out1;
  wire                pll_clk_1_clk_out2;
  wire                pll_clk_1_clk_out3;
  wire                pll_clk_1_clk_out4;
  wire                pll_clk_1_clk_out5;
  wire                pll_clk_1_clk_out6;
  wire                workClockArea_ethMacRx_rgmii_txc;
  wire       [3:0]    workClockArea_ethMacRx_rgmii_txd;
  wire                workClockArea_ethMacRx_rgmii_tx_ctl;
  wire                workClockArea_ethMacRx_rgmii_rst_n;
  wire                workClockArea_ethMacRx_port_udp_rx_hdr_valid;
  wire                workClockArea_ethMacRx_port_udp_rx_axis_valid;
  wire       [7:0]    workClockArea_ethMacRx_port_udp_rx_axis_payload_data;
  wire                workClockArea_ethMacRx_port_udp_rx_axis_payload_last;
  wire       [0:0]    workClockArea_ethMacRx_port_udp_rx_axis_payload_user;
  wire       [9:0]    workClockArea_ethMacRx_port_udp_rx_length;
  wire       [31:0]   workClockArea_ethMacRx_port_udp_rx_source_ip;
  wire                workClockArea_configRx_io_udpAxisIn_ready;
  wire                workClockArea_configRx_io_udpAxisOut_valid;
  wire       [7:0]    workClockArea_configRx_io_udpAxisOut_payload_data;
  wire                workClockArea_configRx_io_udpAxisOut_payload_last;
  wire       [0:0]    workClockArea_configRx_io_udpAxisOut_payload_user;
  wire       [9:0]    workClockArea_configRx_io_lengthOut;
  wire                workClockArea_configRx_io_rxHdr_ready;
  wire       [20:0]   workClockArea_configRx_io_config;
  wire                workClockArea_configRx_io_end;
  wire                workClockArea_ddr3AxisTxIf_io_axisWr_ready;
  wire       [9:0]    workClockArea_ddr3AxisTxIf_io_lengthOut;
  wire                workClockArea_ddr3AxisTxIf_io_signalRd_valid;
  wire       [7:0]    workClockArea_ddr3AxisTxIf_io_signalRd_payload_axis_data;
  wire                workClockArea_ddr3AxisTxIf_io_signalRd_payload_axis_last;
  wire       [0:0]    workClockArea_ddr3AxisTxIf_io_signalRd_payload_axis_user;
  wire                workClockArea_ddr3AxisTxIf_io_signalRd_payload_lastPiece;
  wire                workClockArea_ddr3AxisTxIf_io_txCtrl_ready;
  wire                workClockArea_ddr3AxisTxIf_io_writeEnd_valid;
  wire                workClockArea_ddr3AxisTxIf_io_ddr3InitDone;
  wire       [0:0]    workClockArea_ddr3AxisTxIf_io_ddr3_ckP;
  wire       [0:0]    workClockArea_ddr3AxisTxIf_io_ddr3_ckN;
  wire       [0:0]    workClockArea_ddr3AxisTxIf_io_ddr3_cke;
  wire       [0:0]    workClockArea_ddr3AxisTxIf_io_ddr3_resetN;
  wire       [0:0]    workClockArea_ddr3AxisTxIf_io_ddr3_rasN;
  wire       [0:0]    workClockArea_ddr3AxisTxIf_io_ddr3_casN;
  wire       [0:0]    workClockArea_ddr3AxisTxIf_io_ddr3_weN;
  wire       [0:0]    workClockArea_ddr3AxisTxIf_io_ddr3_csN;
  wire       [2:0]    workClockArea_ddr3AxisTxIf_io_ddr3_ba;
  wire       [14:0]   workClockArea_ddr3AxisTxIf_io_ddr3_addr;
  wire       [0:0]    workClockArea_ddr3AxisTxIf_io_ddr3_odt;
  wire       [1:0]    workClockArea_ddr3AxisTxIf_io_ddr3_dm;
  wire                workClockArea_ethMacTx_port_udp_tx_hdr_ready;
  wire                workClockArea_ethMacTx_port_udp_tx_axis_ready;
  wire                workClockArea_ethMacTx_port_eth_tx_axis_valid;
  wire       [7:0]    workClockArea_ethMacTx_port_eth_tx_axis_payload_data;
  wire                workClockArea_ethMacTx_port_eth_tx_axis_payload_last;
  wire       [0:0]    workClockArea_ethMacTx_port_eth_tx_axis_payload_user;
  wire                workClockArea_harMatch_io_hdr_valid;
  wire                workClockArea_harMatch_io_signalIn_ready;
  wire                workClockArea_harMatch_io_signalOut_valid;
  wire       [7:0]    workClockArea_harMatch_io_signalOut_payload_axis_data;
  wire                workClockArea_harMatch_io_signalOut_payload_axis_last;
  wire       [0:0]    workClockArea_harMatch_io_signalOut_payload_axis_user;
  wire                workClockArea_harMatch_io_signalOut_payload_lastPiece;
  wire                workClockArea_axisTxRateCtrl_io_txCtrl_valid;
  wire                workClockArea_axisTxRateCtrl_io_axiIn_ready;
  wire                workClockArea_axisTxRateCtrl_io_axiOut_valid;
  wire       [7:0]    workClockArea_axisTxRateCtrl_io_axiOut_payload_data;
  wire                workClockArea_axisTxRateCtrl_io_axiOut_payload_last;
  wire       [0:0]    workClockArea_axisTxRateCtrl_io_axiOut_payload_user;
  wire                workClockArea_axisTxRateCtrl_io_config_valid;
  wire                workClockArea_axisTxRateCtrl_io_cfgStart;
  wire                workClockArea_axisTxRateCtrl_io_txEnd;
  wire                workClockArea_ofdmTx_mcu_config_dout_rdy;
  wire                workClockArea_ofdmTx_mcu_mac_dout_rdy;
  wire                workClockArea_ofdmTx_dac_dout_vld;
  wire                workClockArea_ofdmTx_dac_dout_last;
  wire       [15:0]   workClockArea_ofdmTx_dac_dout;
  wire       [8:0]    workClockArea_ofdmTx_dac_dout_Index;
  wire                rstN;
  wire                port_udp_rx_hdr_m2sPipe_valid;
  wire                port_udp_rx_hdr_m2sPipe_ready;
  reg                 port_udp_rx_hdr_rValid;
  wire                when_Stream_l393;
  wire                io_signalOut_translated_valid;
  wire                io_signalOut_translated_ready;
  wire       [7:0]    io_signalOut_translated_payload_data;
  wire                io_signalOut_translated_payload_last;
  wire       [0:0]    io_signalOut_translated_payload_user;
  wire                io_axiOut_translated_valid;
  wire                io_axiOut_translated_ready;
  wire       [7:0]    io_axiOut_translated_payload;
  wire                io_config_translated_valid;
  wire                io_config_translated_ready;
  wire       [20:0]   io_config_translated_payload;

  pll_clk pll_clk_1 (
    .resetn   (sys_rst_n         ), //i
    .locked   (pll_clk_1_locked  ), //o
    .clk_in1  (sys_clk           ), //i
    .clk_out1 (pll_clk_1_clk_out1), //o
    .clk_out2 (pll_clk_1_clk_out2), //o
    .clk_out3 (pll_clk_1_clk_out3), //o
    .clk_out4 (pll_clk_1_clk_out4), //o
    .clk_out5 (pll_clk_1_clk_out5), //o
    .clk_out6 (pll_clk_1_clk_out6)  //o
  );
  eth_mac_tx_r workClockArea_ethMacRx (
    .logic_clk                     (pll_clk_1_clk_out1                                       ), //i
    .gtx_clk                       (pll_clk_1_clk_out5                                       ), //i
    .gtx_clk90                     (pll_clk_1_clk_out1                                       ), //i
    .rst_n                         (rstN                                                     ), //i
    .rgmii_rxc                     (rgmii_rxc                                                ), //i
    .rgmii_rxd                     (rgmii_rxd[3:0]                                           ), //i
    .rgmii_rx_ctl                  (rgmii_rx_ctl                                             ), //i
    .rgmii_txc                     (workClockArea_ethMacRx_rgmii_txc                         ), //o
    .rgmii_txd                     (workClockArea_ethMacRx_rgmii_txd[3:0]                    ), //o
    .rgmii_tx_ctl                  (workClockArea_ethMacRx_rgmii_tx_ctl                      ), //o
    .rgmii_rst_n                   (workClockArea_ethMacRx_rgmii_rst_n                       ), //o
    .port_udp_rx_hdr_valid         (workClockArea_ethMacRx_port_udp_rx_hdr_valid             ), //o
    .port_udp_rx_hdr_ready         (workClockArea_ethMacRx_port_udp_rx_hdr_ready             ), //i
    .port_udp_rx_axis_valid        (workClockArea_ethMacRx_port_udp_rx_axis_valid            ), //o
    .port_udp_rx_axis_ready        (workClockArea_configRx_io_udpAxisIn_ready                ), //i
    .port_udp_rx_axis_payload_data (workClockArea_ethMacRx_port_udp_rx_axis_payload_data[7:0]), //o
    .port_udp_rx_axis_payload_last (workClockArea_ethMacRx_port_udp_rx_axis_payload_last     ), //o
    .port_udp_rx_axis_payload_user (workClockArea_ethMacRx_port_udp_rx_axis_payload_user     ), //o
    .port_udp_rx_length            (workClockArea_ethMacRx_port_udp_rx_length[9:0]           ), //o
    .port_udp_rx_source_ip         (workClockArea_ethMacRx_port_udp_rx_source_ip[31:0]       )  //o
  );
  ConfigRx workClockArea_configRx (
    .io_udpAxisIn_valid         (workClockArea_ethMacRx_port_udp_rx_axis_valid            ), //i
    .io_udpAxisIn_ready         (workClockArea_configRx_io_udpAxisIn_ready                ), //o
    .io_udpAxisIn_payload_data  (workClockArea_ethMacRx_port_udp_rx_axis_payload_data[7:0]), //i
    .io_udpAxisIn_payload_last  (workClockArea_ethMacRx_port_udp_rx_axis_payload_last     ), //i
    .io_udpAxisIn_payload_user  (workClockArea_configRx_io_udpAxisIn_payload_user         ), //i
    .io_udpAxisOut_valid        (workClockArea_configRx_io_udpAxisOut_valid               ), //o
    .io_udpAxisOut_ready        (workClockArea_ddr3AxisTxIf_io_axisWr_ready               ), //i
    .io_udpAxisOut_payload_data (workClockArea_configRx_io_udpAxisOut_payload_data[7:0]   ), //o
    .io_udpAxisOut_payload_last (workClockArea_configRx_io_udpAxisOut_payload_last        ), //o
    .io_udpAxisOut_payload_user (workClockArea_configRx_io_udpAxisOut_payload_user        ), //o
    .io_lengthIn                (workClockArea_ethMacRx_port_udp_rx_length[9:0]           ), //i
    .io_lengthOut               (workClockArea_configRx_io_lengthOut[9:0]                 ), //o
    .io_rxHdr_valid             (port_udp_rx_hdr_m2sPipe_valid                            ), //i
    .io_rxHdr_ready             (workClockArea_configRx_io_rxHdr_ready                    ), //o
    .io_config                  (workClockArea_configRx_io_config[20:0]                   ), //o
    .io_end                     (workClockArea_configRx_io_end                            ), //o
    .clk_out1                   (pll_clk_1_clk_out1                                       ), //i
    .rstN                       (rstN                                                     )  //i
  );
  Ddr3AxisTxInterface workClockArea_ddr3AxisTxIf (
    .work_clk                      (pll_clk_1_clk_out4                                           ), //i
    .ddr_clk                       (pll_clk_1_clk_out1                                           ), //i
    .ddr90_clk                     (pll_clk_1_clk_out2                                           ), //i
    .ref_clk                       (pll_clk_1_clk_out3                                           ), //i
    .io_axisWr_valid               (workClockArea_configRx_io_udpAxisOut_valid                   ), //i
    .io_axisWr_ready               (workClockArea_ddr3AxisTxIf_io_axisWr_ready                   ), //o
    .io_axisWr_payload_data        (workClockArea_configRx_io_udpAxisOut_payload_data[7:0]       ), //i
    .io_axisWr_payload_last        (workClockArea_configRx_io_udpAxisOut_payload_last            ), //i
    .io_axisWr_payload_user        (workClockArea_ddr3AxisTxIf_io_axisWr_payload_user            ), //i
    .io_lengthIn                   (workClockArea_configRx_io_lengthOut[9:0]                     ), //i
    .io_lengthOut                  (workClockArea_ddr3AxisTxIf_io_lengthOut[9:0]                 ), //o
    .io_signalRd_valid             (workClockArea_ddr3AxisTxIf_io_signalRd_valid                 ), //o
    .io_signalRd_ready             (workClockArea_harMatch_io_signalIn_ready                     ), //i
    .io_signalRd_payload_axis_data (workClockArea_ddr3AxisTxIf_io_signalRd_payload_axis_data[7:0]), //o
    .io_signalRd_payload_axis_last (workClockArea_ddr3AxisTxIf_io_signalRd_payload_axis_last     ), //o
    .io_signalRd_payload_axis_user (workClockArea_ddr3AxisTxIf_io_signalRd_payload_axis_user     ), //o
    .io_signalRd_payload_lastPiece (workClockArea_ddr3AxisTxIf_io_signalRd_payload_lastPiece     ), //o
    .io_txCtrl_valid               (workClockArea_axisTxRateCtrl_io_txCtrl_valid                 ), //i
    .io_txCtrl_ready               (workClockArea_ddr3AxisTxIf_io_txCtrl_ready                   ), //o
    .io_writeEnd_valid             (workClockArea_ddr3AxisTxIf_io_writeEnd_valid                 ), //o
    .io_writeEnd_ready             (workClockArea_configRx_io_end                                ), //i
    .io_ddr3InitDone               (workClockArea_ddr3AxisTxIf_io_ddr3InitDone                   ), //o
    .io_ddr3_ckP                   (workClockArea_ddr3AxisTxIf_io_ddr3_ckP                       ), //o
    .io_ddr3_ckN                   (workClockArea_ddr3AxisTxIf_io_ddr3_ckN                       ), //o
    .io_ddr3_cke                   (workClockArea_ddr3AxisTxIf_io_ddr3_cke                       ), //o
    .io_ddr3_resetN                (workClockArea_ddr3AxisTxIf_io_ddr3_resetN                    ), //o
    .io_ddr3_rasN                  (workClockArea_ddr3AxisTxIf_io_ddr3_rasN                      ), //o
    .io_ddr3_casN                  (workClockArea_ddr3AxisTxIf_io_ddr3_casN                      ), //o
    .io_ddr3_weN                   (workClockArea_ddr3AxisTxIf_io_ddr3_weN                       ), //o
    .io_ddr3_csN                   (workClockArea_ddr3AxisTxIf_io_ddr3_csN                       ), //o
    .io_ddr3_ba                    (workClockArea_ddr3AxisTxIf_io_ddr3_ba[2:0]                   ), //o
    .io_ddr3_addr                  (workClockArea_ddr3AxisTxIf_io_ddr3_addr[14:0]                ), //o
    .io_ddr3_odt                   (workClockArea_ddr3AxisTxIf_io_ddr3_odt                       ), //o
    .io_ddr3_dm                    (workClockArea_ddr3AxisTxIf_io_ddr3_dm[1:0]                   ), //o
    .io_ddr3_dqsP                  (ddr3_dqsP                                                    ), //~
    .io_ddr3_dqsN                  (ddr3_dqsN                                                    ), //~
    .io_ddr3_dq                    (ddr3_dq                                                      ), //~
    .clk_out4                      (pll_clk_1_clk_out4                                           ), //i
    .rstN                          (rstN                                                         ), //i
    .clk_out1                      (pll_clk_1_clk_out1                                           )  //i
  );
  eth_mac_tx_t workClockArea_ethMacTx (
    .logic_clk                     (pll_clk_1_clk_out1                                       ), //i
    .gtx_clk                       (pll_clk_1_clk_out5                                       ), //i
    .gtx_clk90                     (pll_clk_1_clk_out1                                       ), //i
    .rst_n                         (rstN                                                     ), //i
    .port_udp_tx_hdr_valid         (workClockArea_harMatch_io_hdr_valid                      ), //i
    .port_udp_tx_hdr_ready         (workClockArea_ethMacTx_port_udp_tx_hdr_ready             ), //o
    .port_udp_tx_axis_valid        (io_signalOut_translated_valid                            ), //i
    .port_udp_tx_axis_ready        (workClockArea_ethMacTx_port_udp_tx_axis_ready            ), //o
    .port_udp_tx_axis_payload_data (io_signalOut_translated_payload_data[7:0]                ), //i
    .port_udp_tx_axis_payload_last (io_signalOut_translated_payload_last                     ), //i
    .port_udp_tx_axis_payload_user (workClockArea_ethMacTx_port_udp_tx_axis_payload_user     ), //i
    .port_udp_tx_length            (workClockArea_ddr3AxisTxIf_io_lengthOut[9:0]             ), //i
    .port_udp_tx_dest_ip           (32'hc0a80180                                             ), //i
    .port_eth_tx_axis_valid        (workClockArea_ethMacTx_port_eth_tx_axis_valid            ), //o
    .port_eth_tx_axis_ready        (workClockArea_axisTxRateCtrl_io_axiIn_ready              ), //i
    .port_eth_tx_axis_payload_data (workClockArea_ethMacTx_port_eth_tx_axis_payload_data[7:0]), //o
    .port_eth_tx_axis_payload_last (workClockArea_ethMacTx_port_eth_tx_axis_payload_last     ), //o
    .port_eth_tx_axis_payload_user (workClockArea_ethMacTx_port_eth_tx_axis_payload_user     )  //o
  );
  HarMatch workClockArea_harMatch (
    .io_hdr_valid                   (workClockArea_harMatch_io_hdr_valid                          ), //o
    .io_hdr_ready                   (workClockArea_ethMacTx_port_udp_tx_hdr_ready                 ), //i
    .io_signalIn_valid              (workClockArea_ddr3AxisTxIf_io_signalRd_valid                 ), //i
    .io_signalIn_ready              (workClockArea_harMatch_io_signalIn_ready                     ), //o
    .io_signalIn_payload_axis_data  (workClockArea_ddr3AxisTxIf_io_signalRd_payload_axis_data[7:0]), //i
    .io_signalIn_payload_axis_last  (workClockArea_ddr3AxisTxIf_io_signalRd_payload_axis_last     ), //i
    .io_signalIn_payload_axis_user  (workClockArea_harMatch_io_signalIn_payload_axis_user         ), //i
    .io_signalIn_payload_lastPiece  (workClockArea_ddr3AxisTxIf_io_signalRd_payload_lastPiece     ), //i
    .io_signalOut_valid             (workClockArea_harMatch_io_signalOut_valid                    ), //o
    .io_signalOut_ready             (io_signalOut_translated_ready                                ), //i
    .io_signalOut_payload_axis_data (workClockArea_harMatch_io_signalOut_payload_axis_data[7:0]   ), //o
    .io_signalOut_payload_axis_last (workClockArea_harMatch_io_signalOut_payload_axis_last        ), //o
    .io_signalOut_payload_axis_user (workClockArea_harMatch_io_signalOut_payload_axis_user        ), //o
    .io_signalOut_payload_lastPiece (workClockArea_harMatch_io_signalOut_payload_lastPiece        ), //o
    .clk_out1                       (pll_clk_1_clk_out1                                           ), //i
    .rstN                           (rstN                                                         )  //i
  );
  AxisTxRateCtrl workClockArea_axisTxRateCtrl (
    .io_txCtrl_valid        (workClockArea_axisTxRateCtrl_io_txCtrl_valid             ), //o
    .io_txCtrl_ready        (workClockArea_ddr3AxisTxIf_io_txCtrl_ready               ), //i
    .io_axiIn_valid         (workClockArea_ethMacTx_port_eth_tx_axis_valid            ), //i
    .io_axiIn_ready         (workClockArea_axisTxRateCtrl_io_axiIn_ready              ), //o
    .io_axiIn_payload_data  (workClockArea_ethMacTx_port_eth_tx_axis_payload_data[7:0]), //i
    .io_axiIn_payload_last  (workClockArea_ethMacTx_port_eth_tx_axis_payload_last     ), //i
    .io_axiIn_payload_user  (workClockArea_axisTxRateCtrl_io_axiIn_payload_user       ), //i
    .io_axiOut_valid        (workClockArea_axisTxRateCtrl_io_axiOut_valid             ), //o
    .io_axiOut_ready        (io_axiOut_translated_ready                               ), //i
    .io_axiOut_payload_data (workClockArea_axisTxRateCtrl_io_axiOut_payload_data[7:0] ), //o
    .io_axiOut_payload_last (workClockArea_axisTxRateCtrl_io_axiOut_payload_last      ), //o
    .io_axiOut_payload_user (workClockArea_axisTxRateCtrl_io_axiOut_payload_user      ), //o
    .io_config_valid        (workClockArea_axisTxRateCtrl_io_config_valid             ), //o
    .io_config_ready        (io_config_translated_ready                               ), //i
    .io_cfgStart            (workClockArea_axisTxRateCtrl_io_cfgStart                 ), //o
    .io_start               (workClockArea_ddr3AxisTxIf_io_writeEnd_valid             ), //i
    .io_rxEnd               (workClockArea_harMatch_io_signalOut_payload_lastPiece    ), //i
    .io_txEnd               (workClockArea_axisTxRateCtrl_io_txEnd                    ), //o
    .clk_out1               (pll_clk_1_clk_out1                                       ), //i
    .rstN                   (rstN                                                     )  //i
  );
  ofdm_tx workClockArea_ofdmTx (
    .clk_125m             (pll_clk_1_clk_out1                      ), //i
    .clk_20m              (pll_clk_1_clk_out6                      ), //i
    .locked               (rstN                                    ), //i
    .mcu_config_din_vld   (io_config_translated_valid              ), //i
    .mcu_config_dout_rdy  (workClockArea_ofdmTx_mcu_config_dout_rdy), //o
    .mcu_config_din       (io_config_translated_payload[20:0]      ), //i
    .mcu_config_din_start (workClockArea_axisTxRateCtrl_io_cfgStart), //i
    .mcu_mac_din_vld      (io_axiOut_translated_valid              ), //i
    .mcu_mac_dout_rdy     (workClockArea_ofdmTx_mcu_mac_dout_rdy   ), //o
    .mcu_mac_din          (io_axiOut_translated_payload[7:0]       ), //i
    .dac_dout_vld         (workClockArea_ofdmTx_dac_dout_vld       ), //o
    .dac_din_rdy          (1'b1                                    ), //i
    .dac_dout_last        (workClockArea_ofdmTx_dac_dout_last      ), //o
    .dac_dout             (workClockArea_ofdmTx_dac_dout[15:0]     ), //o
    .dac_dout_Index       (workClockArea_ofdmTx_dac_dout_Index[8:0]), //o
    .tx_end               (workClockArea_axisTxRateCtrl_io_txEnd   )  //i
  );
  assign rstN = (sys_rst_n && pll_clk_1_locked);
  assign dacClk = pll_clk_1_clk_out6;
  assign dacWrt = pll_clk_1_clk_out6;
  assign rgmii_txc = workClockArea_ethMacRx_rgmii_txc;
  assign rgmii_txd = workClockArea_ethMacRx_rgmii_txd;
  assign rgmii_tx_ctl = workClockArea_ethMacRx_rgmii_tx_ctl;
  assign rgmii_rst_n = workClockArea_ethMacRx_rgmii_rst_n;
  assign workClockArea_configRx_io_udpAxisIn_payload_user[0 : 0] = workClockArea_ethMacRx_port_udp_rx_axis_payload_user[0 : 0];
  always @(*) begin
    workClockArea_ethMacRx_port_udp_rx_hdr_ready = port_udp_rx_hdr_m2sPipe_ready;
    if(when_Stream_l393) begin
      workClockArea_ethMacRx_port_udp_rx_hdr_ready = 1'b1;
    end
  end

  assign when_Stream_l393 = (! port_udp_rx_hdr_m2sPipe_valid);
  assign port_udp_rx_hdr_m2sPipe_valid = port_udp_rx_hdr_rValid;
  assign port_udp_rx_hdr_m2sPipe_ready = workClockArea_configRx_io_rxHdr_ready;
  assign workClockArea_ddr3AxisTxIf_io_axisWr_payload_user[0 : 0] = workClockArea_configRx_io_udpAxisOut_payload_user[0 : 0];
  assign ddr3_ckP = workClockArea_ddr3AxisTxIf_io_ddr3_ckP;
  assign ddr3_ckN = workClockArea_ddr3AxisTxIf_io_ddr3_ckN;
  assign ddr3_cke = workClockArea_ddr3AxisTxIf_io_ddr3_cke;
  assign ddr3_resetN = workClockArea_ddr3AxisTxIf_io_ddr3_resetN;
  assign ddr3_rasN = workClockArea_ddr3AxisTxIf_io_ddr3_rasN;
  assign ddr3_casN = workClockArea_ddr3AxisTxIf_io_ddr3_casN;
  assign ddr3_weN = workClockArea_ddr3AxisTxIf_io_ddr3_weN;
  assign ddr3_csN = workClockArea_ddr3AxisTxIf_io_ddr3_csN;
  assign ddr3_ba = workClockArea_ddr3AxisTxIf_io_ddr3_ba;
  assign ddr3_addr = workClockArea_ddr3AxisTxIf_io_ddr3_addr;
  assign ddr3_odt = workClockArea_ddr3AxisTxIf_io_ddr3_odt;
  assign ddr3_dm = workClockArea_ddr3AxisTxIf_io_ddr3_dm;
  assign workClockArea_harMatch_io_signalIn_payload_axis_user[0 : 0] = workClockArea_ddr3AxisTxIf_io_signalRd_payload_axis_user[0 : 0];
  assign io_signalOut_translated_valid = workClockArea_harMatch_io_signalOut_valid;
  assign io_signalOut_translated_payload_data = workClockArea_harMatch_io_signalOut_payload_axis_data;
  assign io_signalOut_translated_payload_last = workClockArea_harMatch_io_signalOut_payload_axis_last;
  assign io_signalOut_translated_payload_user[0 : 0] = workClockArea_harMatch_io_signalOut_payload_axis_user[0 : 0];
  assign io_signalOut_translated_ready = workClockArea_ethMacTx_port_udp_tx_axis_ready;
  assign workClockArea_ethMacTx_port_udp_tx_axis_payload_user[0 : 0] = io_signalOut_translated_payload_user[0 : 0];
  assign workClockArea_axisTxRateCtrl_io_axiIn_payload_user[0 : 0] = workClockArea_ethMacTx_port_eth_tx_axis_payload_user[0 : 0];
  assign io_axiOut_translated_valid = workClockArea_axisTxRateCtrl_io_axiOut_valid;
  assign io_axiOut_translated_payload = workClockArea_axisTxRateCtrl_io_axiOut_payload_data;
  assign io_axiOut_translated_ready = workClockArea_ofdmTx_mcu_mac_dout_rdy;
  assign io_config_translated_valid = workClockArea_axisTxRateCtrl_io_config_valid;
  assign io_config_translated_payload = workClockArea_configRx_io_config;
  assign io_config_translated_ready = workClockArea_ofdmTx_mcu_config_dout_rdy;
  assign dacData = workClockArea_ofdmTx_dac_dout;
  always @(posedge pll_clk_1_clk_out1 or negedge rstN) begin
    if(!rstN) begin
      port_udp_rx_hdr_rValid <= 1'b0;
    end else begin
      if(workClockArea_ethMacRx_port_udp_rx_hdr_ready) begin
        port_udp_rx_hdr_rValid <= workClockArea_ethMacRx_port_udp_rx_hdr_valid;
      end
    end
  end


endmodule
