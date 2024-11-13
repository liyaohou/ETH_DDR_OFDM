// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : EnergyRemove_Pilots
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module EnergyRemove_Pilots (
  input  wire          EnergyInEn,
  input  wire [9:0]    EnergyIn,
  output wire          EnergyOutEn,
  output wire [9:0]    EnergyOut,
  input  wire          clk_out1,
  input  wire          rstN
);

  wire                fifo_io_push_ready;
  wire                fifo_io_pop_valid;
  wire       [9:0]    fifo_io_pop_payload_Energy;
  wire       [6:0]    fifo_io_occupancy;
  wire       [6:0]    fifo_io_availability;
  wire       [5:0]    _zz_hit;
  wire       [5:0]    _zz_hit_1;
  wire                inputFlow_valid;
  wire       [9:0]    inputFlow_payload_Energy;
  wire                inputStream_valid;
  reg                 inputStream_ready;
  wire       [9:0]    inputStream_payload_Energy;
  reg        [5:0]    addr;
  wire       [6:0]    hit;
  wire                when_Stream_l466;
  reg                 inputStream_thrown_valid;
  wire                inputStream_thrown_ready;
  wire       [9:0]    inputStream_thrown_payload_Energy;
  wire                inputStream_fire;
  reg                 fifo_io_pop_valid_regNext;
  reg        [9:0]    fifo_io_pop_payload_Energy_regNext;

  assign _zz_hit = 6'h05;
  assign _zz_hit_1 = 6'h0b;
  EnergyStreamFifoOrder_Rechanged fifo (
    .io_push_valid          (inputStream_thrown_valid              ), //i
    .io_push_ready          (fifo_io_push_ready                    ), //o
    .io_push_payload_Energy (inputStream_thrown_payload_Energy[9:0]), //i
    .io_pop_valid           (fifo_io_pop_valid                     ), //o
    .io_pop_ready           (1'b1                                  ), //i
    .io_pop_payload_Energy  (fifo_io_pop_payload_Energy[9:0]       ), //o
    .io_flush               (1'b0                                  ), //i
    .io_occupancy           (fifo_io_occupancy[6:0]                ), //o
    .io_availability        (fifo_io_availability[6:0]             ), //o
    .clk_out1               (clk_out1                              ), //i
    .rstN                   (rstN                                  )  //i
  );
  assign inputFlow_valid = EnergyInEn;
  assign inputFlow_payload_Energy = EnergyIn;
  assign inputStream_valid = inputFlow_valid;
  assign inputStream_payload_Energy = inputFlow_payload_Energy;
  assign hit = {{{{{{(addr <= _zz_hit),(addr == _zz_hit_1)},(addr == 6'h19)},(addr == 6'h20)},(addr == 6'h27)},(addr == 6'h35)},(6'h3b <= addr)};
  assign when_Stream_l466 = (|hit);
  always @(*) begin
    inputStream_thrown_valid = inputStream_valid;
    if(when_Stream_l466) begin
      inputStream_thrown_valid = 1'b0;
    end
  end

  always @(*) begin
    inputStream_ready = inputStream_thrown_ready;
    if(when_Stream_l466) begin
      inputStream_ready = 1'b1;
    end
  end

  assign inputStream_thrown_payload_Energy = inputStream_payload_Energy;
  assign inputStream_thrown_ready = fifo_io_push_ready;
  assign inputStream_fire = (inputStream_valid && inputStream_ready);
  assign EnergyOutEn = fifo_io_pop_valid_regNext;
  assign EnergyOut = fifo_io_pop_payload_Energy_regNext;
  always @(posedge clk_out1 or negedge rstN) begin
    if(!rstN) begin
      addr <= 6'h0;
      fifo_io_pop_valid_regNext <= 1'b0;
      fifo_io_pop_payload_Energy_regNext <= 10'h0;
    end else begin
      if(inputStream_fire) begin
        addr <= (addr + 6'h01);
      end
      fifo_io_pop_valid_regNext <= fifo_io_pop_valid;
      fifo_io_pop_payload_Energy_regNext <= fifo_io_pop_payload_Energy;
    end
  end


endmodule
