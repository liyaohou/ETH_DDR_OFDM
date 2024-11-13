// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : BufferCC_12
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module BufferCC_12 (
  input  wire          io_dataIn,
  output wire          io_dataOut,
  input  wire          clk_out4,
  input  wire          rstN
);

  (* async_reg = "true" *) reg                 buffers_0;
  (* async_reg = "true" *) reg                 buffers_1;

  assign io_dataOut = buffers_1;
  always @(posedge clk_out4) begin
    buffers_0 <= io_dataIn;
    buffers_1 <= buffers_0;
  end


endmodule
