// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : Ddr3AxisTxInterface
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module Ddr3AxisTxInterface (
  input  wire          work_clk,
  input  wire          ddr_clk,
  input  wire          ddr90_clk,
  input  wire          ref_clk,
  input  wire          io_axisWr_valid,
  output wire          io_axisWr_ready,
  input  wire [7:0]    io_axisWr_payload_data,
  input  wire          io_axisWr_payload_last,
  input  wire [0:0]    io_axisWr_payload_user,
  input  wire [9:0]    io_lengthIn,
  output wire [9:0]    io_lengthOut,
  output wire          io_signalRd_valid,
  input  wire          io_signalRd_ready,
  output wire [7:0]    io_signalRd_payload_axis_data,
  output wire          io_signalRd_payload_axis_last,
  output wire [0:0]    io_signalRd_payload_axis_user,
  output wire          io_signalRd_payload_lastPiece,
  input  wire          io_txCtrl_valid,
  output wire          io_txCtrl_ready,
  output wire          io_writeEnd_valid,
  input  wire          io_writeEnd_ready,
  output wire          io_ddr3InitDone,
  output wire [0:0]    io_ddr3_ckP,
  output wire [0:0]    io_ddr3_ckN,
  output wire [0:0]    io_ddr3_cke,
  output wire [0:0]    io_ddr3_resetN,
  output wire [0:0]    io_ddr3_rasN,
  output wire [0:0]    io_ddr3_casN,
  output wire [0:0]    io_ddr3_weN,
  output wire [0:0]    io_ddr3_csN,
  output wire [2:0]    io_ddr3_ba,
  output wire [14:0]   io_ddr3_addr,
  output wire [0:0]    io_ddr3_odt,
  output wire [1:0]    io_ddr3_dm,
  inout  wire [1:0]    io_ddr3_dqsP,
  inout  wire [1:0]    io_ddr3_dqsN,
  inout  wire [15:0]   io_ddr3_dq,
  input  wire          clk_out4,
  input  wire          rstN,
  input  wire          clk_out1
);

  wire       [0:0]    axi4StreamToBmb_1_io_axiIn_payload_user;
  wire                axi4StreamToBmb_1_io_axiIn_ready;
  wire                axi4StreamToBmb_1_io_signalOut_valid;
  wire       [7:0]    axi4StreamToBmb_1_io_signalOut_payload_axis_data;
  wire                axi4StreamToBmb_1_io_signalOut_payload_axis_last;
  wire       [0:0]    axi4StreamToBmb_1_io_signalOut_payload_axis_user;
  wire                axi4StreamToBmb_1_io_signalOut_payload_lastPiece;
  wire                axi4StreamToBmb_1_io_rdCtr_ready;
  wire                axi4StreamToBmb_1_io_writeEnd_valid;
  wire                axi4StreamToBmb_1_io_bmb_cmd_valid;
  wire                axi4StreamToBmb_1_io_bmb_cmd_payload_last;
  wire       [0:0]    axi4StreamToBmb_1_io_bmb_cmd_payload_fragment_opcode;
  wire       [28:0]   axi4StreamToBmb_1_io_bmb_cmd_payload_fragment_address;
  wire       [9:0]    axi4StreamToBmb_1_io_bmb_cmd_payload_fragment_length;
  wire       [31:0]   axi4StreamToBmb_1_io_bmb_cmd_payload_fragment_data;
  wire       [3:0]    axi4StreamToBmb_1_io_bmb_cmd_payload_fragment_mask;
  wire       [3:0]    axi4StreamToBmb_1_io_bmb_cmd_payload_fragment_context;
  wire                axi4StreamToBmb_1_io_bmb_rsp_ready;
  wire                axi4StreamToBmb_1_io_error;
  wire       [9:0]    axi4StreamToBmb_1_io_lengthOut;
  wire                axi4StreamToBmb_1_readEnd;
  wire                bmbClockArea_bmbDfiDdr3_io_bmb_cmd_ready;
  wire                bmbClockArea_bmbDfiDdr3_io_bmb_rsp_valid;
  wire                bmbClockArea_bmbDfiDdr3_io_bmb_rsp_payload_last;
  wire       [0:0]    bmbClockArea_bmbDfiDdr3_io_bmb_rsp_payload_fragment_opcode;
  wire       [31:0]   bmbClockArea_bmbDfiDdr3_io_bmb_rsp_payload_fragment_data;
  wire       [3:0]    bmbClockArea_bmbDfiDdr3_io_bmb_rsp_payload_fragment_context;
  wire       [0:0]    bmbClockArea_bmbDfiDdr3_io_ddr3_ckP;
  wire       [0:0]    bmbClockArea_bmbDfiDdr3_io_ddr3_ckN;
  wire       [0:0]    bmbClockArea_bmbDfiDdr3_io_ddr3_cke;
  wire       [0:0]    bmbClockArea_bmbDfiDdr3_io_ddr3_resetN;
  wire       [0:0]    bmbClockArea_bmbDfiDdr3_io_ddr3_rasN;
  wire       [0:0]    bmbClockArea_bmbDfiDdr3_io_ddr3_casN;
  wire       [0:0]    bmbClockArea_bmbDfiDdr3_io_ddr3_weN;
  wire       [0:0]    bmbClockArea_bmbDfiDdr3_io_ddr3_csN;
  wire       [2:0]    bmbClockArea_bmbDfiDdr3_io_ddr3_ba;
  wire       [14:0]   bmbClockArea_bmbDfiDdr3_io_ddr3_addr;
  wire       [0:0]    bmbClockArea_bmbDfiDdr3_io_ddr3_odt;
  wire       [1:0]    bmbClockArea_bmbDfiDdr3_io_ddr3_dm;
  wire                bmbClockArea_bmbDfiDdr3_io_initDone;

  Axi4StreamToBmb axi4StreamToBmb_1 (
    .io_axiIn_valid                      (io_axisWr_valid                                                 ), //i
    .io_axiIn_ready                      (axi4StreamToBmb_1_io_axiIn_ready                                ), //o
    .io_axiIn_payload_data               (io_axisWr_payload_data[7:0]                                     ), //i
    .io_axiIn_payload_last               (io_axisWr_payload_last                                          ), //i
    .io_axiIn_payload_user               (axi4StreamToBmb_1_io_axiIn_payload_user                         ), //i
    .io_signalOut_valid                  (axi4StreamToBmb_1_io_signalOut_valid                            ), //o
    .io_signalOut_ready                  (io_signalRd_ready                                               ), //i
    .io_signalOut_payload_axis_data      (axi4StreamToBmb_1_io_signalOut_payload_axis_data[7:0]           ), //o
    .io_signalOut_payload_axis_last      (axi4StreamToBmb_1_io_signalOut_payload_axis_last                ), //o
    .io_signalOut_payload_axis_user      (axi4StreamToBmb_1_io_signalOut_payload_axis_user                ), //o
    .io_signalOut_payload_lastPiece      (axi4StreamToBmb_1_io_signalOut_payload_lastPiece                ), //o
    .io_rdCtr_valid                      (io_txCtrl_valid                                                 ), //i
    .io_rdCtr_ready                      (axi4StreamToBmb_1_io_rdCtr_ready                                ), //o
    .io_writeEnd_valid                   (axi4StreamToBmb_1_io_writeEnd_valid                             ), //o
    .io_writeEnd_ready                   (io_writeEnd_ready                                               ), //i
    .io_bmb_cmd_valid                    (axi4StreamToBmb_1_io_bmb_cmd_valid                              ), //o
    .io_bmb_cmd_ready                    (bmbClockArea_bmbDfiDdr3_io_bmb_cmd_ready                        ), //i
    .io_bmb_cmd_payload_last             (axi4StreamToBmb_1_io_bmb_cmd_payload_last                       ), //o
    .io_bmb_cmd_payload_fragment_opcode  (axi4StreamToBmb_1_io_bmb_cmd_payload_fragment_opcode            ), //o
    .io_bmb_cmd_payload_fragment_address (axi4StreamToBmb_1_io_bmb_cmd_payload_fragment_address[28:0]     ), //o
    .io_bmb_cmd_payload_fragment_length  (axi4StreamToBmb_1_io_bmb_cmd_payload_fragment_length[9:0]       ), //o
    .io_bmb_cmd_payload_fragment_data    (axi4StreamToBmb_1_io_bmb_cmd_payload_fragment_data[31:0]        ), //o
    .io_bmb_cmd_payload_fragment_mask    (axi4StreamToBmb_1_io_bmb_cmd_payload_fragment_mask[3:0]         ), //o
    .io_bmb_cmd_payload_fragment_context (axi4StreamToBmb_1_io_bmb_cmd_payload_fragment_context[3:0]      ), //o
    .io_bmb_rsp_valid                    (bmbClockArea_bmbDfiDdr3_io_bmb_rsp_valid                        ), //i
    .io_bmb_rsp_ready                    (axi4StreamToBmb_1_io_bmb_rsp_ready                              ), //o
    .io_bmb_rsp_payload_last             (bmbClockArea_bmbDfiDdr3_io_bmb_rsp_payload_last                 ), //i
    .io_bmb_rsp_payload_fragment_opcode  (bmbClockArea_bmbDfiDdr3_io_bmb_rsp_payload_fragment_opcode      ), //i
    .io_bmb_rsp_payload_fragment_data    (bmbClockArea_bmbDfiDdr3_io_bmb_rsp_payload_fragment_data[31:0]  ), //i
    .io_bmb_rsp_payload_fragment_context (bmbClockArea_bmbDfiDdr3_io_bmb_rsp_payload_fragment_context[3:0]), //i
    .io_error                            (axi4StreamToBmb_1_io_error                                      ), //o
    .io_lengthIn                         (io_lengthIn[9:0]                                                ), //i
    .io_lengthOut                        (axi4StreamToBmb_1_io_lengthOut[9:0]                             ), //o
    .readEnd                             (axi4StreamToBmb_1_readEnd                                       ), //o
    .clk_out1                            (clk_out1                                                        ), //i
    .rstN                                (rstN                                                            ), //i
    .clk_out4                            (clk_out4                                                        )  //i
  );
  BmbDfiDdr3 bmbClockArea_bmbDfiDdr3 (
    .io_clk1                             (work_clk                                                        ), //i
    .io_clk2                             (ddr_clk                                                         ), //i
    .io_clk3                             (ddr90_clk                                                       ), //i
    .io_clk4                             (ref_clk                                                         ), //i
    .io_bmb_cmd_valid                    (axi4StreamToBmb_1_io_bmb_cmd_valid                              ), //i
    .io_bmb_cmd_ready                    (bmbClockArea_bmbDfiDdr3_io_bmb_cmd_ready                        ), //o
    .io_bmb_cmd_payload_last             (axi4StreamToBmb_1_io_bmb_cmd_payload_last                       ), //i
    .io_bmb_cmd_payload_fragment_opcode  (axi4StreamToBmb_1_io_bmb_cmd_payload_fragment_opcode            ), //i
    .io_bmb_cmd_payload_fragment_address (axi4StreamToBmb_1_io_bmb_cmd_payload_fragment_address[28:0]     ), //i
    .io_bmb_cmd_payload_fragment_length  (axi4StreamToBmb_1_io_bmb_cmd_payload_fragment_length[9:0]       ), //i
    .io_bmb_cmd_payload_fragment_data    (axi4StreamToBmb_1_io_bmb_cmd_payload_fragment_data[31:0]        ), //i
    .io_bmb_cmd_payload_fragment_mask    (axi4StreamToBmb_1_io_bmb_cmd_payload_fragment_mask[3:0]         ), //i
    .io_bmb_cmd_payload_fragment_context (axi4StreamToBmb_1_io_bmb_cmd_payload_fragment_context[3:0]      ), //i
    .io_bmb_rsp_valid                    (bmbClockArea_bmbDfiDdr3_io_bmb_rsp_valid                        ), //o
    .io_bmb_rsp_ready                    (axi4StreamToBmb_1_io_bmb_rsp_ready                              ), //i
    .io_bmb_rsp_payload_last             (bmbClockArea_bmbDfiDdr3_io_bmb_rsp_payload_last                 ), //o
    .io_bmb_rsp_payload_fragment_opcode  (bmbClockArea_bmbDfiDdr3_io_bmb_rsp_payload_fragment_opcode      ), //o
    .io_bmb_rsp_payload_fragment_data    (bmbClockArea_bmbDfiDdr3_io_bmb_rsp_payload_fragment_data[31:0]  ), //o
    .io_bmb_rsp_payload_fragment_context (bmbClockArea_bmbDfiDdr3_io_bmb_rsp_payload_fragment_context[3:0]), //o
    .io_ddr3_ckP                         (bmbClockArea_bmbDfiDdr3_io_ddr3_ckP                             ), //o
    .io_ddr3_ckN                         (bmbClockArea_bmbDfiDdr3_io_ddr3_ckN                             ), //o
    .io_ddr3_cke                         (bmbClockArea_bmbDfiDdr3_io_ddr3_cke                             ), //o
    .io_ddr3_resetN                      (bmbClockArea_bmbDfiDdr3_io_ddr3_resetN                          ), //o
    .io_ddr3_rasN                        (bmbClockArea_bmbDfiDdr3_io_ddr3_rasN                            ), //o
    .io_ddr3_casN                        (bmbClockArea_bmbDfiDdr3_io_ddr3_casN                            ), //o
    .io_ddr3_weN                         (bmbClockArea_bmbDfiDdr3_io_ddr3_weN                             ), //o
    .io_ddr3_csN                         (bmbClockArea_bmbDfiDdr3_io_ddr3_csN                             ), //o
    .io_ddr3_ba                          (bmbClockArea_bmbDfiDdr3_io_ddr3_ba[2:0]                         ), //o
    .io_ddr3_addr                        (bmbClockArea_bmbDfiDdr3_io_ddr3_addr[14:0]                      ), //o
    .io_ddr3_odt                         (bmbClockArea_bmbDfiDdr3_io_ddr3_odt                             ), //o
    .io_ddr3_dm                          (bmbClockArea_bmbDfiDdr3_io_ddr3_dm[1:0]                         ), //o
    .io_ddr3_dqsP                        (io_ddr3_dqsP                                                    ), //~
    .io_ddr3_dqsN                        (io_ddr3_dqsN                                                    ), //~
    .io_ddr3_dq                          (io_ddr3_dq                                                      ), //~
    .io_initDone                         (bmbClockArea_bmbDfiDdr3_io_initDone                             ), //o
    .clk_out4                            (clk_out4                                                        ), //i
    .rstN                                (rstN                                                            )  //i
  );
  assign io_axisWr_ready = axi4StreamToBmb_1_io_axiIn_ready;
  assign axi4StreamToBmb_1_io_axiIn_payload_user[0 : 0] = io_axisWr_payload_user[0 : 0];
  assign io_lengthOut = axi4StreamToBmb_1_io_lengthOut;
  assign io_signalRd_valid = axi4StreamToBmb_1_io_signalOut_valid;
  assign io_signalRd_payload_axis_data = axi4StreamToBmb_1_io_signalOut_payload_axis_data;
  assign io_signalRd_payload_axis_last = axi4StreamToBmb_1_io_signalOut_payload_axis_last;
  assign io_signalRd_payload_axis_user[0 : 0] = axi4StreamToBmb_1_io_signalOut_payload_axis_user[0 : 0];
  assign io_signalRd_payload_lastPiece = axi4StreamToBmb_1_io_signalOut_payload_lastPiece;
  assign io_txCtrl_ready = axi4StreamToBmb_1_io_rdCtr_ready;
  assign io_writeEnd_valid = axi4StreamToBmb_1_io_writeEnd_valid;
  assign io_ddr3InitDone = bmbClockArea_bmbDfiDdr3_io_initDone;
  assign io_ddr3_ckP = bmbClockArea_bmbDfiDdr3_io_ddr3_ckP;
  assign io_ddr3_ckN = bmbClockArea_bmbDfiDdr3_io_ddr3_ckN;
  assign io_ddr3_cke = bmbClockArea_bmbDfiDdr3_io_ddr3_cke;
  assign io_ddr3_resetN = bmbClockArea_bmbDfiDdr3_io_ddr3_resetN;
  assign io_ddr3_rasN = bmbClockArea_bmbDfiDdr3_io_ddr3_rasN;
  assign io_ddr3_casN = bmbClockArea_bmbDfiDdr3_io_ddr3_casN;
  assign io_ddr3_weN = bmbClockArea_bmbDfiDdr3_io_ddr3_weN;
  assign io_ddr3_csN = bmbClockArea_bmbDfiDdr3_io_ddr3_csN;
  assign io_ddr3_ba = bmbClockArea_bmbDfiDdr3_io_ddr3_ba;
  assign io_ddr3_addr = bmbClockArea_bmbDfiDdr3_io_ddr3_addr;
  assign io_ddr3_odt = bmbClockArea_bmbDfiDdr3_io_ddr3_odt;
  assign io_ddr3_dm = bmbClockArea_bmbDfiDdr3_io_ddr3_dm;

endmodule
