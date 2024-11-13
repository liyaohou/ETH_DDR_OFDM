// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : Axi4StreamToBmb
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module Axi4StreamToBmb (
  input  wire          io_axiIn_valid,
  output wire          io_axiIn_ready,
  input  wire [7:0]    io_axiIn_payload_data,
  input  wire          io_axiIn_payload_last,
  input  wire [0:0]    io_axiIn_payload_user,
  output wire          io_signalOut_valid,
  input  wire          io_signalOut_ready,
  output wire [7:0]    io_signalOut_payload_axis_data,
  output wire          io_signalOut_payload_axis_last,
  output wire [0:0]    io_signalOut_payload_axis_user,
  output wire          io_signalOut_payload_lastPiece,
  input  wire          io_rdCtr_valid,
  output wire          io_rdCtr_ready,
  output wire          io_writeEnd_valid,
  input  wire          io_writeEnd_ready,
  output wire          io_bmb_cmd_valid,
  input  wire          io_bmb_cmd_ready,
  output wire          io_bmb_cmd_payload_last,
  output wire [0:0]    io_bmb_cmd_payload_fragment_opcode,
  output wire [28:0]   io_bmb_cmd_payload_fragment_address,
  output wire [9:0]    io_bmb_cmd_payload_fragment_length,
  output wire [31:0]   io_bmb_cmd_payload_fragment_data,
  output wire [3:0]    io_bmb_cmd_payload_fragment_mask,
  output wire [3:0]    io_bmb_cmd_payload_fragment_context,
  input  wire          io_bmb_rsp_valid,
  output wire          io_bmb_rsp_ready,
  input  wire          io_bmb_rsp_payload_last,
  input  wire [0:0]    io_bmb_rsp_payload_fragment_opcode,
  input  wire [31:0]   io_bmb_rsp_payload_fragment_data,
  input  wire [3:0]    io_bmb_rsp_payload_fragment_context,
  output wire          io_error,
  input  wire [9:0]    io_lengthIn,
  output wire [9:0]    io_lengthOut,
  output wire          readEnd,
  input  wire          clk_out1,
  input  wire          rstN,
  input  wire          clk_out4
);

  wire       [0:0]    io_axiIn_fifo_io_push_payload_user;
  wire                adapter_bmbClockArea_bmbRdGen_io_start;
  wire                io_axiIn_fifo_io_push_ready;
  wire                io_axiIn_fifo_io_pop_valid;
  wire       [7:0]    io_axiIn_fifo_io_pop_payload_data;
  wire                io_axiIn_fifo_io_pop_payload_last;
  wire       [0:0]    io_axiIn_fifo_io_pop_payload_user;
  wire       [7:0]    io_axiIn_fifo_io_occupancy;
  wire       [7:0]    io_axiIn_fifo_io_availability;
  wire                axisToBmbBridge_bmbBridge_upSizer_io_input_cmd_ready;
  wire                axisToBmbBridge_bmbBridge_upSizer_io_input_rsp_valid;
  wire                axisToBmbBridge_bmbBridge_upSizer_io_input_rsp_payload_last;
  wire       [0:0]    axisToBmbBridge_bmbBridge_upSizer_io_input_rsp_payload_fragment_opcode;
  wire       [7:0]    axisToBmbBridge_bmbBridge_upSizer_io_input_rsp_payload_fragment_data;
  wire                axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_valid;
  wire                axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_payload_last;
  wire       [0:0]    axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_payload_fragment_opcode;
  wire       [28:0]   axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_payload_fragment_address;
  wire       [9:0]    axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_payload_fragment_length;
  wire       [31:0]   axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_payload_fragment_data;
  wire       [3:0]    axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_payload_fragment_mask;
  wire       [3:0]    axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_payload_fragment_context;
  wire                axisToBmbBridge_bmbBridge_upSizer_io_output_rsp_ready;
  wire                adapter_bmbCCDomain_io_input_cmd_ready;
  wire                adapter_bmbCCDomain_io_input_rsp_valid;
  wire                adapter_bmbCCDomain_io_input_rsp_payload_last;
  wire       [0:0]    adapter_bmbCCDomain_io_input_rsp_payload_fragment_opcode;
  wire       [31:0]   adapter_bmbCCDomain_io_input_rsp_payload_fragment_data;
  wire       [3:0]    adapter_bmbCCDomain_io_input_rsp_payload_fragment_context;
  wire                adapter_bmbCCDomain_io_output_cmd_valid;
  wire                adapter_bmbCCDomain_io_output_cmd_payload_last;
  wire       [0:0]    adapter_bmbCCDomain_io_output_cmd_payload_fragment_opcode;
  wire       [28:0]   adapter_bmbCCDomain_io_output_cmd_payload_fragment_address;
  wire       [9:0]    adapter_bmbCCDomain_io_output_cmd_payload_fragment_length;
  wire       [31:0]   adapter_bmbCCDomain_io_output_cmd_payload_fragment_data;
  wire       [3:0]    adapter_bmbCCDomain_io_output_cmd_payload_fragment_mask;
  wire       [3:0]    adapter_bmbCCDomain_io_output_cmd_payload_fragment_context;
  wire                adapter_bmbCCDomain_io_output_rsp_ready;
  wire                adapter_bmbCCDomain_adapter_bmbCCDomain_axi4StreamToBmb_workClockArea_ddr3AxisTxIf_toplevel_rstN_synchronized_1;
  wire                adapter_headCCDomain_io_input_ready;
  wire                adapter_headCCDomain_io_output_valid;
  wire                adapter_bmbClockArea_bmbRdGen_io_handShake_ready;
  wire       [9:0]    adapter_bmbClockArea_bmbRdGen_io_length;
  wire                adapter_bmbClockArea_bmbRdGen_io_bmbCmd_valid;
  wire                adapter_bmbClockArea_bmbRdGen_io_bmbCmd_payload_last;
  wire       [0:0]    adapter_bmbClockArea_bmbRdGen_io_bmbCmd_payload_fragment_opcode;
  wire       [28:0]   adapter_bmbClockArea_bmbRdGen_io_bmbCmd_payload_fragment_address;
  wire       [9:0]    adapter_bmbClockArea_bmbRdGen_io_bmbCmd_payload_fragment_length;
  wire       [31:0]   adapter_bmbClockArea_bmbRdGen_io_bmbCmd_payload_fragment_data;
  wire       [3:0]    adapter_bmbClockArea_bmbRdGen_io_bmbCmd_payload_fragment_mask;
  wire       [3:0]    adapter_bmbClockArea_bmbRdGen_io_bmbCmd_payload_fragment_context;
  wire                adapter_bmbClockArea_bmbRdGen_io_end;
  wire                adapter_writeEndHistory_buffercc_io_dataOut;
  wire                adapter_bmbClockArea_BmbMux_buffercc_io_dataOut;
  wire                adapter_bmbClockArea_bmbRdGen_io_end_buffercc_io_dataOut;
  wire       [28:0]   _zz_axisToBmbBridge_cmd_bmbAddr;
  wire       [10:0]   _zz_axisToBmbBridge_cmd_bmbAddr_1;
  wire       [10:0]   _zz_axisToBmbBridge_cmd_bmbAddr_2;
  wire       [1:0]    _zz_axisToBmbBridge_cmd_bmbAddr_3;
  wire       [9:0]    _zz_axisToBmbBridge_rsp_lastCounter_valueNext;
  wire       [0:0]    _zz_axisToBmbBridge_rsp_lastCounter_valueNext_1;
  wire       [18:0]   _zz_axisToBmbBridge_rsp_tailCounter_valueNext;
  wire       [0:0]    _zz_axisToBmbBridge_rsp_tailCounter_valueNext_1;
  wire       [28:0]   _zz_axisToBmbBridge_rsp_fifo_payload_last;
  wire       [28:0]   _zz_axisToBmbBridge_rsp_fifo_payload_last_1;
  wire       [28:0]   _zz_axisToBmbBridge_rsp_fifo_payload_last_2;
  wire       [28:0]   _zz_axisToBmbBridge_rsp_fifo_payload_last_3;
  wire                axiOut_valid;
  wire                axiOut_ready;
  wire       [7:0]    axiOut_payload_data;
  wire                axiOut_payload_last;
  wire       [0:0]    axiOut_payload_user;
  wire                axisToBmbBridge_bmbBridge_cmd_valid;
  wire                axisToBmbBridge_bmbBridge_cmd_ready;
  wire                axisToBmbBridge_bmbBridge_cmd_payload_last;
  wire       [0:0]    axisToBmbBridge_bmbBridge_cmd_payload_fragment_opcode;
  wire       [28:0]   axisToBmbBridge_bmbBridge_cmd_payload_fragment_address;
  wire       [9:0]    axisToBmbBridge_bmbBridge_cmd_payload_fragment_length;
  wire       [7:0]    axisToBmbBridge_bmbBridge_cmd_payload_fragment_data;
  wire       [0:0]    axisToBmbBridge_bmbBridge_cmd_payload_fragment_mask;
  wire                axisToBmbBridge_bmbBridge_rsp_valid;
  wire                axisToBmbBridge_bmbBridge_rsp_ready;
  wire                axisToBmbBridge_bmbBridge_rsp_payload_last;
  wire       [0:0]    axisToBmbBridge_bmbBridge_rsp_payload_fragment_opcode;
  wire       [7:0]    axisToBmbBridge_bmbBridge_rsp_payload_fragment_data;
  (* async_reg = "true" *) reg        [28:0]   axisToBmbBridge_cmd_bmbAddr;
  reg                 readEnd_regNext;
  wire                when_Axi4StreamToBmb_l44;
  wire                axisToBmbBridge_cmd_fifo_valid;
  wire                axisToBmbBridge_cmd_fifo_ready;
  wire       [7:0]    axisToBmbBridge_cmd_fifo_payload_data;
  wire                axisToBmbBridge_cmd_fifo_payload_last;
  wire       [0:0]    axisToBmbBridge_cmd_fifo_payload_user;
  wire                axisToBmbBridge_cmd_fifo_fire;
  wire                when_Axi4StreamToBmb_l47;
  reg                 axisToBmbBridge_cmd_error;
  wire                when_Axi4StreamToBmb_l59;
  reg                 axisToBmbBridge_rsp_lastCounter_willIncrement;
  reg                 axisToBmbBridge_rsp_lastCounter_willClear;
  reg        [9:0]    axisToBmbBridge_rsp_lastCounter_valueNext;
  reg        [9:0]    axisToBmbBridge_rsp_lastCounter_value;
  wire                axisToBmbBridge_rsp_lastCounter_willOverflowIfInc;
  wire                axisToBmbBridge_rsp_lastCounter_willOverflow;
  reg                 axisToBmbBridge_rsp_tailCounter_willIncrement;
  reg                 axisToBmbBridge_rsp_tailCounter_willClear;
  reg        [18:0]   axisToBmbBridge_rsp_tailCounter_valueNext;
  reg        [18:0]   axisToBmbBridge_rsp_tailCounter_value;
  wire                axisToBmbBridge_rsp_tailCounter_willOverflowIfInc;
  wire                axisToBmbBridge_rsp_tailCounter_willOverflow;
  reg                 readEnd_regNext_1;
  wire                when_Axi4StreamToBmb_l66;
  wire                axisToBmbBridge_rsp_fifo_valid;
  wire                axisToBmbBridge_rsp_fifo_ready;
  wire       [7:0]    axisToBmbBridge_rsp_fifo_payload_data;
  wire                axisToBmbBridge_rsp_fifo_payload_last;
  wire       [0:0]    axisToBmbBridge_rsp_fifo_payload_user;
  wire                axisToBmbBridge_rsp_fifo_fire;
  reg                 adapter_endFlag;
  wire                _zz_adapter_writeEndHistory;
  reg                 _zz_adapter_writeEndHistory_1;
  reg                 _zz_adapter_writeEndHistory_2;
  reg                 _zz_adapter_writeEndHistory_3;
  wire                adapter_writeEndHistory;
  reg                 adapter_bmbClockArea_BmbMux;
  reg                 adapter_bmbClockArea_BmbMux_regNext;
  wire                when_Axi4StreamToBmb_l97;
  wire                _zz_io_writeEnd_valid;
  reg                 _zz_io_writeEnd_valid_1;
  wire                when_Axi4StreamToBmb_l116;
  wire                axiOut_fire;
  wire                _zz_when_Stream_l393;
  wire                _zz_io_input_rsp_ready;
  wire                _zz_io_output_rsp_payload_last;
  wire       [0:0]    _zz_io_output_rsp_payload_fragment_opcode;
  wire       [31:0]   _zz_io_output_rsp_payload_fragment_data;
  wire       [3:0]    _zz_io_output_rsp_payload_fragment_context;
  wire                axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_combStage_valid;
  wire                axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_combStage_ready;
  wire                axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_combStage_payload_last;
  wire       [0:0]    axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_combStage_payload_fragment_opcode;
  wire       [28:0]   axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_combStage_payload_fragment_address;
  wire       [9:0]    axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_combStage_payload_fragment_length;
  wire       [31:0]   axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_combStage_payload_fragment_data;
  wire       [3:0]    axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_combStage_payload_fragment_mask;
  wire       [3:0]    axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_combStage_payload_fragment_context;
  reg                 _zz_1;
  reg                 _zz_io_output_rsp_payload_last_1;
  reg                 _zz_io_output_rsp_payload_last_2;
  reg        [0:0]    _zz_io_output_rsp_payload_fragment_opcode_1;
  reg        [31:0]   _zz_io_output_rsp_payload_fragment_data_1;
  reg        [3:0]    _zz_io_output_rsp_payload_fragment_context_1;
  wire                _zz_when_Stream_l393_1;
  reg                 _zz_when_Stream_l393_2;
  reg                 _zz_io_output_rsp_payload_last_3;
  reg        [0:0]    _zz_io_output_rsp_payload_fragment_opcode_2;
  reg        [31:0]   _zz_io_output_rsp_payload_fragment_data_2;
  reg        [3:0]    _zz_io_output_rsp_payload_fragment_context_2;
  wire                when_Stream_l393;

  assign _zz_axisToBmbBridge_cmd_bmbAddr_1 = ({1'b0,io_lengthIn} + _zz_axisToBmbBridge_cmd_bmbAddr_2);
  assign _zz_axisToBmbBridge_cmd_bmbAddr = {18'd0, _zz_axisToBmbBridge_cmd_bmbAddr_1};
  assign _zz_axisToBmbBridge_cmd_bmbAddr_3 = {1'b0,1'b1};
  assign _zz_axisToBmbBridge_cmd_bmbAddr_2 = {9'd0, _zz_axisToBmbBridge_cmd_bmbAddr_3};
  assign _zz_axisToBmbBridge_rsp_lastCounter_valueNext_1 = axisToBmbBridge_rsp_lastCounter_willIncrement;
  assign _zz_axisToBmbBridge_rsp_lastCounter_valueNext = {9'd0, _zz_axisToBmbBridge_rsp_lastCounter_valueNext_1};
  assign _zz_axisToBmbBridge_rsp_tailCounter_valueNext_1 = axisToBmbBridge_rsp_tailCounter_willIncrement;
  assign _zz_axisToBmbBridge_rsp_tailCounter_valueNext = {18'd0, _zz_axisToBmbBridge_rsp_tailCounter_valueNext_1};
  assign _zz_axisToBmbBridge_rsp_fifo_payload_last = (_zz_axisToBmbBridge_rsp_fifo_payload_last_1 + _zz_axisToBmbBridge_rsp_fifo_payload_last_2);
  assign _zz_axisToBmbBridge_rsp_fifo_payload_last_1 = ({10'd0,axisToBmbBridge_rsp_tailCounter_value} <<< 4'd10);
  assign _zz_axisToBmbBridge_rsp_fifo_payload_last_2 = {19'd0, axisToBmbBridge_rsp_lastCounter_value};
  assign _zz_axisToBmbBridge_rsp_fifo_payload_last_3 = (axisToBmbBridge_cmd_bmbAddr - 29'h00000001);
  StreamFifoLowLatency io_axiIn_fifo (
    .io_push_valid        (io_axiIn_valid                        ), //i
    .io_push_ready        (io_axiIn_fifo_io_push_ready           ), //o
    .io_push_payload_data (io_axiIn_payload_data[7:0]            ), //i
    .io_push_payload_last (io_axiIn_payload_last                 ), //i
    .io_push_payload_user (io_axiIn_fifo_io_push_payload_user    ), //i
    .io_pop_valid         (io_axiIn_fifo_io_pop_valid            ), //o
    .io_pop_ready         (axisToBmbBridge_cmd_fifo_ready        ), //i
    .io_pop_payload_data  (io_axiIn_fifo_io_pop_payload_data[7:0]), //o
    .io_pop_payload_last  (io_axiIn_fifo_io_pop_payload_last     ), //o
    .io_pop_payload_user  (io_axiIn_fifo_io_pop_payload_user     ), //o
    .io_flush             (1'b0                                  ), //i
    .io_occupancy         (io_axiIn_fifo_io_occupancy[7:0]       ), //o
    .io_availability      (io_axiIn_fifo_io_availability[7:0]    ), //o
    .clk_out1             (clk_out1                              ), //i
    .rstN                 (rstN                                  )  //i
  );
  BmbUpSizerBridge axisToBmbBridge_bmbBridge_upSizer (
    .io_input_cmd_valid                     (axisToBmbBridge_bmbBridge_cmd_valid                                           ), //i
    .io_input_cmd_ready                     (axisToBmbBridge_bmbBridge_upSizer_io_input_cmd_ready                          ), //o
    .io_input_cmd_payload_last              (axisToBmbBridge_bmbBridge_cmd_payload_last                                    ), //i
    .io_input_cmd_payload_fragment_opcode   (axisToBmbBridge_bmbBridge_cmd_payload_fragment_opcode                         ), //i
    .io_input_cmd_payload_fragment_address  (axisToBmbBridge_bmbBridge_cmd_payload_fragment_address[28:0]                  ), //i
    .io_input_cmd_payload_fragment_length   (axisToBmbBridge_bmbBridge_cmd_payload_fragment_length[9:0]                    ), //i
    .io_input_cmd_payload_fragment_data     (axisToBmbBridge_bmbBridge_cmd_payload_fragment_data[7:0]                      ), //i
    .io_input_cmd_payload_fragment_mask     (axisToBmbBridge_bmbBridge_cmd_payload_fragment_mask                           ), //i
    .io_input_rsp_valid                     (axisToBmbBridge_bmbBridge_upSizer_io_input_rsp_valid                          ), //o
    .io_input_rsp_ready                     (axisToBmbBridge_bmbBridge_rsp_ready                                           ), //i
    .io_input_rsp_payload_last              (axisToBmbBridge_bmbBridge_upSizer_io_input_rsp_payload_last                   ), //o
    .io_input_rsp_payload_fragment_opcode   (axisToBmbBridge_bmbBridge_upSizer_io_input_rsp_payload_fragment_opcode        ), //o
    .io_input_rsp_payload_fragment_data     (axisToBmbBridge_bmbBridge_upSizer_io_input_rsp_payload_fragment_data[7:0]     ), //o
    .io_output_cmd_valid                    (axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_valid                         ), //o
    .io_output_cmd_ready                    (axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_combStage_ready               ), //i
    .io_output_cmd_payload_last             (axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_payload_last                  ), //o
    .io_output_cmd_payload_fragment_opcode  (axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_payload_fragment_opcode       ), //o
    .io_output_cmd_payload_fragment_address (axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_payload_fragment_address[28:0]), //o
    .io_output_cmd_payload_fragment_length  (axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_payload_fragment_length[9:0]  ), //o
    .io_output_cmd_payload_fragment_data    (axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_payload_fragment_data[31:0]   ), //o
    .io_output_cmd_payload_fragment_mask    (axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_payload_fragment_mask[3:0]    ), //o
    .io_output_cmd_payload_fragment_context (axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_payload_fragment_context[3:0] ), //o
    .io_output_rsp_valid                    (_zz_when_Stream_l393_1                                                        ), //i
    .io_output_rsp_ready                    (axisToBmbBridge_bmbBridge_upSizer_io_output_rsp_ready                         ), //o
    .io_output_rsp_payload_last             (_zz_io_output_rsp_payload_last_3                                              ), //i
    .io_output_rsp_payload_fragment_opcode  (_zz_io_output_rsp_payload_fragment_opcode_2                                   ), //i
    .io_output_rsp_payload_fragment_data    (_zz_io_output_rsp_payload_fragment_data_2[31:0]                               ), //i
    .io_output_rsp_payload_fragment_context (_zz_io_output_rsp_payload_fragment_context_2[3:0]                             ), //i
    .clk_out1                               (clk_out1                                                                      ), //i
    .rstN                                   (rstN                                                                          )  //i
  );
  BmbCcFifo adapter_bmbCCDomain (
    .io_input_cmd_valid                                                                          (axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_combStage_valid                                                ), //i
    .io_input_cmd_ready                                                                          (adapter_bmbCCDomain_io_input_cmd_ready                                                                         ), //o
    .io_input_cmd_payload_last                                                                   (axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_combStage_payload_last                                         ), //i
    .io_input_cmd_payload_fragment_opcode                                                        (axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_combStage_payload_fragment_opcode                              ), //i
    .io_input_cmd_payload_fragment_address                                                       (axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_combStage_payload_fragment_address[28:0]                       ), //i
    .io_input_cmd_payload_fragment_length                                                        (axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_combStage_payload_fragment_length[9:0]                         ), //i
    .io_input_cmd_payload_fragment_data                                                          (axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_combStage_payload_fragment_data[31:0]                          ), //i
    .io_input_cmd_payload_fragment_mask                                                          (axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_combStage_payload_fragment_mask[3:0]                           ), //i
    .io_input_cmd_payload_fragment_context                                                       (axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_combStage_payload_fragment_context[3:0]                        ), //i
    .io_input_rsp_valid                                                                          (adapter_bmbCCDomain_io_input_rsp_valid                                                                         ), //o
    .io_input_rsp_ready                                                                          (_zz_io_input_rsp_ready                                                                                         ), //i
    .io_input_rsp_payload_last                                                                   (adapter_bmbCCDomain_io_input_rsp_payload_last                                                                  ), //o
    .io_input_rsp_payload_fragment_opcode                                                        (adapter_bmbCCDomain_io_input_rsp_payload_fragment_opcode                                                       ), //o
    .io_input_rsp_payload_fragment_data                                                          (adapter_bmbCCDomain_io_input_rsp_payload_fragment_data[31:0]                                                   ), //o
    .io_input_rsp_payload_fragment_context                                                       (adapter_bmbCCDomain_io_input_rsp_payload_fragment_context[3:0]                                                 ), //o
    .io_output_cmd_valid                                                                         (adapter_bmbCCDomain_io_output_cmd_valid                                                                        ), //o
    .io_output_cmd_ready                                                                         (io_bmb_cmd_ready                                                                                               ), //i
    .io_output_cmd_payload_last                                                                  (adapter_bmbCCDomain_io_output_cmd_payload_last                                                                 ), //o
    .io_output_cmd_payload_fragment_opcode                                                       (adapter_bmbCCDomain_io_output_cmd_payload_fragment_opcode                                                      ), //o
    .io_output_cmd_payload_fragment_address                                                      (adapter_bmbCCDomain_io_output_cmd_payload_fragment_address[28:0]                                               ), //o
    .io_output_cmd_payload_fragment_length                                                       (adapter_bmbCCDomain_io_output_cmd_payload_fragment_length[9:0]                                                 ), //o
    .io_output_cmd_payload_fragment_data                                                         (adapter_bmbCCDomain_io_output_cmd_payload_fragment_data[31:0]                                                  ), //o
    .io_output_cmd_payload_fragment_mask                                                         (adapter_bmbCCDomain_io_output_cmd_payload_fragment_mask[3:0]                                                   ), //o
    .io_output_cmd_payload_fragment_context                                                      (adapter_bmbCCDomain_io_output_cmd_payload_fragment_context[3:0]                                                ), //o
    .io_output_rsp_valid                                                                         (io_bmb_rsp_valid                                                                                               ), //i
    .io_output_rsp_ready                                                                         (adapter_bmbCCDomain_io_output_rsp_ready                                                                        ), //o
    .io_output_rsp_payload_last                                                                  (1'b0                                                                                                           ), //i
    .io_output_rsp_payload_fragment_opcode                                                       (io_bmb_rsp_payload_fragment_opcode                                                                             ), //i
    .io_output_rsp_payload_fragment_data                                                         (io_bmb_rsp_payload_fragment_data[31:0]                                                                         ), //i
    .io_output_rsp_payload_fragment_context                                                      (io_bmb_rsp_payload_fragment_context[3:0]                                                                       ), //i
    .clk_out1                                                                                    (clk_out1                                                                                                       ), //i
    .rstN                                                                                        (rstN                                                                                                           ), //i
    .clk_out4                                                                                    (clk_out4                                                                                                       ), //i
    .adapter_bmbCCDomain_axi4StreamToBmb_workClockArea_ddr3AxisTxIf_toplevel_rstN_synchronized_1 (adapter_bmbCCDomain_adapter_bmbCCDomain_axi4StreamToBmb_workClockArea_ddr3AxisTxIf_toplevel_rstN_synchronized_1)  //o
  );
  StreamCCByToggle adapter_headCCDomain (
    .io_input_valid                                                                              (io_rdCtr_valid                                                                                                 ), //i
    .io_input_ready                                                                              (adapter_headCCDomain_io_input_ready                                                                            ), //o
    .io_output_valid                                                                             (adapter_headCCDomain_io_output_valid                                                                           ), //o
    .io_output_ready                                                                             (adapter_bmbClockArea_bmbRdGen_io_handShake_ready                                                               ), //i
    .clk_out1                                                                                    (clk_out1                                                                                                       ), //i
    .rstN                                                                                        (rstN                                                                                                           ), //i
    .clk_out4                                                                                    (clk_out4                                                                                                       ), //i
    .adapter_bmbCCDomain_axi4StreamToBmb_workClockArea_ddr3AxisTxIf_toplevel_rstN_synchronized_1 (adapter_bmbCCDomain_adapter_bmbCCDomain_axi4StreamToBmb_workClockArea_ddr3AxisTxIf_toplevel_rstN_synchronized_1)  //i
  );
  BmbRdCmdGen adapter_bmbClockArea_bmbRdGen (
    .io_start                           (adapter_bmbClockArea_bmbRdGen_io_start                                ), //i
    .io_handShake_valid                 (adapter_headCCDomain_io_output_valid                                  ), //i
    .io_handShake_ready                 (adapter_bmbClockArea_bmbRdGen_io_handShake_ready                      ), //o
    .io_address                         (axisToBmbBridge_cmd_bmbAddr[28:0]                                     ), //i
    .io_length                          (adapter_bmbClockArea_bmbRdGen_io_length[9:0]                          ), //o
    .io_bmbCmd_valid                    (adapter_bmbClockArea_bmbRdGen_io_bmbCmd_valid                         ), //o
    .io_bmbCmd_ready                    (io_bmb_cmd_ready                                                      ), //i
    .io_bmbCmd_payload_last             (adapter_bmbClockArea_bmbRdGen_io_bmbCmd_payload_last                  ), //o
    .io_bmbCmd_payload_fragment_opcode  (adapter_bmbClockArea_bmbRdGen_io_bmbCmd_payload_fragment_opcode       ), //o
    .io_bmbCmd_payload_fragment_address (adapter_bmbClockArea_bmbRdGen_io_bmbCmd_payload_fragment_address[28:0]), //o
    .io_bmbCmd_payload_fragment_length  (adapter_bmbClockArea_bmbRdGen_io_bmbCmd_payload_fragment_length[9:0]  ), //o
    .io_bmbCmd_payload_fragment_data    (adapter_bmbClockArea_bmbRdGen_io_bmbCmd_payload_fragment_data[31:0]   ), //o
    .io_bmbCmd_payload_fragment_mask    (adapter_bmbClockArea_bmbRdGen_io_bmbCmd_payload_fragment_mask[3:0]    ), //o
    .io_bmbCmd_payload_fragment_context (adapter_bmbClockArea_bmbRdGen_io_bmbCmd_payload_fragment_context[3:0] ), //o
    .io_end                             (adapter_bmbClockArea_bmbRdGen_io_end                                  ), //o
    .clk_out4                           (clk_out4                                                              ), //i
    .rstN                               (rstN                                                                  )  //i
  );
  (* keep_hierarchy = "TRUE" *) BufferCC_8 adapter_writeEndHistory_buffercc (
    .io_dataIn  (adapter_writeEndHistory                    ), //i
    .io_dataOut (adapter_writeEndHistory_buffercc_io_dataOut), //o
    .clk_out4   (clk_out4                                   ), //i
    .rstN       (rstN                                       )  //i
  );
  (* keep_hierarchy = "TRUE" *) BufferCC_4 adapter_bmbClockArea_BmbMux_buffercc (
    .io_dataIn  (adapter_bmbClockArea_BmbMux                    ), //i
    .io_dataOut (adapter_bmbClockArea_BmbMux_buffercc_io_dataOut), //o
    .clk_out1   (clk_out1                                       ), //i
    .rstN       (rstN                                           )  //i
  );
  (* keep_hierarchy = "TRUE" *) BufferCC_4 adapter_bmbClockArea_bmbRdGen_io_end_buffercc (
    .io_dataIn  (adapter_bmbClockArea_bmbRdGen_io_end                    ), //i
    .io_dataOut (adapter_bmbClockArea_bmbRdGen_io_end_buffercc_io_dataOut), //o
    .clk_out1   (clk_out1                                                ), //i
    .rstN       (rstN                                                    )  //i
  );
  assign when_Axi4StreamToBmb_l44 = (readEnd && (! readEnd_regNext));
  assign io_axiIn_ready = io_axiIn_fifo_io_push_ready;
  assign io_axiIn_fifo_io_push_payload_user[0 : 0] = io_axiIn_payload_user[0 : 0];
  assign axisToBmbBridge_cmd_fifo_valid = io_axiIn_fifo_io_pop_valid;
  assign axisToBmbBridge_cmd_fifo_payload_data = io_axiIn_fifo_io_pop_payload_data;
  assign axisToBmbBridge_cmd_fifo_payload_last = io_axiIn_fifo_io_pop_payload_last;
  assign axisToBmbBridge_cmd_fifo_payload_user[0 : 0] = io_axiIn_fifo_io_pop_payload_user[0 : 0];
  assign axisToBmbBridge_cmd_fifo_fire = (axisToBmbBridge_cmd_fifo_valid && axisToBmbBridge_cmd_fifo_ready);
  assign when_Axi4StreamToBmb_l47 = (axisToBmbBridge_cmd_fifo_payload_last && axisToBmbBridge_cmd_fifo_fire);
  assign axisToBmbBridge_bmbBridge_cmd_valid = axisToBmbBridge_cmd_fifo_valid;
  assign axisToBmbBridge_cmd_fifo_ready = axisToBmbBridge_bmbBridge_cmd_ready;
  assign axisToBmbBridge_bmbBridge_cmd_payload_fragment_data = axisToBmbBridge_cmd_fifo_payload_data;
  assign axisToBmbBridge_bmbBridge_cmd_payload_last = axisToBmbBridge_cmd_fifo_payload_last;
  assign axisToBmbBridge_bmbBridge_cmd_payload_fragment_length = io_lengthIn;
  assign axisToBmbBridge_bmbBridge_cmd_payload_fragment_address = axisToBmbBridge_cmd_bmbAddr;
  assign axisToBmbBridge_bmbBridge_cmd_payload_fragment_mask = 1'b0;
  assign axisToBmbBridge_bmbBridge_cmd_payload_fragment_opcode = 1'b1;
  assign when_Axi4StreamToBmb_l59 = ((axisToBmbBridge_cmd_fifo_payload_last && axisToBmbBridge_cmd_fifo_fire) && axisToBmbBridge_cmd_fifo_payload_user[0]);
  assign io_error = axisToBmbBridge_cmd_error;
  always @(*) begin
    axisToBmbBridge_rsp_lastCounter_willIncrement = 1'b0;
    if(axisToBmbBridge_rsp_fifo_fire) begin
      axisToBmbBridge_rsp_lastCounter_willIncrement = 1'b1;
    end
  end

  always @(*) begin
    axisToBmbBridge_rsp_lastCounter_willClear = 1'b0;
    if(when_Axi4StreamToBmb_l66) begin
      axisToBmbBridge_rsp_lastCounter_willClear = 1'b1;
    end
  end

  assign axisToBmbBridge_rsp_lastCounter_willOverflowIfInc = (axisToBmbBridge_rsp_lastCounter_value == 10'h3ff);
  assign axisToBmbBridge_rsp_lastCounter_willOverflow = (axisToBmbBridge_rsp_lastCounter_willOverflowIfInc && axisToBmbBridge_rsp_lastCounter_willIncrement);
  always @(*) begin
    axisToBmbBridge_rsp_lastCounter_valueNext = (axisToBmbBridge_rsp_lastCounter_value + _zz_axisToBmbBridge_rsp_lastCounter_valueNext);
    if(axisToBmbBridge_rsp_lastCounter_willClear) begin
      axisToBmbBridge_rsp_lastCounter_valueNext = 10'h0;
    end
  end

  always @(*) begin
    axisToBmbBridge_rsp_tailCounter_willIncrement = 1'b0;
    if(axisToBmbBridge_rsp_lastCounter_willOverflow) begin
      axisToBmbBridge_rsp_tailCounter_willIncrement = 1'b1;
    end
  end

  always @(*) begin
    axisToBmbBridge_rsp_tailCounter_willClear = 1'b0;
    if(when_Axi4StreamToBmb_l66) begin
      axisToBmbBridge_rsp_tailCounter_willClear = 1'b1;
    end
  end

  assign axisToBmbBridge_rsp_tailCounter_willOverflowIfInc = (axisToBmbBridge_rsp_tailCounter_value == 19'h7ffff);
  assign axisToBmbBridge_rsp_tailCounter_willOverflow = (axisToBmbBridge_rsp_tailCounter_willOverflowIfInc && axisToBmbBridge_rsp_tailCounter_willIncrement);
  always @(*) begin
    axisToBmbBridge_rsp_tailCounter_valueNext = (axisToBmbBridge_rsp_tailCounter_value + _zz_axisToBmbBridge_rsp_tailCounter_valueNext);
    if(axisToBmbBridge_rsp_tailCounter_willClear) begin
      axisToBmbBridge_rsp_tailCounter_valueNext = 19'h0;
    end
  end

  assign when_Axi4StreamToBmb_l66 = (readEnd && (! readEnd_regNext_1));
  assign axisToBmbBridge_rsp_fifo_fire = (axisToBmbBridge_rsp_fifo_valid && axisToBmbBridge_rsp_fifo_ready);
  assign axisToBmbBridge_rsp_fifo_valid = axisToBmbBridge_bmbBridge_rsp_valid;
  assign axisToBmbBridge_bmbBridge_rsp_ready = axisToBmbBridge_rsp_fifo_ready;
  assign axisToBmbBridge_rsp_fifo_payload_user = 1'b0;
  assign axisToBmbBridge_rsp_fifo_payload_data = axisToBmbBridge_bmbBridge_rsp_payload_fragment_data;
  assign axisToBmbBridge_rsp_fifo_payload_last = (axisToBmbBridge_rsp_lastCounter_willOverflow || (_zz_axisToBmbBridge_rsp_fifo_payload_last == _zz_axisToBmbBridge_rsp_fifo_payload_last_3));
  assign axiOut_valid = axisToBmbBridge_rsp_fifo_valid;
  assign axisToBmbBridge_rsp_fifo_ready = axiOut_ready;
  assign axiOut_payload_data = axisToBmbBridge_rsp_fifo_payload_data;
  assign axiOut_payload_last = axisToBmbBridge_rsp_fifo_payload_last;
  assign axiOut_payload_user[0 : 0] = axisToBmbBridge_rsp_fifo_payload_user[0 : 0];
  assign axisToBmbBridge_bmbBridge_cmd_ready = axisToBmbBridge_bmbBridge_upSizer_io_input_cmd_ready;
  assign axisToBmbBridge_bmbBridge_rsp_valid = axisToBmbBridge_bmbBridge_upSizer_io_input_rsp_valid;
  assign axisToBmbBridge_bmbBridge_rsp_payload_last = axisToBmbBridge_bmbBridge_upSizer_io_input_rsp_payload_last;
  assign axisToBmbBridge_bmbBridge_rsp_payload_fragment_opcode = axisToBmbBridge_bmbBridge_upSizer_io_input_rsp_payload_fragment_opcode;
  assign axisToBmbBridge_bmbBridge_rsp_payload_fragment_data = axisToBmbBridge_bmbBridge_upSizer_io_input_rsp_payload_fragment_data;
  assign _zz_adapter_writeEndHistory = io_writeEnd_ready;
  assign adapter_writeEndHistory = (|{_zz_adapter_writeEndHistory_3,{_zz_adapter_writeEndHistory_2,{_zz_adapter_writeEndHistory_1,_zz_adapter_writeEndHistory}}});
  assign adapter_bmbClockArea_bmbRdGen_io_start = (adapter_bmbClockArea_BmbMux && (! adapter_bmbClockArea_BmbMux_regNext));
  assign io_bmb_cmd_valid = (adapter_bmbClockArea_BmbMux ? adapter_bmbClockArea_bmbRdGen_io_bmbCmd_valid : adapter_bmbCCDomain_io_output_cmd_valid);
  assign io_bmb_cmd_payload_last = (adapter_bmbClockArea_BmbMux ? adapter_bmbClockArea_bmbRdGen_io_bmbCmd_payload_last : adapter_bmbCCDomain_io_output_cmd_payload_last);
  assign io_bmb_cmd_payload_fragment_opcode = (adapter_bmbClockArea_BmbMux ? adapter_bmbClockArea_bmbRdGen_io_bmbCmd_payload_fragment_opcode : adapter_bmbCCDomain_io_output_cmd_payload_fragment_opcode);
  assign io_bmb_cmd_payload_fragment_address = (adapter_bmbClockArea_BmbMux ? adapter_bmbClockArea_bmbRdGen_io_bmbCmd_payload_fragment_address : adapter_bmbCCDomain_io_output_cmd_payload_fragment_address);
  assign io_bmb_cmd_payload_fragment_length = (adapter_bmbClockArea_BmbMux ? adapter_bmbClockArea_bmbRdGen_io_bmbCmd_payload_fragment_length : adapter_bmbCCDomain_io_output_cmd_payload_fragment_length);
  assign io_bmb_cmd_payload_fragment_data = (adapter_bmbClockArea_BmbMux ? adapter_bmbClockArea_bmbRdGen_io_bmbCmd_payload_fragment_data : adapter_bmbCCDomain_io_output_cmd_payload_fragment_data);
  assign io_bmb_cmd_payload_fragment_mask = (adapter_bmbClockArea_BmbMux ? adapter_bmbClockArea_bmbRdGen_io_bmbCmd_payload_fragment_mask : adapter_bmbCCDomain_io_output_cmd_payload_fragment_mask);
  assign io_bmb_cmd_payload_fragment_context = (adapter_bmbClockArea_BmbMux ? adapter_bmbClockArea_bmbRdGen_io_bmbCmd_payload_fragment_context : adapter_bmbCCDomain_io_output_cmd_payload_fragment_context);
  assign when_Axi4StreamToBmb_l97 = adapter_writeEndHistory_buffercc_io_dataOut;
  assign io_bmb_rsp_ready = adapter_bmbCCDomain_io_output_rsp_ready;
  assign _zz_io_writeEnd_valid = adapter_bmbClockArea_BmbMux_buffercc_io_dataOut;
  assign io_writeEnd_valid = (_zz_io_writeEnd_valid && (! _zz_io_writeEnd_valid_1));
  assign when_Axi4StreamToBmb_l116 = adapter_bmbClockArea_bmbRdGen_io_end_buffercc_io_dataOut;
  assign axiOut_fire = (axiOut_valid && axiOut_ready);
  assign readEnd = (adapter_endFlag && (axiOut_payload_last && axiOut_fire));
  assign io_rdCtr_ready = adapter_headCCDomain_io_input_ready;
  assign axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_combStage_valid = axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_valid;
  assign axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_combStage_payload_last = axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_payload_last;
  assign axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_combStage_payload_fragment_opcode = axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_payload_fragment_opcode;
  assign axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_combStage_payload_fragment_address = axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_payload_fragment_address;
  assign axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_combStage_payload_fragment_length = axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_payload_fragment_length;
  assign axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_combStage_payload_fragment_data = axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_payload_fragment_data;
  assign axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_combStage_payload_fragment_mask = axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_payload_fragment_mask;
  assign axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_combStage_payload_fragment_context = axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_payload_fragment_context;
  assign axisToBmbBridge_bmbBridge_upSizer_io_output_cmd_combStage_ready = adapter_bmbCCDomain_io_input_cmd_ready;
  assign _zz_io_input_rsp_ready = _zz_io_output_rsp_payload_last_1;
  always @(*) begin
    _zz_1 = axisToBmbBridge_bmbBridge_upSizer_io_output_rsp_ready;
    if(when_Stream_l393) begin
      _zz_1 = 1'b1;
    end
  end

  assign when_Stream_l393 = (! _zz_when_Stream_l393_1);
  assign _zz_when_Stream_l393_1 = _zz_when_Stream_l393_2;
  assign _zz_when_Stream_l393 = adapter_bmbCCDomain_io_input_rsp_valid;
  assign _zz_io_output_rsp_payload_last = adapter_bmbCCDomain_io_input_rsp_payload_last;
  assign _zz_io_output_rsp_payload_fragment_opcode = adapter_bmbCCDomain_io_input_rsp_payload_fragment_opcode;
  assign _zz_io_output_rsp_payload_fragment_data = adapter_bmbCCDomain_io_input_rsp_payload_fragment_data;
  assign _zz_io_output_rsp_payload_fragment_context = adapter_bmbCCDomain_io_input_rsp_payload_fragment_context;
  assign io_lengthOut = adapter_bmbClockArea_bmbRdGen_io_length;
  assign io_signalOut_valid = axiOut_valid;
  assign axiOut_ready = io_signalOut_ready;
  assign io_signalOut_payload_axis_data = axiOut_payload_data;
  assign io_signalOut_payload_axis_last = axiOut_payload_last;
  assign io_signalOut_payload_axis_user[0 : 0] = axiOut_payload_user[0 : 0];
  assign io_signalOut_payload_lastPiece = readEnd;
  always @(posedge clk_out1 or negedge rstN) begin
    if(!rstN) begin
      axisToBmbBridge_cmd_bmbAddr <= 29'h0;
      axisToBmbBridge_cmd_error <= 1'b0;
      axisToBmbBridge_rsp_lastCounter_value <= 10'h0;
      axisToBmbBridge_rsp_tailCounter_value <= 19'h0;
      adapter_endFlag <= 1'b0;
      _zz_io_output_rsp_payload_last_1 <= 1'b1;
      _zz_when_Stream_l393_2 <= 1'b0;
    end else begin
      if(when_Axi4StreamToBmb_l44) begin
        axisToBmbBridge_cmd_bmbAddr <= 29'h0;
      end
      if(when_Axi4StreamToBmb_l47) begin
        axisToBmbBridge_cmd_bmbAddr <= (axisToBmbBridge_cmd_bmbAddr + _zz_axisToBmbBridge_cmd_bmbAddr);
      end
      if(when_Axi4StreamToBmb_l59) begin
        axisToBmbBridge_cmd_error <= 1'b1;
      end
      axisToBmbBridge_rsp_lastCounter_value <= axisToBmbBridge_rsp_lastCounter_valueNext;
      axisToBmbBridge_rsp_tailCounter_value <= axisToBmbBridge_rsp_tailCounter_valueNext;
      if(when_Axi4StreamToBmb_l116) begin
        adapter_endFlag <= 1'b1;
      end
      if(readEnd) begin
        adapter_endFlag <= 1'b0;
      end
      if(_zz_when_Stream_l393) begin
        _zz_io_output_rsp_payload_last_1 <= 1'b0;
      end
      if(_zz_1) begin
        _zz_io_output_rsp_payload_last_1 <= 1'b1;
      end
      if(_zz_1) begin
        _zz_when_Stream_l393_2 <= (_zz_when_Stream_l393 || (! _zz_io_output_rsp_payload_last_1));
      end
    end
  end

  always @(posedge clk_out1) begin
    readEnd_regNext <= readEnd;
    readEnd_regNext_1 <= readEnd;
    _zz_adapter_writeEndHistory_1 <= _zz_adapter_writeEndHistory;
    _zz_adapter_writeEndHistory_2 <= _zz_adapter_writeEndHistory_1;
    _zz_adapter_writeEndHistory_3 <= _zz_adapter_writeEndHistory_2;
    _zz_io_writeEnd_valid_1 <= _zz_io_writeEnd_valid;
    if(_zz_io_input_rsp_ready) begin
      _zz_io_output_rsp_payload_last_2 <= _zz_io_output_rsp_payload_last;
      _zz_io_output_rsp_payload_fragment_opcode_1 <= _zz_io_output_rsp_payload_fragment_opcode;
      _zz_io_output_rsp_payload_fragment_data_1 <= _zz_io_output_rsp_payload_fragment_data;
      _zz_io_output_rsp_payload_fragment_context_1 <= _zz_io_output_rsp_payload_fragment_context;
    end
    if(_zz_1) begin
      _zz_io_output_rsp_payload_last_3 <= (_zz_io_output_rsp_payload_last_1 ? _zz_io_output_rsp_payload_last : _zz_io_output_rsp_payload_last_2);
      _zz_io_output_rsp_payload_fragment_opcode_2 <= (_zz_io_output_rsp_payload_last_1 ? _zz_io_output_rsp_payload_fragment_opcode : _zz_io_output_rsp_payload_fragment_opcode_1);
      _zz_io_output_rsp_payload_fragment_data_2 <= (_zz_io_output_rsp_payload_last_1 ? _zz_io_output_rsp_payload_fragment_data : _zz_io_output_rsp_payload_fragment_data_1);
      _zz_io_output_rsp_payload_fragment_context_2 <= (_zz_io_output_rsp_payload_last_1 ? _zz_io_output_rsp_payload_fragment_context : _zz_io_output_rsp_payload_fragment_context_1);
    end
  end

  always @(posedge clk_out4 or negedge rstN) begin
    if(!rstN) begin
      adapter_bmbClockArea_BmbMux <= 1'b0;
    end else begin
      if(when_Axi4StreamToBmb_l97) begin
        adapter_bmbClockArea_BmbMux <= 1'b1;
      end
      if(adapter_bmbClockArea_bmbRdGen_io_end) begin
        adapter_bmbClockArea_BmbMux <= 1'b0;
      end
    end
  end

  always @(posedge clk_out4) begin
    adapter_bmbClockArea_BmbMux_regNext <= adapter_bmbClockArea_BmbMux;
  end


endmodule
