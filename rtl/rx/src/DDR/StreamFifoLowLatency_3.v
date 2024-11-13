// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : StreamFifoLowLatency_3
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module StreamFifoLowLatency_3 (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire          io_push_payload_write,
  input  wire [28:0]   io_push_payload_address,
  input  wire [17:0]   io_push_payload_context,
  input  wire          io_push_payload_burstLast,
  input  wire [1:0]    io_push_payload_length,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire          io_pop_payload_write,
  output wire [28:0]   io_pop_payload_address,
  output wire [17:0]   io_pop_payload_context,
  output wire          io_pop_payload_burstLast,
  output wire [1:0]    io_pop_payload_length,
  input  wire          io_flush,
  output wire [6:0]    io_occupancy,
  output wire [6:0]    io_availability,
  input  wire          clk_out4,
  input  wire          rstN
);

  wire                fifo_io_push_ready;
  wire                fifo_io_pop_valid;
  wire                fifo_io_pop_payload_write;
  wire       [28:0]   fifo_io_pop_payload_address;
  wire       [17:0]   fifo_io_pop_payload_context;
  wire                fifo_io_pop_payload_burstLast;
  wire       [1:0]    fifo_io_pop_payload_length;
  wire       [6:0]    fifo_io_occupancy;
  wire       [6:0]    fifo_io_availability;

  StreamFifo_4 fifo (
    .io_push_valid             (io_push_valid                    ), //i
    .io_push_ready             (fifo_io_push_ready               ), //o
    .io_push_payload_write     (io_push_payload_write            ), //i
    .io_push_payload_address   (io_push_payload_address[28:0]    ), //i
    .io_push_payload_context   (io_push_payload_context[17:0]    ), //i
    .io_push_payload_burstLast (io_push_payload_burstLast        ), //i
    .io_push_payload_length    (io_push_payload_length[1:0]      ), //i
    .io_pop_valid              (fifo_io_pop_valid                ), //o
    .io_pop_ready              (io_pop_ready                     ), //i
    .io_pop_payload_write      (fifo_io_pop_payload_write        ), //o
    .io_pop_payload_address    (fifo_io_pop_payload_address[28:0]), //o
    .io_pop_payload_context    (fifo_io_pop_payload_context[17:0]), //o
    .io_pop_payload_burstLast  (fifo_io_pop_payload_burstLast    ), //o
    .io_pop_payload_length     (fifo_io_pop_payload_length[1:0]  ), //o
    .io_flush                  (io_flush                         ), //i
    .io_occupancy              (fifo_io_occupancy[6:0]           ), //o
    .io_availability           (fifo_io_availability[6:0]        ), //o
    .clk_out4                  (clk_out4                         ), //i
    .rstN                      (rstN                             )  //i
  );
  assign io_push_ready = fifo_io_push_ready;
  assign io_pop_valid = fifo_io_pop_valid;
  assign io_pop_payload_write = fifo_io_pop_payload_write;
  assign io_pop_payload_address = fifo_io_pop_payload_address;
  assign io_pop_payload_context = fifo_io_pop_payload_context;
  assign io_pop_payload_burstLast = fifo_io_pop_payload_burstLast;
  assign io_pop_payload_length = fifo_io_pop_payload_length;
  assign io_occupancy = fifo_io_occupancy;
  assign io_availability = fifo_io_availability;

endmodule
