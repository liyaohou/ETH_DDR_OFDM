// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : RxTop
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module RxTop (
  input  wire          sys_rst_n,
  input  wire          sys_clk,
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
  input  wire [15:0]   adcData,
  output wire          adcClk
);

  wire       [0:0]    workClockArea_axisRxRateCtrl_io_axiIn_payload_user;
  wire       [0:0]    workClockArea_harMatchEth_io_signalIn_payload_axis_user;
  reg                 workClockArea_ethMacRx_port_udp_rx_hdr_ready;
  wire       [0:0]    workClockArea_ethMacRx_port_eth_rx_axis_payload_user;
  wire       [0:0]    workClockArea_ddr3AxisTxIf_io_axisWr_payload_user;
  wire                workClockArea_ddr3AxisTxIf_io_writeEnd_ready;
  wire       [0:0]    workClockArea_axisTxEth_io_axiIn_payload_user;
  wire       [0:0]    workClockArea_harMatch_io_axiIn_payload_user;
  wire       [0:0]    workClockArea_ethMacTx_port_udp_tx_axis_payload_user;
  wire                pll_clk_1_locked;
  wire                pll_clk_1_clk_out1;
  wire                pll_clk_1_clk_out2;
  wire                pll_clk_1_clk_out3;
  wire                pll_clk_1_clk_out4;
  wire                pll_clk_1_clk_out5;
  wire                pll_clk_1_clk_out6;
  wire                workClockArea_ofdm_rx_io_axisOut_valid;
  wire       [7:0]    workClockArea_ofdm_rx_io_axisOut_payload_data;
  wire                workClockArea_ofdm_rx_io_axisOut_payload_last;
  wire       [0:0]    workClockArea_ofdm_rx_io_axisOut_payload_user;
  wire                workClockArea_axisRxRateCtrl_io_axiIn_ready;
  wire                workClockArea_axisRxRateCtrl_io_signalOut_valid;
  wire       [7:0]    workClockArea_axisRxRateCtrl_io_signalOut_payload_axis_data;
  wire                workClockArea_axisRxRateCtrl_io_signalOut_payload_axis_last;
  wire       [0:0]    workClockArea_axisRxRateCtrl_io_signalOut_payload_axis_user;
  wire                workClockArea_axisRxRateCtrl_io_signalOut_payload_lastPiece;
  wire                workClockArea_axisRxRateCtrl_io_rxEnd_valid;
  wire                workClockArea_harMatchEth_io_hdr_valid;
  wire                workClockArea_harMatchEth_io_signalIn_ready;
  wire                workClockArea_harMatchEth_io_signalOut_valid;
  wire       [7:0]    workClockArea_harMatchEth_io_signalOut_payload_axis_data;
  wire                workClockArea_harMatchEth_io_signalOut_payload_axis_last;
  wire       [0:0]    workClockArea_harMatchEth_io_signalOut_payload_axis_user;
  wire                workClockArea_harMatchEth_io_signalOut_payload_lastPiece;
  wire                workClockArea_ethMacRx_port_udp_rx_hdr_valid;
  wire                workClockArea_ethMacRx_port_udp_rx_axis_valid;
  wire       [7:0]    workClockArea_ethMacRx_port_udp_rx_axis_payload_data;
  wire                workClockArea_ethMacRx_port_udp_rx_axis_payload_last;
  wire       [0:0]    workClockArea_ethMacRx_port_udp_rx_axis_payload_user;
  wire       [9:0]    workClockArea_ethMacRx_port_udp_rx_length;
  wire       [31:0]   workClockArea_ethMacRx_port_udp_rx_source_ip;
  wire                workClockArea_ethMacRx_port_eth_rx_hdr_ready;
  wire                workClockArea_ethMacRx_port_eth_rx_axis_ready;
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
  wire                workClockArea_axisTxEth_io_txCtrl_valid;
  wire                workClockArea_axisTxEth_io_axiIn_ready;
  wire                workClockArea_axisTxEth_io_axiOut_valid;
  wire       [7:0]    workClockArea_axisTxEth_io_axiOut_payload_data;
  wire                workClockArea_axisTxEth_io_axiOut_payload_last;
  wire       [0:0]    workClockArea_axisTxEth_io_axiOut_payload_user;
  wire                workClockArea_axisTxEth_io_txEnd;
  wire                workClockArea_harMatch_io_hdr_valid;
  wire                workClockArea_harMatch_io_axiIn_ready;
  wire                workClockArea_harMatch_io_axiOut_valid;
  wire       [7:0]    workClockArea_harMatch_io_axiOut_payload_data;
  wire                workClockArea_harMatch_io_axiOut_payload_last;
  wire       [0:0]    workClockArea_harMatch_io_axiOut_payload_user;
  wire                workClockArea_ethMacTx_rgmii_txc;
  wire       [3:0]    workClockArea_ethMacTx_rgmii_txd;
  wire                workClockArea_ethMacTx_rgmii_tx_ctl;
  wire                workClockArea_ethMacTx_rgmii_rst_n;
  wire                workClockArea_ethMacTx_port_udp_tx_hdr_ready;
  wire                workClockArea_ethMacTx_port_udp_tx_axis_ready;
  wire                rstN;
  wire                io_signalOut_translated_valid;
  wire                io_signalOut_translated_ready;
  wire       [7:0]    io_signalOut_translated_payload_data;
  wire                io_signalOut_translated_payload_last;
  wire       [0:0]    io_signalOut_translated_payload_user;
  wire                workClockArea_rxHdr_valid;
  wire                workClockArea_rxHdr_ready;
  reg                 port_udp_rx_hdr_rValid;
  wire                when_Stream_l393;
  wire                workClockArea_rxHdr_fire;
  reg        [9:0]    workClockArea_lengthIn;
  reg                 workClockArea_wrEnd;
  wire                port_udp_rx_axis_fire;
  wire                io_signalRd_translated_valid;
  wire                io_signalRd_translated_ready;
  wire       [7:0]    io_signalRd_translated_payload_data;
  wire                io_signalRd_translated_payload_last;
  wire       [0:0]    io_signalRd_translated_payload_user;

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
  OFDMRX workClockArea_ofdm_rx (
    .io_adcData              (adcData[15:0]                                     ), //i
    .io_axisOut_valid        (workClockArea_ofdm_rx_io_axisOut_valid            ), //o
    .io_axisOut_ready        (workClockArea_axisRxRateCtrl_io_axiIn_ready       ), //i
    .io_axisOut_payload_data (workClockArea_ofdm_rx_io_axisOut_payload_data[7:0]), //o
    .io_axisOut_payload_last (workClockArea_ofdm_rx_io_axisOut_payload_last     ), //o
    .io_axisOut_payload_user (workClockArea_ofdm_rx_io_axisOut_payload_user     ), //o
    .rstN                    (rstN                                              ), //i
    .clk_out6                (pll_clk_1_clk_out6                                ), //i
    .clk_out1                (pll_clk_1_clk_out1                                )  //i
  );
  AxisRxRateCtrl workClockArea_axisRxRateCtrl (
    .io_axiIn_valid                 (workClockArea_ofdm_rx_io_axisOut_valid                          ), //i
    .io_axiIn_ready                 (workClockArea_axisRxRateCtrl_io_axiIn_ready                     ), //o
    .io_axiIn_payload_data          (workClockArea_ofdm_rx_io_axisOut_payload_data[7:0]              ), //i
    .io_axiIn_payload_last          (workClockArea_ofdm_rx_io_axisOut_payload_last                   ), //i
    .io_axiIn_payload_user          (workClockArea_axisRxRateCtrl_io_axiIn_payload_user              ), //i
    .io_signalOut_valid             (workClockArea_axisRxRateCtrl_io_signalOut_valid                 ), //o
    .io_signalOut_ready             (workClockArea_harMatchEth_io_signalIn_ready                     ), //i
    .io_signalOut_payload_axis_data (workClockArea_axisRxRateCtrl_io_signalOut_payload_axis_data[7:0]), //o
    .io_signalOut_payload_axis_last (workClockArea_axisRxRateCtrl_io_signalOut_payload_axis_last     ), //o
    .io_signalOut_payload_axis_user (workClockArea_axisRxRateCtrl_io_signalOut_payload_axis_user     ), //o
    .io_signalOut_payload_lastPiece (workClockArea_axisRxRateCtrl_io_signalOut_payload_lastPiece     ), //o
    .io_rxEnd_valid                 (workClockArea_axisRxRateCtrl_io_rxEnd_valid                     ), //o
    .io_rxEnd_ready                 (workClockArea_ofdm_rx_io_axisOut_payload_last                   ), //i
    .clk_out1                       (pll_clk_1_clk_out1                                              ), //i
    .rstN                           (rstN                                                            )  //i
  );
  HarMatch workClockArea_harMatchEth (
    .io_hdr_valid                   (workClockArea_harMatchEth_io_hdr_valid                          ), //o
    .io_hdr_ready                   (workClockArea_ethMacRx_port_eth_rx_hdr_ready                    ), //i
    .io_signalIn_valid              (workClockArea_axisRxRateCtrl_io_signalOut_valid                 ), //i
    .io_signalIn_ready              (workClockArea_harMatchEth_io_signalIn_ready                     ), //o
    .io_signalIn_payload_axis_data  (workClockArea_axisRxRateCtrl_io_signalOut_payload_axis_data[7:0]), //i
    .io_signalIn_payload_axis_last  (workClockArea_axisRxRateCtrl_io_signalOut_payload_axis_last     ), //i
    .io_signalIn_payload_axis_user  (workClockArea_harMatchEth_io_signalIn_payload_axis_user         ), //i
    .io_signalIn_payload_lastPiece  (workClockArea_axisRxRateCtrl_io_signalOut_payload_lastPiece     ), //i
    .io_signalOut_valid             (workClockArea_harMatchEth_io_signalOut_valid                    ), //o
    .io_signalOut_ready             (io_signalOut_translated_ready                                   ), //i
    .io_signalOut_payload_axis_data (workClockArea_harMatchEth_io_signalOut_payload_axis_data[7:0]   ), //o
    .io_signalOut_payload_axis_last (workClockArea_harMatchEth_io_signalOut_payload_axis_last        ), //o
    .io_signalOut_payload_axis_user (workClockArea_harMatchEth_io_signalOut_payload_axis_user        ), //o
    .io_signalOut_payload_lastPiece (workClockArea_harMatchEth_io_signalOut_payload_lastPiece        ), //o
    .clk_out1                       (pll_clk_1_clk_out1                                              ), //i
    .rstN                           (rstN                                                            )  //i
  );
  eth_mac_rx_r workClockArea_ethMacRx (
    .logic_clk                     (pll_clk_1_clk_out1                                       ), //i
    .gtx_clk                       (pll_clk_1_clk_out5                                       ), //i
    .gtx_clk90                     (pll_clk_1_clk_out1                                       ), //i
    .rst_n                         (rstN                                                     ), //i
    .port_udp_rx_hdr_valid         (workClockArea_ethMacRx_port_udp_rx_hdr_valid             ), //o
    .port_udp_rx_hdr_ready         (workClockArea_ethMacRx_port_udp_rx_hdr_ready             ), //i
    .port_udp_rx_axis_valid        (workClockArea_ethMacRx_port_udp_rx_axis_valid            ), //o
    .port_udp_rx_axis_ready        (workClockArea_ddr3AxisTxIf_io_axisWr_ready               ), //i
    .port_udp_rx_axis_payload_data (workClockArea_ethMacRx_port_udp_rx_axis_payload_data[7:0]), //o
    .port_udp_rx_axis_payload_last (workClockArea_ethMacRx_port_udp_rx_axis_payload_last     ), //o
    .port_udp_rx_axis_payload_user (workClockArea_ethMacRx_port_udp_rx_axis_payload_user     ), //o
    .port_udp_rx_length            (workClockArea_ethMacRx_port_udp_rx_length[9:0]           ), //o
    .port_udp_rx_source_ip         (workClockArea_ethMacRx_port_udp_rx_source_ip[31:0]       ), //o
    .port_eth_rx_hdr_valid         (workClockArea_harMatchEth_io_hdr_valid                   ), //i
    .port_eth_rx_hdr_ready         (workClockArea_ethMacRx_port_eth_rx_hdr_ready             ), //o
    .port_eth_rx_axis_valid        (io_signalOut_translated_valid                            ), //i
    .port_eth_rx_axis_ready        (workClockArea_ethMacRx_port_eth_rx_axis_ready            ), //o
    .port_eth_rx_axis_payload_data (io_signalOut_translated_payload_data[7:0]                ), //i
    .port_eth_rx_axis_payload_last (io_signalOut_translated_payload_last                     ), //i
    .port_eth_rx_axis_payload_user (workClockArea_ethMacRx_port_eth_rx_axis_payload_user     )  //i
  );
  Ddr3AxisTxInterface workClockArea_ddr3AxisTxIf (
    .work_clk                      (pll_clk_1_clk_out4                                           ), //i
    .ddr_clk                       (pll_clk_1_clk_out1                                           ), //i
    .ddr90_clk                     (pll_clk_1_clk_out2                                           ), //i
    .ref_clk                       (pll_clk_1_clk_out3                                           ), //i
    .io_axisWr_valid               (workClockArea_ethMacRx_port_udp_rx_axis_valid                ), //i
    .io_axisWr_ready               (workClockArea_ddr3AxisTxIf_io_axisWr_ready                   ), //o
    .io_axisWr_payload_data        (workClockArea_ethMacRx_port_udp_rx_axis_payload_data[7:0]    ), //i
    .io_axisWr_payload_last        (workClockArea_ethMacRx_port_udp_rx_axis_payload_last         ), //i
    .io_axisWr_payload_user        (workClockArea_ddr3AxisTxIf_io_axisWr_payload_user            ), //i
    .io_lengthIn                   (workClockArea_lengthIn[9:0]                                  ), //i
    .io_lengthOut                  (workClockArea_ddr3AxisTxIf_io_lengthOut[9:0]                 ), //o
    .io_signalRd_valid             (workClockArea_ddr3AxisTxIf_io_signalRd_valid                 ), //o
    .io_signalRd_ready             (io_signalRd_translated_ready                                 ), //i
    .io_signalRd_payload_axis_data (workClockArea_ddr3AxisTxIf_io_signalRd_payload_axis_data[7:0]), //o
    .io_signalRd_payload_axis_last (workClockArea_ddr3AxisTxIf_io_signalRd_payload_axis_last     ), //o
    .io_signalRd_payload_axis_user (workClockArea_ddr3AxisTxIf_io_signalRd_payload_axis_user     ), //o
    .io_signalRd_payload_lastPiece (workClockArea_ddr3AxisTxIf_io_signalRd_payload_lastPiece     ), //o
    .io_txCtrl_valid               (workClockArea_axisTxEth_io_txCtrl_valid                      ), //i
    .io_txCtrl_ready               (workClockArea_ddr3AxisTxIf_io_txCtrl_ready                   ), //o
    .io_writeEnd_valid             (workClockArea_ddr3AxisTxIf_io_writeEnd_valid                 ), //o
    .io_writeEnd_ready             (workClockArea_ddr3AxisTxIf_io_writeEnd_ready                 ), //i
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
  AxisTxEth workClockArea_axisTxEth (
    .io_txCtrl_valid        (workClockArea_axisTxEth_io_txCtrl_valid                 ), //o
    .io_txCtrl_ready        (workClockArea_ddr3AxisTxIf_io_txCtrl_ready              ), //i
    .io_axiIn_valid         (io_signalRd_translated_valid                            ), //i
    .io_axiIn_ready         (workClockArea_axisTxEth_io_axiIn_ready                  ), //o
    .io_axiIn_payload_data  (io_signalRd_translated_payload_data[7:0]                ), //i
    .io_axiIn_payload_last  (io_signalRd_translated_payload_last                     ), //i
    .io_axiIn_payload_user  (workClockArea_axisTxEth_io_axiIn_payload_user           ), //i
    .io_axiOut_valid        (workClockArea_axisTxEth_io_axiOut_valid                 ), //o
    .io_axiOut_ready        (workClockArea_harMatch_io_axiIn_ready                   ), //i
    .io_axiOut_payload_data (workClockArea_axisTxEth_io_axiOut_payload_data[7:0]     ), //o
    .io_axiOut_payload_last (workClockArea_axisTxEth_io_axiOut_payload_last          ), //o
    .io_axiOut_payload_user (workClockArea_axisTxEth_io_axiOut_payload_user          ), //o
    .io_start               (workClockArea_ddr3AxisTxIf_io_writeEnd_valid            ), //i
    .io_rxEnd               (workClockArea_ddr3AxisTxIf_io_signalRd_payload_lastPiece), //i
    .io_txEnd               (workClockArea_axisTxEth_io_txEnd                        ), //o
    .clk_out1               (pll_clk_1_clk_out1                                      ), //i
    .rstN                   (rstN                                                    )  //i
  );
  AxisHarMatch workClockArea_harMatch (
    .io_hdr_valid           (workClockArea_harMatch_io_hdr_valid                ), //o
    .io_hdr_ready           (workClockArea_ethMacTx_port_udp_tx_hdr_ready       ), //i
    .io_axiIn_valid         (workClockArea_axisTxEth_io_axiOut_valid            ), //i
    .io_axiIn_ready         (workClockArea_harMatch_io_axiIn_ready              ), //o
    .io_axiIn_payload_data  (workClockArea_axisTxEth_io_axiOut_payload_data[7:0]), //i
    .io_axiIn_payload_last  (workClockArea_axisTxEth_io_axiOut_payload_last     ), //i
    .io_axiIn_payload_user  (workClockArea_harMatch_io_axiIn_payload_user       ), //i
    .io_axiOut_valid        (workClockArea_harMatch_io_axiOut_valid             ), //o
    .io_axiOut_ready        (workClockArea_ethMacTx_port_udp_tx_axis_ready      ), //i
    .io_axiOut_payload_data (workClockArea_harMatch_io_axiOut_payload_data[7:0] ), //o
    .io_axiOut_payload_last (workClockArea_harMatch_io_axiOut_payload_last      ), //o
    .io_axiOut_payload_user (workClockArea_harMatch_io_axiOut_payload_user      ), //o
    .clk_out1               (pll_clk_1_clk_out1                                 ), //i
    .rstN                   (rstN                                               )  //i
  );
  eth_mac_rx_t workClockArea_ethMacTx (
    .logic_clk                     (pll_clk_1_clk_out1                                  ), //i
    .gtx_clk                       (pll_clk_1_clk_out5                                  ), //i
    .gtx_clk90                     (pll_clk_1_clk_out1                                  ), //i
    .rst_n                         (rstN                                                ), //i
    .rgmii_rxc                     (rgmii_rxc                                           ), //i
    .rgmii_rxd                     (rgmii_rxd[3:0]                                      ), //i
    .rgmii_rx_ctl                  (rgmii_rx_ctl                                        ), //i
    .rgmii_txc                     (workClockArea_ethMacTx_rgmii_txc                    ), //o
    .rgmii_txd                     (workClockArea_ethMacTx_rgmii_txd[3:0]               ), //o
    .rgmii_tx_ctl                  (workClockArea_ethMacTx_rgmii_tx_ctl                 ), //o
    .rgmii_rst_n                   (workClockArea_ethMacTx_rgmii_rst_n                  ), //o
    .port_udp_tx_hdr_valid         (workClockArea_harMatch_io_hdr_valid                 ), //i
    .port_udp_tx_hdr_ready         (workClockArea_ethMacTx_port_udp_tx_hdr_ready        ), //o
    .port_udp_tx_axis_valid        (workClockArea_harMatch_io_axiOut_valid              ), //i
    .port_udp_tx_axis_ready        (workClockArea_ethMacTx_port_udp_tx_axis_ready       ), //o
    .port_udp_tx_axis_payload_data (workClockArea_harMatch_io_axiOut_payload_data[7:0]  ), //i
    .port_udp_tx_axis_payload_last (workClockArea_harMatch_io_axiOut_payload_last       ), //i
    .port_udp_tx_axis_payload_user (workClockArea_ethMacTx_port_udp_tx_axis_payload_user), //i
    .port_udp_tx_length            (workClockArea_ddr3AxisTxIf_io_lengthOut[9:0]        ), //i
    .port_udp_tx_dest_ip           (32'hc0a80141                                        )  //i
  );
  assign rstN = (sys_rst_n && pll_clk_1_locked);
  assign adcClk = pll_clk_1_clk_out6;
  assign workClockArea_axisRxRateCtrl_io_axiIn_payload_user[0 : 0] = workClockArea_ofdm_rx_io_axisOut_payload_user[0 : 0];
  assign workClockArea_harMatchEth_io_signalIn_payload_axis_user[0 : 0] = workClockArea_axisRxRateCtrl_io_signalOut_payload_axis_user[0 : 0];
  assign io_signalOut_translated_valid = workClockArea_harMatchEth_io_signalOut_valid;
  assign io_signalOut_translated_payload_data = workClockArea_harMatchEth_io_signalOut_payload_axis_data;
  assign io_signalOut_translated_payload_last = workClockArea_harMatchEth_io_signalOut_payload_axis_last;
  assign io_signalOut_translated_payload_user[0 : 0] = workClockArea_harMatchEth_io_signalOut_payload_axis_user[0 : 0];
  assign io_signalOut_translated_ready = workClockArea_ethMacRx_port_eth_rx_axis_ready;
  assign workClockArea_ethMacRx_port_eth_rx_axis_payload_user[0 : 0] = io_signalOut_translated_payload_user[0 : 0];
  always @(*) begin
    workClockArea_ethMacRx_port_udp_rx_hdr_ready = workClockArea_rxHdr_ready;
    if(when_Stream_l393) begin
      workClockArea_ethMacRx_port_udp_rx_hdr_ready = 1'b1;
    end
  end

  assign when_Stream_l393 = (! workClockArea_rxHdr_valid);
  assign workClockArea_rxHdr_valid = port_udp_rx_hdr_rValid;
  assign workClockArea_rxHdr_fire = (workClockArea_rxHdr_valid && workClockArea_rxHdr_ready);
  assign workClockArea_rxHdr_ready = 1'b1;
  assign workClockArea_ddr3AxisTxIf_io_axisWr_payload_user[0 : 0] = workClockArea_ethMacRx_port_udp_rx_axis_payload_user[0 : 0];
  assign port_udp_rx_axis_fire = (workClockArea_ethMacRx_port_udp_rx_axis_valid && workClockArea_ddr3AxisTxIf_io_axisWr_ready);
  assign workClockArea_ddr3AxisTxIf_io_writeEnd_ready = (workClockArea_wrEnd && (workClockArea_ethMacRx_port_udp_rx_axis_payload_last && port_udp_rx_axis_fire));
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
  assign io_signalRd_translated_valid = workClockArea_ddr3AxisTxIf_io_signalRd_valid;
  assign io_signalRd_translated_payload_data = workClockArea_ddr3AxisTxIf_io_signalRd_payload_axis_data;
  assign io_signalRd_translated_payload_last = workClockArea_ddr3AxisTxIf_io_signalRd_payload_axis_last;
  assign io_signalRd_translated_payload_user[0 : 0] = workClockArea_ddr3AxisTxIf_io_signalRd_payload_axis_user[0 : 0];
  assign io_signalRd_translated_ready = workClockArea_axisTxEth_io_axiIn_ready;
  assign workClockArea_axisTxEth_io_axiIn_payload_user[0 : 0] = io_signalRd_translated_payload_user[0 : 0];
  assign workClockArea_harMatch_io_axiIn_payload_user[0 : 0] = workClockArea_axisTxEth_io_axiOut_payload_user[0 : 0];
  assign workClockArea_ethMacTx_port_udp_tx_axis_payload_user[0 : 0] = workClockArea_harMatch_io_axiOut_payload_user[0 : 0];
  assign rgmii_txc = workClockArea_ethMacTx_rgmii_txc;
  assign rgmii_txd = workClockArea_ethMacTx_rgmii_txd;
  assign rgmii_tx_ctl = workClockArea_ethMacTx_rgmii_tx_ctl;
  assign rgmii_rst_n = workClockArea_ethMacTx_rgmii_rst_n;
  always @(posedge pll_clk_1_clk_out1 or negedge rstN) begin
    if(!rstN) begin
      port_udp_rx_hdr_rValid <= 1'b0;
      workClockArea_wrEnd <= 1'b0;
    end else begin
      if(workClockArea_ethMacRx_port_udp_rx_hdr_ready) begin
        port_udp_rx_hdr_rValid <= workClockArea_ethMacRx_port_udp_rx_hdr_valid;
      end
      if(workClockArea_harMatchEth_io_signalOut_payload_lastPiece) begin
        workClockArea_wrEnd <= 1'b1;
      end
      if(workClockArea_ddr3AxisTxIf_io_writeEnd_valid) begin
        workClockArea_wrEnd <= 1'b0;
      end
    end
  end

  always @(posedge pll_clk_1_clk_out1) begin
    if(workClockArea_rxHdr_fire) begin
      workClockArea_lengthIn <= workClockArea_ethMacRx_port_udp_rx_length;
    end
  end


endmodule
