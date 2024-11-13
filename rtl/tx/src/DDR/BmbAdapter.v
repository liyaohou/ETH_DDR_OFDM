// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : BmbAdapter
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module BmbAdapter (
  input  wire          io_halt,
  input  wire          io_input_cmd_valid,
  output wire          io_input_cmd_ready,
  input  wire          io_input_cmd_payload_last,
  input  wire [0:0]    io_input_cmd_payload_fragment_opcode,
  input  wire [28:0]   io_input_cmd_payload_fragment_address,
  input  wire [9:0]    io_input_cmd_payload_fragment_length,
  input  wire [31:0]   io_input_cmd_payload_fragment_data,
  input  wire [3:0]    io_input_cmd_payload_fragment_mask,
  input  wire [3:0]    io_input_cmd_payload_fragment_context,
  output wire          io_input_rsp_valid,
  input  wire          io_input_rsp_ready,
  output wire          io_input_rsp_payload_last,
  output wire [0:0]    io_input_rsp_payload_fragment_opcode,
  output wire [31:0]   io_input_rsp_payload_fragment_data,
  output wire [3:0]    io_input_rsp_payload_fragment_context,
  output wire          io_output_cmd_valid,
  input  wire          io_output_cmd_ready,
  output wire          io_output_cmd_payload_write,
  output wire [28:0]   io_output_cmd_payload_address,
  output wire [17:0]   io_output_cmd_payload_context,
  output wire          io_output_cmd_payload_burstLast,
  output wire [1:0]    io_output_cmd_payload_length,
  output wire          io_output_writeData_valid,
  input  wire          io_output_writeData_ready,
  output wire [31:0]   io_output_writeData_payload_data,
  output wire [3:0]    io_output_writeData_payload_mask,
  output wire          io_output_writeDataToken_valid,
  input  wire          io_output_writeDataToken_ready,
  output wire          io_output_writeDataToken_payload_valid,
  output wire          io_output_writeDataToken_payload_ready,
  input  wire          io_output_rsp_valid,
  output wire          io_output_rsp_ready,
  input  wire          io_output_rsp_payload_last,
  input  wire [31:0]   io_output_rsp_payload_fragment_data,
  input  wire [17:0]   io_output_rsp_payload_fragment_context,
  input  wire          clk_out4,
  input  wire          rstN
);

  reg                 inputLogic_spliter_io_output_cmd_ready;
  wire                inputLogic_converter_io_output_writeDataToken_ready;
  wire                inputLogic_aligner_io_input_cmd_ready;
  wire                inputLogic_aligner_io_input_rsp_valid;
  wire                inputLogic_aligner_io_input_rsp_payload_last;
  wire       [0:0]    inputLogic_aligner_io_input_rsp_payload_fragment_opcode;
  wire       [31:0]   inputLogic_aligner_io_input_rsp_payload_fragment_data;
  wire       [3:0]    inputLogic_aligner_io_input_rsp_payload_fragment_context;
  wire                inputLogic_aligner_io_output_cmd_valid;
  wire                inputLogic_aligner_io_output_cmd_payload_last;
  wire       [0:0]    inputLogic_aligner_io_output_cmd_payload_fragment_opcode;
  wire       [28:0]   inputLogic_aligner_io_output_cmd_payload_fragment_address;
  wire       [10:0]   inputLogic_aligner_io_output_cmd_payload_fragment_length;
  wire       [31:0]   inputLogic_aligner_io_output_cmd_payload_fragment_data;
  wire       [3:0]    inputLogic_aligner_io_output_cmd_payload_fragment_mask;
  wire       [15:0]   inputLogic_aligner_io_output_cmd_payload_fragment_context;
  wire                inputLogic_aligner_io_output_rsp_ready;
  wire                inputLogic_spliter_io_input_cmd_ready;
  wire                inputLogic_spliter_io_input_rsp_valid;
  wire                inputLogic_spliter_io_input_rsp_payload_last;
  wire       [0:0]    inputLogic_spliter_io_input_rsp_payload_fragment_opcode;
  wire       [31:0]   inputLogic_spliter_io_input_rsp_payload_fragment_data;
  wire       [15:0]   inputLogic_spliter_io_input_rsp_payload_fragment_context;
  wire                inputLogic_spliter_io_output_cmd_valid;
  wire                inputLogic_spliter_io_output_cmd_payload_last;
  wire       [0:0]    inputLogic_spliter_io_output_cmd_payload_fragment_opcode;
  wire       [28:0]   inputLogic_spliter_io_output_cmd_payload_fragment_address;
  wire       [5:0]    inputLogic_spliter_io_output_cmd_payload_fragment_length;
  wire       [31:0]   inputLogic_spliter_io_output_cmd_payload_fragment_data;
  wire       [3:0]    inputLogic_spliter_io_output_cmd_payload_fragment_mask;
  wire       [17:0]   inputLogic_spliter_io_output_cmd_payload_fragment_context;
  wire                inputLogic_spliter_io_output_rsp_ready;
  wire                inputLogic_spliter_io_outputBurstLast;
  wire                inputLogic_converter_io_input_cmd_ready;
  wire                inputLogic_converter_io_input_rsp_valid;
  wire                inputLogic_converter_io_input_rsp_payload_last;
  wire       [0:0]    inputLogic_converter_io_input_rsp_payload_fragment_opcode;
  wire       [31:0]   inputLogic_converter_io_input_rsp_payload_fragment_data;
  wire       [17:0]   inputLogic_converter_io_input_rsp_payload_fragment_context;
  wire                inputLogic_converter_io_output_cmd_valid;
  wire                inputLogic_converter_io_output_cmd_payload_write;
  wire       [28:0]   inputLogic_converter_io_output_cmd_payload_address;
  wire       [17:0]   inputLogic_converter_io_output_cmd_payload_context;
  wire                inputLogic_converter_io_output_cmd_payload_burstLast;
  wire       [1:0]    inputLogic_converter_io_output_cmd_payload_length;
  wire                inputLogic_converter_io_output_writeDataToken_valid;
  wire                inputLogic_converter_io_output_writeDataToken_payload_valid;
  wire                inputLogic_converter_io_output_writeDataToken_payload_ready;
  wire                inputLogic_converter_io_output_writeData_valid;
  wire       [31:0]   inputLogic_converter_io_output_writeData_payload_data;
  wire       [3:0]    inputLogic_converter_io_output_writeData_payload_mask;
  wire                inputLogic_converter_io_output_rsp_ready;
  wire                io_output_cmd_fifo_io_push_ready;
  wire                io_output_cmd_fifo_io_pop_valid;
  wire                io_output_cmd_fifo_io_pop_payload_write;
  wire       [28:0]   io_output_cmd_fifo_io_pop_payload_address;
  wire       [17:0]   io_output_cmd_fifo_io_pop_payload_context;
  wire                io_output_cmd_fifo_io_pop_payload_burstLast;
  wire       [1:0]    io_output_cmd_fifo_io_pop_payload_length;
  wire       [6:0]    io_output_cmd_fifo_io_occupancy;
  wire       [6:0]    io_output_cmd_fifo_io_availability;
  wire                io_output_rsp_fifo_io_push_ready;
  wire                io_output_rsp_fifo_io_pop_valid;
  wire                io_output_rsp_fifo_io_pop_payload_last;
  wire       [31:0]   io_output_rsp_fifo_io_pop_payload_fragment_data;
  wire       [17:0]   io_output_rsp_fifo_io_pop_payload_fragment_context;
  wire       [6:0]    io_output_rsp_fifo_io_occupancy;
  wire       [6:0]    io_output_rsp_fifo_io_availability;
  wire                io_output_writeData_fifo_io_push_ready;
  wire                io_output_writeData_fifo_io_pop_valid;
  wire       [31:0]   io_output_writeData_fifo_io_pop_payload_data;
  wire       [3:0]    io_output_writeData_fifo_io_pop_payload_mask;
  wire       [6:0]    io_output_writeData_fifo_io_occupancy;
  wire       [6:0]    io_output_writeData_fifo_io_availability;
  wire       [6:0]    _zz_writeTokens_counter;
  wire       [6:0]    _zz_writeTokens_counter_1;
  wire       [6:0]    _zz_writeTokens_counter_2;
  wire       [2:0]    _zz_writeTokens_counter_3;
  wire                inputLogic_spliter_io_output_cmd_m2sPipe_valid;
  wire                inputLogic_spliter_io_output_cmd_m2sPipe_ready;
  wire                inputLogic_spliter_io_output_cmd_m2sPipe_payload_last;
  wire       [0:0]    inputLogic_spliter_io_output_cmd_m2sPipe_payload_fragment_opcode;
  wire       [28:0]   inputLogic_spliter_io_output_cmd_m2sPipe_payload_fragment_address;
  wire       [5:0]    inputLogic_spliter_io_output_cmd_m2sPipe_payload_fragment_length;
  wire       [31:0]   inputLogic_spliter_io_output_cmd_m2sPipe_payload_fragment_data;
  wire       [3:0]    inputLogic_spliter_io_output_cmd_m2sPipe_payload_fragment_mask;
  wire       [17:0]   inputLogic_spliter_io_output_cmd_m2sPipe_payload_fragment_context;
  reg                 inputLogic_spliter_io_output_cmd_rValid;
  reg                 inputLogic_spliter_io_output_cmd_rData_last;
  reg        [0:0]    inputLogic_spliter_io_output_cmd_rData_fragment_opcode;
  reg        [28:0]   inputLogic_spliter_io_output_cmd_rData_fragment_address;
  reg        [5:0]    inputLogic_spliter_io_output_cmd_rData_fragment_length;
  reg        [31:0]   inputLogic_spliter_io_output_cmd_rData_fragment_data;
  reg        [3:0]    inputLogic_spliter_io_output_cmd_rData_fragment_mask;
  reg        [17:0]   inputLogic_spliter_io_output_cmd_rData_fragment_context;
  wire                when_Stream_l393;
  wire                cmdAddress_valid;
  reg                 cmdAddress_ready;
  wire                cmdAddress_payload_write;
  wire       [28:0]   cmdAddress_payload_address;
  wire       [17:0]   cmdAddress_payload_context;
  wire                cmdAddress_payload_burstLast;
  wire       [1:0]    cmdAddress_payload_length;
  wire       [0:0]    writeDataToken;
  wire                inputLogic_converter_io_output_writeData_fire;
  reg        [0:0]    _zz_writeDataToken;
  reg        [6:0]    writeTokens_counter;
  reg                 _zz_io_output_writeDataToken_valid;
  wire                when_Bmb2PreTaskPort_l119;
  wire                when_Bmb2PreTaskPort_l119_1;
  wire                cmdAddress_m2sPipe_valid;
  wire                cmdAddress_m2sPipe_ready;
  wire                cmdAddress_m2sPipe_payload_write;
  wire       [28:0]   cmdAddress_m2sPipe_payload_address;
  wire       [17:0]   cmdAddress_m2sPipe_payload_context;
  wire                cmdAddress_m2sPipe_payload_burstLast;
  wire       [1:0]    cmdAddress_m2sPipe_payload_length;
  reg                 cmdAddress_rValid;
  reg                 cmdAddress_rData_write;
  reg        [28:0]   cmdAddress_rData_address;
  reg        [17:0]   cmdAddress_rData_context;
  reg                 cmdAddress_rData_burstLast;
  reg        [1:0]    cmdAddress_rData_length;
  wire                when_Stream_l393_1;
  reg                 io_halt_regNext;
  wire                _zz_io_output_cmd_valid;
  wire                io_output_rsp_isStall;

  assign _zz_writeTokens_counter = (writeTokens_counter + _zz_writeTokens_counter_1);
  assign _zz_writeTokens_counter_1 = {6'd0, writeDataToken};
  assign _zz_writeTokens_counter_3 = ({2'd0,io_output_writeDataToken_ready} <<< 2'd2);
  assign _zz_writeTokens_counter_2 = {4'd0, _zz_writeTokens_counter_3};
  BmbAligner inputLogic_aligner (
    .io_input_cmd_valid                     (io_input_cmd_valid                                             ), //i
    .io_input_cmd_ready                     (inputLogic_aligner_io_input_cmd_ready                          ), //o
    .io_input_cmd_payload_last              (io_input_cmd_payload_last                                      ), //i
    .io_input_cmd_payload_fragment_opcode   (io_input_cmd_payload_fragment_opcode                           ), //i
    .io_input_cmd_payload_fragment_address  (io_input_cmd_payload_fragment_address[28:0]                    ), //i
    .io_input_cmd_payload_fragment_length   (io_input_cmd_payload_fragment_length[9:0]                      ), //i
    .io_input_cmd_payload_fragment_data     (io_input_cmd_payload_fragment_data[31:0]                       ), //i
    .io_input_cmd_payload_fragment_mask     (io_input_cmd_payload_fragment_mask[3:0]                        ), //i
    .io_input_cmd_payload_fragment_context  (io_input_cmd_payload_fragment_context[3:0]                     ), //i
    .io_input_rsp_valid                     (inputLogic_aligner_io_input_rsp_valid                          ), //o
    .io_input_rsp_ready                     (io_input_rsp_ready                                             ), //i
    .io_input_rsp_payload_last              (inputLogic_aligner_io_input_rsp_payload_last                   ), //o
    .io_input_rsp_payload_fragment_opcode   (inputLogic_aligner_io_input_rsp_payload_fragment_opcode        ), //o
    .io_input_rsp_payload_fragment_data     (inputLogic_aligner_io_input_rsp_payload_fragment_data[31:0]    ), //o
    .io_input_rsp_payload_fragment_context  (inputLogic_aligner_io_input_rsp_payload_fragment_context[3:0]  ), //o
    .io_output_cmd_valid                    (inputLogic_aligner_io_output_cmd_valid                         ), //o
    .io_output_cmd_ready                    (inputLogic_spliter_io_input_cmd_ready                          ), //i
    .io_output_cmd_payload_last             (inputLogic_aligner_io_output_cmd_payload_last                  ), //o
    .io_output_cmd_payload_fragment_opcode  (inputLogic_aligner_io_output_cmd_payload_fragment_opcode       ), //o
    .io_output_cmd_payload_fragment_address (inputLogic_aligner_io_output_cmd_payload_fragment_address[28:0]), //o
    .io_output_cmd_payload_fragment_length  (inputLogic_aligner_io_output_cmd_payload_fragment_length[10:0] ), //o
    .io_output_cmd_payload_fragment_data    (inputLogic_aligner_io_output_cmd_payload_fragment_data[31:0]   ), //o
    .io_output_cmd_payload_fragment_mask    (inputLogic_aligner_io_output_cmd_payload_fragment_mask[3:0]    ), //o
    .io_output_cmd_payload_fragment_context (inputLogic_aligner_io_output_cmd_payload_fragment_context[15:0]), //o
    .io_output_rsp_valid                    (inputLogic_spliter_io_input_rsp_valid                          ), //i
    .io_output_rsp_ready                    (inputLogic_aligner_io_output_rsp_ready                         ), //o
    .io_output_rsp_payload_last             (inputLogic_spliter_io_input_rsp_payload_last                   ), //i
    .io_output_rsp_payload_fragment_opcode  (inputLogic_spliter_io_input_rsp_payload_fragment_opcode        ), //i
    .io_output_rsp_payload_fragment_data    (inputLogic_spliter_io_input_rsp_payload_fragment_data[31:0]    ), //i
    .io_output_rsp_payload_fragment_context (inputLogic_spliter_io_input_rsp_payload_fragment_context[15:0] ), //i
    .clk_out4                               (clk_out4                                                       ), //i
    .rstN                                   (rstN                                                           )  //i
  );
  BmbAlignedSpliter inputLogic_spliter (
    .io_input_cmd_valid                     (inputLogic_aligner_io_output_cmd_valid                          ), //i
    .io_input_cmd_ready                     (inputLogic_spliter_io_input_cmd_ready                           ), //o
    .io_input_cmd_payload_last              (inputLogic_aligner_io_output_cmd_payload_last                   ), //i
    .io_input_cmd_payload_fragment_opcode   (inputLogic_aligner_io_output_cmd_payload_fragment_opcode        ), //i
    .io_input_cmd_payload_fragment_address  (inputLogic_aligner_io_output_cmd_payload_fragment_address[28:0] ), //i
    .io_input_cmd_payload_fragment_length   (inputLogic_aligner_io_output_cmd_payload_fragment_length[10:0]  ), //i
    .io_input_cmd_payload_fragment_data     (inputLogic_aligner_io_output_cmd_payload_fragment_data[31:0]    ), //i
    .io_input_cmd_payload_fragment_mask     (inputLogic_aligner_io_output_cmd_payload_fragment_mask[3:0]     ), //i
    .io_input_cmd_payload_fragment_context  (inputLogic_aligner_io_output_cmd_payload_fragment_context[15:0] ), //i
    .io_input_rsp_valid                     (inputLogic_spliter_io_input_rsp_valid                           ), //o
    .io_input_rsp_ready                     (inputLogic_aligner_io_output_rsp_ready                          ), //i
    .io_input_rsp_payload_last              (inputLogic_spliter_io_input_rsp_payload_last                    ), //o
    .io_input_rsp_payload_fragment_opcode   (inputLogic_spliter_io_input_rsp_payload_fragment_opcode         ), //o
    .io_input_rsp_payload_fragment_data     (inputLogic_spliter_io_input_rsp_payload_fragment_data[31:0]     ), //o
    .io_input_rsp_payload_fragment_context  (inputLogic_spliter_io_input_rsp_payload_fragment_context[15:0]  ), //o
    .io_output_cmd_valid                    (inputLogic_spliter_io_output_cmd_valid                          ), //o
    .io_output_cmd_ready                    (inputLogic_spliter_io_output_cmd_ready                          ), //i
    .io_output_cmd_payload_last             (inputLogic_spliter_io_output_cmd_payload_last                   ), //o
    .io_output_cmd_payload_fragment_opcode  (inputLogic_spliter_io_output_cmd_payload_fragment_opcode        ), //o
    .io_output_cmd_payload_fragment_address (inputLogic_spliter_io_output_cmd_payload_fragment_address[28:0] ), //o
    .io_output_cmd_payload_fragment_length  (inputLogic_spliter_io_output_cmd_payload_fragment_length[5:0]   ), //o
    .io_output_cmd_payload_fragment_data    (inputLogic_spliter_io_output_cmd_payload_fragment_data[31:0]    ), //o
    .io_output_cmd_payload_fragment_mask    (inputLogic_spliter_io_output_cmd_payload_fragment_mask[3:0]     ), //o
    .io_output_cmd_payload_fragment_context (inputLogic_spliter_io_output_cmd_payload_fragment_context[17:0] ), //o
    .io_output_rsp_valid                    (inputLogic_converter_io_input_rsp_valid                         ), //i
    .io_output_rsp_ready                    (inputLogic_spliter_io_output_rsp_ready                          ), //o
    .io_output_rsp_payload_last             (inputLogic_converter_io_input_rsp_payload_last                  ), //i
    .io_output_rsp_payload_fragment_opcode  (inputLogic_converter_io_input_rsp_payload_fragment_opcode       ), //i
    .io_output_rsp_payload_fragment_data    (inputLogic_converter_io_input_rsp_payload_fragment_data[31:0]   ), //i
    .io_output_rsp_payload_fragment_context (inputLogic_converter_io_input_rsp_payload_fragment_context[17:0]), //i
    .io_outputBurstLast                     (inputLogic_spliter_io_outputBurstLast                           ), //o
    .clk_out4                               (clk_out4                                                        ), //i
    .rstN                                   (rstN                                                            )  //i
  );
  BmbToPreTaskPort inputLogic_converter (
    .io_input_cmd_valid                     (inputLogic_spliter_io_output_cmd_m2sPipe_valid                         ), //i
    .io_input_cmd_ready                     (inputLogic_converter_io_input_cmd_ready                                ), //o
    .io_input_cmd_payload_last              (inputLogic_spliter_io_output_cmd_m2sPipe_payload_last                  ), //i
    .io_input_cmd_payload_fragment_opcode   (inputLogic_spliter_io_output_cmd_m2sPipe_payload_fragment_opcode       ), //i
    .io_input_cmd_payload_fragment_address  (inputLogic_spliter_io_output_cmd_m2sPipe_payload_fragment_address[28:0]), //i
    .io_input_cmd_payload_fragment_length   (inputLogic_spliter_io_output_cmd_m2sPipe_payload_fragment_length[5:0]  ), //i
    .io_input_cmd_payload_fragment_data     (inputLogic_spliter_io_output_cmd_m2sPipe_payload_fragment_data[31:0]   ), //i
    .io_input_cmd_payload_fragment_mask     (inputLogic_spliter_io_output_cmd_m2sPipe_payload_fragment_mask[3:0]    ), //i
    .io_input_cmd_payload_fragment_context  (inputLogic_spliter_io_output_cmd_m2sPipe_payload_fragment_context[17:0]), //i
    .io_input_rsp_valid                     (inputLogic_converter_io_input_rsp_valid                                ), //o
    .io_input_rsp_ready                     (inputLogic_spliter_io_output_rsp_ready                                 ), //i
    .io_input_rsp_payload_last              (inputLogic_converter_io_input_rsp_payload_last                         ), //o
    .io_input_rsp_payload_fragment_opcode   (inputLogic_converter_io_input_rsp_payload_fragment_opcode              ), //o
    .io_input_rsp_payload_fragment_data     (inputLogic_converter_io_input_rsp_payload_fragment_data[31:0]          ), //o
    .io_input_rsp_payload_fragment_context  (inputLogic_converter_io_input_rsp_payload_fragment_context[17:0]       ), //o
    .io_inputBurstLast                      (inputLogic_spliter_io_outputBurstLast                                  ), //i
    .io_output_cmd_valid                    (inputLogic_converter_io_output_cmd_valid                               ), //o
    .io_output_cmd_ready                    (io_output_cmd_fifo_io_push_ready                                       ), //i
    .io_output_cmd_payload_write            (inputLogic_converter_io_output_cmd_payload_write                       ), //o
    .io_output_cmd_payload_address          (inputLogic_converter_io_output_cmd_payload_address[28:0]               ), //o
    .io_output_cmd_payload_context          (inputLogic_converter_io_output_cmd_payload_context[17:0]               ), //o
    .io_output_cmd_payload_burstLast        (inputLogic_converter_io_output_cmd_payload_burstLast                   ), //o
    .io_output_cmd_payload_length           (inputLogic_converter_io_output_cmd_payload_length[1:0]                 ), //o
    .io_output_writeData_valid              (inputLogic_converter_io_output_writeData_valid                         ), //o
    .io_output_writeData_ready              (io_output_writeData_fifo_io_push_ready                                 ), //i
    .io_output_writeData_payload_data       (inputLogic_converter_io_output_writeData_payload_data[31:0]            ), //o
    .io_output_writeData_payload_mask       (inputLogic_converter_io_output_writeData_payload_mask[3:0]             ), //o
    .io_output_writeDataToken_valid         (inputLogic_converter_io_output_writeDataToken_valid                    ), //o
    .io_output_writeDataToken_ready         (inputLogic_converter_io_output_writeDataToken_ready                    ), //i
    .io_output_writeDataToken_payload_valid (inputLogic_converter_io_output_writeDataToken_payload_valid            ), //o
    .io_output_writeDataToken_payload_ready (inputLogic_converter_io_output_writeDataToken_payload_ready            ), //o
    .io_output_rsp_valid                    (io_output_rsp_fifo_io_pop_valid                                        ), //i
    .io_output_rsp_ready                    (inputLogic_converter_io_output_rsp_ready                               ), //o
    .io_output_rsp_payload_last             (io_output_rsp_fifo_io_pop_payload_last                                 ), //i
    .io_output_rsp_payload_fragment_data    (io_output_rsp_fifo_io_pop_payload_fragment_data[31:0]                  ), //i
    .io_output_rsp_payload_fragment_context (io_output_rsp_fifo_io_pop_payload_fragment_context[17:0]               ), //i
    .clk_out4                               (clk_out4                                                               ), //i
    .rstN                                   (rstN                                                                   )  //i
  );
  StreamFifoLowLatency_1 io_output_cmd_fifo (
    .io_push_valid             (inputLogic_converter_io_output_cmd_valid                ), //i
    .io_push_ready             (io_output_cmd_fifo_io_push_ready                        ), //o
    .io_push_payload_write     (inputLogic_converter_io_output_cmd_payload_write        ), //i
    .io_push_payload_address   (inputLogic_converter_io_output_cmd_payload_address[28:0]), //i
    .io_push_payload_context   (inputLogic_converter_io_output_cmd_payload_context[17:0]), //i
    .io_push_payload_burstLast (inputLogic_converter_io_output_cmd_payload_burstLast    ), //i
    .io_push_payload_length    (inputLogic_converter_io_output_cmd_payload_length[1:0]  ), //i
    .io_pop_valid              (io_output_cmd_fifo_io_pop_valid                         ), //o
    .io_pop_ready              (cmdAddress_ready                                        ), //i
    .io_pop_payload_write      (io_output_cmd_fifo_io_pop_payload_write                 ), //o
    .io_pop_payload_address    (io_output_cmd_fifo_io_pop_payload_address[28:0]         ), //o
    .io_pop_payload_context    (io_output_cmd_fifo_io_pop_payload_context[17:0]         ), //o
    .io_pop_payload_burstLast  (io_output_cmd_fifo_io_pop_payload_burstLast             ), //o
    .io_pop_payload_length     (io_output_cmd_fifo_io_pop_payload_length[1:0]           ), //o
    .io_flush                  (1'b0                                                    ), //i
    .io_occupancy              (io_output_cmd_fifo_io_occupancy[6:0]                    ), //o
    .io_availability           (io_output_cmd_fifo_io_availability[6:0]                 ), //o
    .clk_out4                  (clk_out4                                                ), //i
    .rstN                      (rstN                                                    )  //i
  );
  StreamFifoLowLatency_2 io_output_rsp_fifo (
    .io_push_valid                    (io_output_rsp_valid                                     ), //i
    .io_push_ready                    (io_output_rsp_fifo_io_push_ready                        ), //o
    .io_push_payload_last             (io_output_rsp_payload_last                              ), //i
    .io_push_payload_fragment_data    (io_output_rsp_payload_fragment_data[31:0]               ), //i
    .io_push_payload_fragment_context (io_output_rsp_payload_fragment_context[17:0]            ), //i
    .io_pop_valid                     (io_output_rsp_fifo_io_pop_valid                         ), //o
    .io_pop_ready                     (inputLogic_converter_io_output_rsp_ready                ), //i
    .io_pop_payload_last              (io_output_rsp_fifo_io_pop_payload_last                  ), //o
    .io_pop_payload_fragment_data     (io_output_rsp_fifo_io_pop_payload_fragment_data[31:0]   ), //o
    .io_pop_payload_fragment_context  (io_output_rsp_fifo_io_pop_payload_fragment_context[17:0]), //o
    .io_flush                         (1'b0                                                    ), //i
    .io_occupancy                     (io_output_rsp_fifo_io_occupancy[6:0]                    ), //o
    .io_availability                  (io_output_rsp_fifo_io_availability[6:0]                 ), //o
    .clk_out4                         (clk_out4                                                ), //i
    .rstN                             (rstN                                                    )  //i
  );
  StreamFifoLowLatency_3 io_output_writeData_fifo (
    .io_push_valid        (inputLogic_converter_io_output_writeData_valid             ), //i
    .io_push_ready        (io_output_writeData_fifo_io_push_ready                     ), //o
    .io_push_payload_data (inputLogic_converter_io_output_writeData_payload_data[31:0]), //i
    .io_push_payload_mask (inputLogic_converter_io_output_writeData_payload_mask[3:0] ), //i
    .io_pop_valid         (io_output_writeData_fifo_io_pop_valid                      ), //o
    .io_pop_ready         (io_output_writeData_ready                                  ), //i
    .io_pop_payload_data  (io_output_writeData_fifo_io_pop_payload_data[31:0]         ), //o
    .io_pop_payload_mask  (io_output_writeData_fifo_io_pop_payload_mask[3:0]          ), //o
    .io_flush             (1'b0                                                       ), //i
    .io_occupancy         (io_output_writeData_fifo_io_occupancy[6:0]                 ), //o
    .io_availability      (io_output_writeData_fifo_io_availability[6:0]              ), //o
    .clk_out4             (clk_out4                                                   ), //i
    .rstN                 (rstN                                                       )  //i
  );
  assign io_input_cmd_ready = inputLogic_aligner_io_input_cmd_ready;
  assign io_input_rsp_valid = inputLogic_aligner_io_input_rsp_valid;
  assign io_input_rsp_payload_last = inputLogic_aligner_io_input_rsp_payload_last;
  assign io_input_rsp_payload_fragment_opcode = inputLogic_aligner_io_input_rsp_payload_fragment_opcode;
  assign io_input_rsp_payload_fragment_data = inputLogic_aligner_io_input_rsp_payload_fragment_data;
  assign io_input_rsp_payload_fragment_context = inputLogic_aligner_io_input_rsp_payload_fragment_context;
  always @(*) begin
    inputLogic_spliter_io_output_cmd_ready = inputLogic_spliter_io_output_cmd_m2sPipe_ready;
    if(when_Stream_l393) begin
      inputLogic_spliter_io_output_cmd_ready = 1'b1;
    end
  end

  assign when_Stream_l393 = (! inputLogic_spliter_io_output_cmd_m2sPipe_valid);
  assign inputLogic_spliter_io_output_cmd_m2sPipe_valid = inputLogic_spliter_io_output_cmd_rValid;
  assign inputLogic_spliter_io_output_cmd_m2sPipe_payload_last = inputLogic_spliter_io_output_cmd_rData_last;
  assign inputLogic_spliter_io_output_cmd_m2sPipe_payload_fragment_opcode = inputLogic_spliter_io_output_cmd_rData_fragment_opcode;
  assign inputLogic_spliter_io_output_cmd_m2sPipe_payload_fragment_address = inputLogic_spliter_io_output_cmd_rData_fragment_address;
  assign inputLogic_spliter_io_output_cmd_m2sPipe_payload_fragment_length = inputLogic_spliter_io_output_cmd_rData_fragment_length;
  assign inputLogic_spliter_io_output_cmd_m2sPipe_payload_fragment_data = inputLogic_spliter_io_output_cmd_rData_fragment_data;
  assign inputLogic_spliter_io_output_cmd_m2sPipe_payload_fragment_mask = inputLogic_spliter_io_output_cmd_rData_fragment_mask;
  assign inputLogic_spliter_io_output_cmd_m2sPipe_payload_fragment_context = inputLogic_spliter_io_output_cmd_rData_fragment_context;
  assign inputLogic_spliter_io_output_cmd_m2sPipe_ready = inputLogic_converter_io_input_cmd_ready;
  assign cmdAddress_valid = io_output_cmd_fifo_io_pop_valid;
  assign cmdAddress_payload_write = io_output_cmd_fifo_io_pop_payload_write;
  assign cmdAddress_payload_address = io_output_cmd_fifo_io_pop_payload_address;
  assign cmdAddress_payload_context = io_output_cmd_fifo_io_pop_payload_context;
  assign cmdAddress_payload_burstLast = io_output_cmd_fifo_io_pop_payload_burstLast;
  assign cmdAddress_payload_length = io_output_cmd_fifo_io_pop_payload_length;
  assign io_output_rsp_ready = io_output_rsp_fifo_io_push_ready;
  assign io_output_writeData_valid = io_output_writeData_fifo_io_pop_valid;
  assign io_output_writeData_payload_data = io_output_writeData_fifo_io_pop_payload_data;
  assign io_output_writeData_payload_mask = io_output_writeData_fifo_io_pop_payload_mask;
  assign inputLogic_converter_io_output_writeData_fire = (inputLogic_converter_io_output_writeData_valid && io_output_writeData_fifo_io_push_ready);
  assign writeDataToken = _zz_writeDataToken;
  assign when_Bmb2PreTaskPort_l119 = (7'h04 <= writeTokens_counter);
  assign when_Bmb2PreTaskPort_l119_1 = (io_output_writeDataToken_ready && (writeTokens_counter < 7'h08));
  assign io_output_writeDataToken_valid = _zz_io_output_writeDataToken_valid;
  always @(*) begin
    cmdAddress_ready = cmdAddress_m2sPipe_ready;
    if(when_Stream_l393_1) begin
      cmdAddress_ready = 1'b1;
    end
  end

  assign when_Stream_l393_1 = (! cmdAddress_m2sPipe_valid);
  assign cmdAddress_m2sPipe_valid = cmdAddress_rValid;
  assign cmdAddress_m2sPipe_payload_write = cmdAddress_rData_write;
  assign cmdAddress_m2sPipe_payload_address = cmdAddress_rData_address;
  assign cmdAddress_m2sPipe_payload_context = cmdAddress_rData_context;
  assign cmdAddress_m2sPipe_payload_burstLast = cmdAddress_rData_burstLast;
  assign cmdAddress_m2sPipe_payload_length = cmdAddress_rData_length;
  assign _zz_io_output_cmd_valid = (! io_halt_regNext);
  assign cmdAddress_m2sPipe_ready = (io_output_cmd_ready && _zz_io_output_cmd_valid);
  assign io_output_cmd_valid = (cmdAddress_m2sPipe_valid && _zz_io_output_cmd_valid);
  assign io_output_cmd_payload_write = cmdAddress_m2sPipe_payload_write;
  assign io_output_cmd_payload_address = cmdAddress_m2sPipe_payload_address;
  assign io_output_cmd_payload_context = cmdAddress_m2sPipe_payload_context;
  assign io_output_cmd_payload_burstLast = cmdAddress_m2sPipe_payload_burstLast;
  assign io_output_cmd_payload_length = cmdAddress_m2sPipe_payload_length;
  assign io_output_rsp_isStall = (io_output_rsp_valid && (! io_output_rsp_ready));
  always @(posedge clk_out4 or negedge rstN) begin
    if(!rstN) begin
      inputLogic_spliter_io_output_cmd_rValid <= 1'b0;
      _zz_writeDataToken <= 1'b0;
      writeTokens_counter <= 7'h0;
      _zz_io_output_writeDataToken_valid <= 1'b0;
      cmdAddress_rValid <= 1'b0;
    end else begin
      if(inputLogic_spliter_io_output_cmd_ready) begin
        inputLogic_spliter_io_output_cmd_rValid <= inputLogic_spliter_io_output_cmd_valid;
      end
      _zz_writeDataToken <= inputLogic_converter_io_output_writeData_fire;
      writeTokens_counter <= (_zz_writeTokens_counter - _zz_writeTokens_counter_2);
      if(when_Bmb2PreTaskPort_l119) begin
        _zz_io_output_writeDataToken_valid <= 1'b1;
      end
      if(when_Bmb2PreTaskPort_l119_1) begin
        _zz_io_output_writeDataToken_valid <= 1'b0;
      end
      if(cmdAddress_ready) begin
        cmdAddress_rValid <= cmdAddress_valid;
      end
      `ifndef SYNTHESIS
        `ifdef FORMAL
          assert((! io_output_rsp_isStall)); // Bmb2PreTaskPort.scala:L126
        `else
          if(!(! io_output_rsp_isStall)) begin
            $display("FAILURE SDRAM rsp buffer stalled !"); // Bmb2PreTaskPort.scala:L126
            $finish;
          end
        `endif
      `endif
    end
  end

  always @(posedge clk_out4) begin
    if(inputLogic_spliter_io_output_cmd_ready) begin
      inputLogic_spliter_io_output_cmd_rData_last <= inputLogic_spliter_io_output_cmd_payload_last;
      inputLogic_spliter_io_output_cmd_rData_fragment_opcode <= inputLogic_spliter_io_output_cmd_payload_fragment_opcode;
      inputLogic_spliter_io_output_cmd_rData_fragment_address <= inputLogic_spliter_io_output_cmd_payload_fragment_address;
      inputLogic_spliter_io_output_cmd_rData_fragment_length <= inputLogic_spliter_io_output_cmd_payload_fragment_length;
      inputLogic_spliter_io_output_cmd_rData_fragment_data <= inputLogic_spliter_io_output_cmd_payload_fragment_data;
      inputLogic_spliter_io_output_cmd_rData_fragment_mask <= inputLogic_spliter_io_output_cmd_payload_fragment_mask;
      inputLogic_spliter_io_output_cmd_rData_fragment_context <= inputLogic_spliter_io_output_cmd_payload_fragment_context;
    end
    if(cmdAddress_ready) begin
      cmdAddress_rData_write <= cmdAddress_payload_write;
      cmdAddress_rData_address <= cmdAddress_payload_address;
      cmdAddress_rData_context <= cmdAddress_payload_context;
      cmdAddress_rData_burstLast <= cmdAddress_payload_burstLast;
      cmdAddress_rData_length <= cmdAddress_payload_length;
    end
    io_halt_regNext <= io_halt;
  end


endmodule
