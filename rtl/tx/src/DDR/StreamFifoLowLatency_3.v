// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : StreamFifoLowLatency_3
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module StreamFifoLowLatency_3 (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [31:0]   io_push_payload_data,
  input  wire [3:0]    io_push_payload_mask,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [31:0]   io_pop_payload_data,
  output wire [3:0]    io_pop_payload_mask,
  input  wire          io_flush,
  output wire [6:0]    io_occupancy,
  output wire [6:0]    io_availability,
  input  wire          clk_out4,
  input  wire          rstN
);

  wire                fifo_io_push_ready;
  wire                fifo_io_pop_valid;
  wire       [31:0]   fifo_io_pop_payload_data;
  wire       [3:0]    fifo_io_pop_payload_mask;
  wire       [6:0]    fifo_io_occupancy;
  wire       [6:0]    fifo_io_availability;

  StreamFifo_3 fifo (
    .io_push_valid        (io_push_valid                 ), //i
    .io_push_ready        (fifo_io_push_ready            ), //o
    .io_push_payload_data (io_push_payload_data[31:0]    ), //i
    .io_push_payload_mask (io_push_payload_mask[3:0]     ), //i
    .io_pop_valid         (fifo_io_pop_valid             ), //o
    .io_pop_ready         (io_pop_ready                  ), //i
    .io_pop_payload_data  (fifo_io_pop_payload_data[31:0]), //o
    .io_pop_payload_mask  (fifo_io_pop_payload_mask[3:0] ), //o
    .io_flush             (io_flush                      ), //i
    .io_occupancy         (fifo_io_occupancy[6:0]        ), //o
    .io_availability      (fifo_io_availability[6:0]     ), //o
    .clk_out4             (clk_out4                      ), //i
    .rstN                 (rstN                          )  //i
  );
  assign io_push_ready = fifo_io_push_ready;
  assign io_pop_valid = fifo_io_pop_valid;
  assign io_pop_payload_data = fifo_io_pop_payload_data;
  assign io_pop_payload_mask = fifo_io_pop_payload_mask;
  assign io_occupancy = fifo_io_occupancy;
  assign io_availability = fifo_io_availability;

endmodule
