// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : Remove_Pilots
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module Remove_Pilots (
  input  wire          inputDataEn,
  input  wire [9:0]    inputDataR,
  input  wire [9:0]    inputDataI,
  input  wire [7:0]    inputSymbol,
  output wire          outputDataEn,
  output wire [9:0]    outputDataR,
  output wire [9:0]    outputDataI,
  output wire [7:0]    outputSymbol,
  input  wire          clk_out1,
  input  wire          rstN
);

  wire                fifo_io_push_ready;
  wire                fifo_io_pop_valid;
  wire       [9:0]    fifo_io_pop_payload_Re;
  wire       [9:0]    fifo_io_pop_payload_Im;
  wire       [6:0]    fifo_io_occupancy;
  wire       [6:0]    fifo_io_availability;
  wire       [5:0]    _zz_hit;
  wire       [5:0]    _zz_hit_1;
  wire                inputFlow_valid;
  wire       [9:0]    inputFlow_payload_Re;
  wire       [9:0]    inputFlow_payload_Im;
  wire                inputStream_valid;
  reg                 inputStream_ready;
  wire       [9:0]    inputStream_payload_Re;
  wire       [9:0]    inputStream_payload_Im;
  reg        [5:0]    addr;
  wire       [6:0]    hit;
  wire                when_Stream_l466;
  reg                 inputStream_thrown_valid;
  wire                inputStream_thrown_ready;
  wire       [9:0]    inputStream_thrown_payload_Re;
  wire       [9:0]    inputStream_thrown_payload_Im;
  wire                inputStream_fire;
  reg                 fifo_io_pop_valid_regNext;
  reg        [9:0]    fifo_io_pop_payload_Re_regNext;
  reg        [9:0]    fifo_io_pop_payload_Im_regNext;
  wire                when_RemovePilots_l40;
  reg        [7:0]    inputSymbol_regNextWhen;

  assign _zz_hit = 6'h05;
  assign _zz_hit_1 = 6'h0b;
  DataInStreamFifoPilots_Picking fifo (
    .io_push_valid      (inputStream_thrown_valid          ), //i
    .io_push_ready      (fifo_io_push_ready                ), //o
    .io_push_payload_Re (inputStream_thrown_payload_Re[9:0]), //i
    .io_push_payload_Im (inputStream_thrown_payload_Im[9:0]), //i
    .io_pop_valid       (fifo_io_pop_valid                 ), //o
    .io_pop_ready       (1'b1                              ), //i
    .io_pop_payload_Re  (fifo_io_pop_payload_Re[9:0]       ), //o
    .io_pop_payload_Im  (fifo_io_pop_payload_Im[9:0]       ), //o
    .io_flush           (1'b0                              ), //i
    .io_occupancy       (fifo_io_occupancy[6:0]            ), //o
    .io_availability    (fifo_io_availability[6:0]         ), //o
    .clk_out1           (clk_out1                          ), //i
    .rstN               (rstN                              )  //i
  );
  assign inputFlow_valid = inputDataEn;
  assign inputFlow_payload_Re = inputDataR;
  assign inputFlow_payload_Im = inputDataI;
  assign inputStream_valid = inputFlow_valid;
  assign inputStream_payload_Re = inputFlow_payload_Re;
  assign inputStream_payload_Im = inputFlow_payload_Im;
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

  assign inputStream_thrown_payload_Re = inputStream_payload_Re;
  assign inputStream_thrown_payload_Im = inputStream_payload_Im;
  assign inputStream_thrown_ready = fifo_io_push_ready;
  assign inputStream_fire = (inputStream_valid && inputStream_ready);
  assign outputDataEn = fifo_io_pop_valid_regNext;
  assign outputDataR = fifo_io_pop_payload_Re_regNext;
  assign outputDataI = fifo_io_pop_payload_Im_regNext;
  assign when_RemovePilots_l40 = (addr == 6'h0);
  assign outputSymbol = inputSymbol_regNextWhen;
  always @(posedge clk_out1 or negedge rstN) begin
    if(!rstN) begin
      addr <= 6'h0;
      fifo_io_pop_valid_regNext <= 1'b0;
      fifo_io_pop_payload_Re_regNext <= 10'h0;
      fifo_io_pop_payload_Im_regNext <= 10'h0;
      inputSymbol_regNextWhen <= 8'h0;
    end else begin
      if(inputStream_fire) begin
        addr <= (addr + 6'h01);
      end
      fifo_io_pop_valid_regNext <= fifo_io_pop_valid;
      fifo_io_pop_payload_Re_regNext <= fifo_io_pop_payload_Re;
      fifo_io_pop_payload_Im_regNext <= fifo_io_pop_payload_Im;
      if(when_RemovePilots_l40) begin
        inputSymbol_regNextWhen <= inputSymbol;
      end
    end
  end


endmodule
