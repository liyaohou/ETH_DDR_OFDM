// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : RdAlignment
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module RdAlignment (
  input  wire          io_phaseClear,
  input  wire          io_dfiRd_0_rddataValid,
  input  wire [31:0]   io_dfiRd_0_rddata,
  output wire          io_idfiRd_0_valid,
  input  wire          io_idfiRd_0_ready,
  output wire          io_idfiRd_0_payload_last,
  output wire [31:0]   io_idfiRd_0_payload_fragment_rdData,
  input  wire          clk_out4,
  input  wire          rstN
);

  reg                 rdDataFifos_0_rdDataFifo_io_flush;
  wire                rdDataFifos_0_rdDataFifo_io_push_ready;
  wire                rdDataFifos_0_rdDataFifo_io_pop_valid;
  wire                rdDataFifos_0_rdDataFifo_io_pop_payload_last;
  wire       [31:0]   rdDataFifos_0_rdDataFifo_io_pop_payload_fragment_rdData;
  wire       [2:0]    rdDataFifos_0_rdDataFifo_io_occupancy;
  wire       [2:0]    rdDataFifos_0_rdDataFifo_io_availability;
  wire                rdDataTemp_0_valid;
  wire                rdDataTemp_0_ready;
  wire                rdDataTemp_0_payload_last;
  reg        [31:0]   rdDataTemp_0_payload_fragment_rdData;
  reg        [0:0]    rdDataPhase;
  wire                rdDataTemp_0_fire;
  reg        [31:0]   _zz_rdDataTemp_0_payload_fragment_rdData;
  wire                readyForPop;
  reg                 readyForPop_regNext;

  StreamFifo_8 rdDataFifos_0_rdDataFifo (
    .io_push_valid                   (rdDataTemp_0_valid                                           ), //i
    .io_push_ready                   (rdDataFifos_0_rdDataFifo_io_push_ready                       ), //o
    .io_push_payload_last            (rdDataTemp_0_payload_last                                    ), //i
    .io_push_payload_fragment_rdData (rdDataTemp_0_payload_fragment_rdData[31:0]                   ), //i
    .io_pop_valid                    (rdDataFifos_0_rdDataFifo_io_pop_valid                        ), //o
    .io_pop_ready                    (readyForPop_regNext                                          ), //i
    .io_pop_payload_last             (rdDataFifos_0_rdDataFifo_io_pop_payload_last                 ), //o
    .io_pop_payload_fragment_rdData  (rdDataFifos_0_rdDataFifo_io_pop_payload_fragment_rdData[31:0]), //o
    .io_flush                        (rdDataFifos_0_rdDataFifo_io_flush                            ), //i
    .io_occupancy                    (rdDataFifos_0_rdDataFifo_io_occupancy[2:0]                   ), //o
    .io_availability                 (rdDataFifos_0_rdDataFifo_io_availability[2:0]                ), //o
    .clk_out4                        (clk_out4                                                     ), //i
    .rstN                            (rstN                                                         )  //i
  );
  assign rdDataTemp_0_payload_last = 1'b0;
  assign rdDataTemp_0_valid = io_dfiRd_0_rddataValid;
  always @(*) begin
    rdDataTemp_0_payload_fragment_rdData = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    if(rdDataTemp_0_fire) begin
      rdDataTemp_0_payload_fragment_rdData = _zz_rdDataTemp_0_payload_fragment_rdData;
    end
  end

  assign rdDataTemp_0_fire = (rdDataTemp_0_valid && rdDataTemp_0_ready);
  always @(*) begin
    _zz_rdDataTemp_0_payload_fragment_rdData = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    _zz_rdDataTemp_0_payload_fragment_rdData = io_dfiRd_0_rddata;
  end

  always @(*) begin
    rdDataFifos_0_rdDataFifo_io_flush = 1'b0;
    if(io_phaseClear) begin
      rdDataFifos_0_rdDataFifo_io_flush = 1'b1;
    end
  end

  assign readyForPop = ((&(rdDataFifos_0_rdDataFifo_io_occupancy != 3'b000)) ? (|io_idfiRd_0_ready) : 1'b0);
  assign rdDataTemp_0_ready = rdDataFifos_0_rdDataFifo_io_push_ready;
  assign io_idfiRd_0_valid = (&rdDataFifos_0_rdDataFifo_io_pop_valid);
  assign io_idfiRd_0_payload_last = rdDataFifos_0_rdDataFifo_io_pop_payload_last;
  assign io_idfiRd_0_payload_fragment_rdData = rdDataFifos_0_rdDataFifo_io_pop_payload_fragment_rdData;
  always @(posedge clk_out4 or negedge rstN) begin
    if(!rstN) begin
      rdDataPhase <= 1'b0;
    end else begin
      rdDataPhase <= 1'b0;
      if(rdDataTemp_0_fire) begin
        rdDataPhase <= 1'b0;
      end
    end
  end

  always @(posedge clk_out4) begin
    readyForPop_regNext <= readyForPop;
  end


endmodule
