// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : BmbCcFifo
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module BmbCcFifo (
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
  output wire          io_output_cmd_payload_last,
  output wire [0:0]    io_output_cmd_payload_fragment_opcode,
  output wire [28:0]   io_output_cmd_payload_fragment_address,
  output wire [9:0]    io_output_cmd_payload_fragment_length,
  output wire [31:0]   io_output_cmd_payload_fragment_data,
  output wire [3:0]    io_output_cmd_payload_fragment_mask,
  output wire [3:0]    io_output_cmd_payload_fragment_context,
  input  wire          io_output_rsp_valid,
  output wire          io_output_rsp_ready,
  input  wire          io_output_rsp_payload_last,
  input  wire [0:0]    io_output_rsp_payload_fragment_opcode,
  input  wire [31:0]   io_output_rsp_payload_fragment_data,
  input  wire [3:0]    io_output_rsp_payload_fragment_context,
  input  wire          clk_out1,
  input  wire          rstN,
  input  wire          clk_out4,
  output wire          adapter_bmbCCDomain_axi4StreamToBmb_workClockArea_ddr3AxisTxIf_toplevel_rstN_synchronized_1
);

  wire                io_input_cmd_queue_io_push_ready;
  wire                io_input_cmd_queue_io_pop_valid;
  wire                io_input_cmd_queue_io_pop_payload_last;
  wire       [0:0]    io_input_cmd_queue_io_pop_payload_fragment_opcode;
  wire       [28:0]   io_input_cmd_queue_io_pop_payload_fragment_address;
  wire       [9:0]    io_input_cmd_queue_io_pop_payload_fragment_length;
  wire       [31:0]   io_input_cmd_queue_io_pop_payload_fragment_data;
  wire       [3:0]    io_input_cmd_queue_io_pop_payload_fragment_mask;
  wire       [3:0]    io_input_cmd_queue_io_pop_payload_fragment_context;
  wire       [9:0]    io_input_cmd_queue_io_pushOccupancy;
  wire       [9:0]    io_input_cmd_queue_io_popOccupancy;
  wire                io_input_cmd_queue_adapter_bmbCCDomain_axi4StreamToBmb_workClockArea_ddr3AxisTxIf_toplevel_rstN_synchronized_1;
  wire                io_output_rsp_queue_io_push_ready;
  wire                io_output_rsp_queue_io_pop_valid;
  wire                io_output_rsp_queue_io_pop_payload_last;
  wire       [0:0]    io_output_rsp_queue_io_pop_payload_fragment_opcode;
  wire       [31:0]   io_output_rsp_queue_io_pop_payload_fragment_data;
  wire       [3:0]    io_output_rsp_queue_io_pop_payload_fragment_context;
  wire       [10:0]   io_output_rsp_queue_io_pushOccupancy;
  wire       [10:0]   io_output_rsp_queue_io_popOccupancy;

  StreamFifoCC io_input_cmd_queue (
    .io_push_valid                                                                               (io_input_cmd_valid                                                                                            ), //i
    .io_push_ready                                                                               (io_input_cmd_queue_io_push_ready                                                                              ), //o
    .io_push_payload_last                                                                        (io_input_cmd_payload_last                                                                                     ), //i
    .io_push_payload_fragment_opcode                                                             (io_input_cmd_payload_fragment_opcode                                                                          ), //i
    .io_push_payload_fragment_address                                                            (io_input_cmd_payload_fragment_address[28:0]                                                                   ), //i
    .io_push_payload_fragment_length                                                             (io_input_cmd_payload_fragment_length[9:0]                                                                     ), //i
    .io_push_payload_fragment_data                                                               (io_input_cmd_payload_fragment_data[31:0]                                                                      ), //i
    .io_push_payload_fragment_mask                                                               (io_input_cmd_payload_fragment_mask[3:0]                                                                       ), //i
    .io_push_payload_fragment_context                                                            (io_input_cmd_payload_fragment_context[3:0]                                                                    ), //i
    .io_pop_valid                                                                                (io_input_cmd_queue_io_pop_valid                                                                               ), //o
    .io_pop_ready                                                                                (io_output_cmd_ready                                                                                           ), //i
    .io_pop_payload_last                                                                         (io_input_cmd_queue_io_pop_payload_last                                                                        ), //o
    .io_pop_payload_fragment_opcode                                                              (io_input_cmd_queue_io_pop_payload_fragment_opcode                                                             ), //o
    .io_pop_payload_fragment_address                                                             (io_input_cmd_queue_io_pop_payload_fragment_address[28:0]                                                      ), //o
    .io_pop_payload_fragment_length                                                              (io_input_cmd_queue_io_pop_payload_fragment_length[9:0]                                                        ), //o
    .io_pop_payload_fragment_data                                                                (io_input_cmd_queue_io_pop_payload_fragment_data[31:0]                                                         ), //o
    .io_pop_payload_fragment_mask                                                                (io_input_cmd_queue_io_pop_payload_fragment_mask[3:0]                                                          ), //o
    .io_pop_payload_fragment_context                                                             (io_input_cmd_queue_io_pop_payload_fragment_context[3:0]                                                       ), //o
    .io_pushOccupancy                                                                            (io_input_cmd_queue_io_pushOccupancy[9:0]                                                                      ), //o
    .io_popOccupancy                                                                             (io_input_cmd_queue_io_popOccupancy[9:0]                                                                       ), //o
    .clk_out1                                                                                    (clk_out1                                                                                                      ), //i
    .rstN                                                                                        (rstN                                                                                                          ), //i
    .clk_out4                                                                                    (clk_out4                                                                                                      ), //i
    .adapter_bmbCCDomain_axi4StreamToBmb_workClockArea_ddr3AxisTxIf_toplevel_rstN_synchronized_1 (io_input_cmd_queue_adapter_bmbCCDomain_axi4StreamToBmb_workClockArea_ddr3AxisTxIf_toplevel_rstN_synchronized_1)  //o
  );
  StreamFifoCC_1 io_output_rsp_queue (
    .io_push_valid                    (io_output_rsp_valid                                     ), //i
    .io_push_ready                    (io_output_rsp_queue_io_push_ready                       ), //o
    .io_push_payload_last             (io_output_rsp_payload_last                              ), //i
    .io_push_payload_fragment_opcode  (io_output_rsp_payload_fragment_opcode                   ), //i
    .io_push_payload_fragment_data    (io_output_rsp_payload_fragment_data[31:0]               ), //i
    .io_push_payload_fragment_context (io_output_rsp_payload_fragment_context[3:0]             ), //i
    .io_pop_valid                     (io_output_rsp_queue_io_pop_valid                        ), //o
    .io_pop_ready                     (io_input_rsp_ready                                      ), //i
    .io_pop_payload_last              (io_output_rsp_queue_io_pop_payload_last                 ), //o
    .io_pop_payload_fragment_opcode   (io_output_rsp_queue_io_pop_payload_fragment_opcode      ), //o
    .io_pop_payload_fragment_data     (io_output_rsp_queue_io_pop_payload_fragment_data[31:0]  ), //o
    .io_pop_payload_fragment_context  (io_output_rsp_queue_io_pop_payload_fragment_context[3:0]), //o
    .io_pushOccupancy                 (io_output_rsp_queue_io_pushOccupancy[10:0]              ), //o
    .io_popOccupancy                  (io_output_rsp_queue_io_popOccupancy[10:0]               ), //o
    .clk_out4                         (clk_out4                                                ), //i
    .rstN                             (rstN                                                    ), //i
    .clk_out1                         (clk_out1                                                )  //i
  );
  assign io_input_cmd_ready = io_input_cmd_queue_io_push_ready;
  assign io_output_cmd_valid = io_input_cmd_queue_io_pop_valid;
  assign io_output_cmd_payload_last = io_input_cmd_queue_io_pop_payload_last;
  assign io_output_cmd_payload_fragment_opcode = io_input_cmd_queue_io_pop_payload_fragment_opcode;
  assign io_output_cmd_payload_fragment_address = io_input_cmd_queue_io_pop_payload_fragment_address;
  assign io_output_cmd_payload_fragment_length = io_input_cmd_queue_io_pop_payload_fragment_length;
  assign io_output_cmd_payload_fragment_data = io_input_cmd_queue_io_pop_payload_fragment_data;
  assign io_output_cmd_payload_fragment_mask = io_input_cmd_queue_io_pop_payload_fragment_mask;
  assign io_output_cmd_payload_fragment_context = io_input_cmd_queue_io_pop_payload_fragment_context;
  assign io_output_rsp_ready = io_output_rsp_queue_io_push_ready;
  assign io_input_rsp_valid = io_output_rsp_queue_io_pop_valid;
  assign io_input_rsp_payload_last = io_output_rsp_queue_io_pop_payload_last;
  assign io_input_rsp_payload_fragment_opcode = io_output_rsp_queue_io_pop_payload_fragment_opcode;
  assign io_input_rsp_payload_fragment_data = io_output_rsp_queue_io_pop_payload_fragment_data;
  assign io_input_rsp_payload_fragment_context = io_output_rsp_queue_io_pop_payload_fragment_context;
  assign adapter_bmbCCDomain_axi4StreamToBmb_workClockArea_ddr3AxisTxIf_toplevel_rstN_synchronized_1 = io_input_cmd_queue_adapter_bmbCCDomain_axi4StreamToBmb_workClockArea_ddr3AxisTxIf_toplevel_rstN_synchronized_1;

endmodule
