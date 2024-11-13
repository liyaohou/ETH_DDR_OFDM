// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : Refresher
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module Refresher (
  output wire          io_refresh_valid,
  input  wire          io_refresh_ready,
  input  wire          clk_out4,
  input  wire          rstN
);

  reg        [22:0]   value;
  wire                hit;
  wire                when_Refresher_l15;
  reg                 pending;
  wire                when_Refresher_l19;

  assign hit = (value == 23'h0);
  assign when_Refresher_l15 = (hit || (! 1'b1));
  assign when_Refresher_l19 = (! 1'b1);
  assign io_refresh_valid = pending;
  always @(posedge clk_out4 or negedge rstN) begin
    if(!rstN) begin
      value <= 23'h0;
      pending <= 1'b0;
    end else begin
      value <= (value - 23'h000001);
      if(when_Refresher_l15) begin
        value <= 23'h00003c;
      end
      if(io_refresh_ready) begin
        pending <= 1'b0;
      end
      if(hit) begin
        pending <= 1'b1;
      end
      if(when_Refresher_l19) begin
        pending <= 1'b0;
      end
    end
  end


endmodule
