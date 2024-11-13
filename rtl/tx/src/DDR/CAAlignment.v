// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : CAAlignment
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module CAAlignment (
  input  wire          io_cmd_0_valid,
  input  wire          io_cmd_0_payload_weN,
  input  wire          io_cmd_0_payload_casN,
  input  wire          io_cmd_0_payload_rasN,
  input  wire [0:0]    io_cmd_0_payload_csN,
  input  wire          io_address_0_valid,
  input  wire [2:0]    io_address_0_payload_bank,
  input  wire [14:0]   io_address_0_payload_address,
  input  wire [0:0]    io_cke_0,
  output reg  [14:0]   io_output_address,
  output reg  [2:0]    io_output_bank,
  output reg  [0:0]    io_output_rasN,
  output reg  [0:0]    io_output_casN,
  output reg  [0:0]    io_output_weN,
  output reg  [0:0]    io_output_csN,
  output wire [0:0]    io_output_cke
);


  assign io_output_cke = io_cke_0;
  always @(*) begin
    io_output_csN = 1'b1;
    if(io_cmd_0_valid) begin
      io_output_csN[0 : 0] = io_cmd_0_payload_csN;
    end
  end

  always @(*) begin
    io_output_rasN = 1'b1;
    if(io_cmd_0_valid) begin
      io_output_rasN[0 : 0] = io_cmd_0_payload_rasN;
    end
  end

  always @(*) begin
    io_output_casN = 1'b1;
    if(io_cmd_0_valid) begin
      io_output_casN[0 : 0] = io_cmd_0_payload_casN;
    end
  end

  always @(*) begin
    io_output_weN = 1'b1;
    if(io_cmd_0_valid) begin
      io_output_weN[0 : 0] = io_cmd_0_payload_weN;
    end
  end

  always @(*) begin
    io_output_bank = 3'b000;
    if(io_address_0_valid) begin
      io_output_bank[2 : 0] = io_address_0_payload_bank;
    end
  end

  always @(*) begin
    io_output_address = 15'h0;
    if(io_address_0_valid) begin
      io_output_address[14 : 0] = io_address_0_payload_address;
    end
  end


endmodule
