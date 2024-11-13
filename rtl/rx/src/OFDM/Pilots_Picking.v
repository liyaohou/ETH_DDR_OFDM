// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : Pilots_Picking
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module Pilots_Picking (
  input  wire          inputDataEn,
  input  wire [9:0]    inputDataR,
  input  wire [9:0]    inputDataI,
  input  wire [7:0]    inputSymbol,
  output wire          outputDataEn,
  output wire [9:0]    outputDataR,
  output wire [9:0]    outputDataI,
  output wire [7:0]    outputSymbol,
  output wire          pilot_valid,
  input  wire          pilot_ready,
  output wire          pilot_payload_last,
  output wire [9:0]    pilot_payload_fragment_Re,
  output wire [9:0]    pilot_payload_fragment_Im,
  output wire [3:0]    pilot_payload_fragment_Index,
  input  wire          clk_out1,
  input  wire          rstN
);

  wire                fifo_io_push_ready;
  wire                fifo_io_pop_valid;
  wire       [9:0]    fifo_io_pop_payload_Re;
  wire       [9:0]    fifo_io_pop_payload_Im;
  wire       [6:0]    fifo_io_occupancy;
  wire       [6:0]    fifo_io_availability;
  wire                inputFlow_valid;
  wire       [9:0]    inputFlow_payload_Re;
  wire       [9:0]    inputFlow_payload_Im;
  reg                 inputDataEn_regNext;
  wire                inputStream_valid;
  wire                inputStream_ready;
  wire       [9:0]    inputStream_payload_Re;
  wire       [9:0]    inputStream_payload_Im;
  reg        [5:0]    addr;
  wire                hit_0;
  wire                hit_1;
  wire                hit_2;
  wire                hit_3;
  wire                inputStream_fire;
  wire                tempPilot_valid;
  reg                 tempPilot_ready;
  wire                tempPilot_payload_last;
  wire       [9:0]    tempPilot_payload_fragment_Re;
  wire       [9:0]    tempPilot_payload_fragment_Im;
  wire       [3:0]    tempPilot_payload_fragment_Index;
  wire                tempPilot_m2sPipe_valid;
  wire                tempPilot_m2sPipe_ready;
  wire                tempPilot_m2sPipe_payload_last;
  wire       [9:0]    tempPilot_m2sPipe_payload_fragment_Re;
  wire       [9:0]    tempPilot_m2sPipe_payload_fragment_Im;
  wire       [3:0]    tempPilot_m2sPipe_payload_fragment_Index;
  reg                 tempPilot_rValid;
  reg                 tempPilot_rData_last;
  reg        [9:0]    tempPilot_rData_fragment_Re;
  reg        [9:0]    tempPilot_rData_fragment_Im;
  reg        [3:0]    tempPilot_rData_fragment_Index;
  wire                when_Stream_l393;
  reg                 fifo_io_pop_valid_regNext;
  reg        [9:0]    fifo_io_pop_payload_Re_regNext;
  reg        [9:0]    fifo_io_pop_payload_Im_regNext;
  wire                when_PilotsPicking_l54;
  reg        [7:0]    inputSymbol_regNextWhen;

  DataInStreamFifoPilots_Picking fifo (
    .io_push_valid      (inputStream_valid          ), //i
    .io_push_ready      (fifo_io_push_ready         ), //o
    .io_push_payload_Re (inputStream_payload_Re[9:0]), //i
    .io_push_payload_Im (inputStream_payload_Im[9:0]), //i
    .io_pop_valid       (fifo_io_pop_valid          ), //o
    .io_pop_ready       (1'b1                       ), //i
    .io_pop_payload_Re  (fifo_io_pop_payload_Re[9:0]), //o
    .io_pop_payload_Im  (fifo_io_pop_payload_Im[9:0]), //o
    .io_flush           (1'b0                       ), //i
    .io_occupancy       (fifo_io_occupancy[6:0]     ), //o
    .io_availability    (fifo_io_availability[6:0]  ), //o
    .clk_out1           (clk_out1                   ), //i
    .rstN               (rstN                       )  //i
  );
  assign inputFlow_valid = inputDataEn_regNext;
  assign inputFlow_payload_Re = inputDataR;
  assign inputFlow_payload_Im = inputDataI;
  assign inputStream_valid = inputFlow_valid;
  assign inputStream_payload_Re = inputFlow_payload_Re;
  assign inputStream_payload_Im = inputFlow_payload_Im;
  assign hit_0 = (addr == 6'h07);
  assign hit_1 = (addr == 6'h15);
  assign hit_2 = (addr == 6'h2b);
  assign hit_3 = (addr == 6'h39);
  assign inputStream_ready = fifo_io_push_ready;
  assign inputStream_fire = (inputStream_valid && inputStream_ready);
  assign tempPilot_valid = ((|{hit_3,{hit_2,{hit_1,hit_0}}}) && inputStream_valid);
  assign tempPilot_payload_fragment_Re = inputStream_payload_Re;
  assign tempPilot_payload_fragment_Im = inputStream_payload_Im;
  assign tempPilot_payload_fragment_Index = {hit_3,{hit_2,{hit_1,hit_0}}};
  assign tempPilot_payload_last = (hit_3 && inputStream_valid);
  always @(*) begin
    tempPilot_ready = tempPilot_m2sPipe_ready;
    if(when_Stream_l393) begin
      tempPilot_ready = 1'b1;
    end
  end

  assign when_Stream_l393 = (! tempPilot_m2sPipe_valid);
  assign tempPilot_m2sPipe_valid = tempPilot_rValid;
  assign tempPilot_m2sPipe_payload_last = tempPilot_rData_last;
  assign tempPilot_m2sPipe_payload_fragment_Re = tempPilot_rData_fragment_Re;
  assign tempPilot_m2sPipe_payload_fragment_Im = tempPilot_rData_fragment_Im;
  assign tempPilot_m2sPipe_payload_fragment_Index = tempPilot_rData_fragment_Index;
  assign pilot_valid = tempPilot_m2sPipe_valid;
  assign tempPilot_m2sPipe_ready = pilot_ready;
  assign pilot_payload_last = tempPilot_m2sPipe_payload_last;
  assign pilot_payload_fragment_Re = tempPilot_m2sPipe_payload_fragment_Re;
  assign pilot_payload_fragment_Im = tempPilot_m2sPipe_payload_fragment_Im;
  assign pilot_payload_fragment_Index = tempPilot_m2sPipe_payload_fragment_Index;
  assign outputDataEn = fifo_io_pop_valid_regNext;
  assign outputDataR = fifo_io_pop_payload_Re_regNext;
  assign outputDataI = fifo_io_pop_payload_Im_regNext;
  assign when_PilotsPicking_l54 = (addr == 6'h0);
  assign outputSymbol = inputSymbol_regNextWhen;
  always @(posedge clk_out1 or negedge rstN) begin
    if(!rstN) begin
      inputDataEn_regNext <= 1'b0;
      addr <= 6'h0;
      tempPilot_rValid <= 1'b0;
      fifo_io_pop_valid_regNext <= 1'b0;
      fifo_io_pop_payload_Re_regNext <= 10'h0;
      fifo_io_pop_payload_Im_regNext <= 10'h0;
      inputSymbol_regNextWhen <= 8'h0;
    end else begin
      inputDataEn_regNext <= inputDataEn;
      if(inputStream_fire) begin
        addr <= (addr + 6'h01);
      end
      if(tempPilot_ready) begin
        tempPilot_rValid <= tempPilot_valid;
      end
      fifo_io_pop_valid_regNext <= fifo_io_pop_valid;
      fifo_io_pop_payload_Re_regNext <= fifo_io_pop_payload_Re;
      fifo_io_pop_payload_Im_regNext <= fifo_io_pop_payload_Im;
      if(when_PilotsPicking_l54) begin
        inputSymbol_regNextWhen <= inputSymbol;
      end
    end
  end

  always @(posedge clk_out1) begin
    if(tempPilot_ready) begin
      tempPilot_rData_last <= tempPilot_payload_last;
      tempPilot_rData_fragment_Re <= tempPilot_payload_fragment_Re;
      tempPilot_rData_fragment_Im <= tempPilot_payload_fragment_Im;
      tempPilot_rData_fragment_Index <= tempPilot_payload_fragment_Index;
    end
  end


endmodule
