// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : StreamDemux_1
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module StreamDemux_1 (
  input  wire [0:0]    io_select,
  input  wire          io_input_valid,
  output reg           io_input_ready,
  input  wire [9:0]    io_input_payload_Energy,
  output reg           io_outputs_0_valid,
  input  wire          io_outputs_0_ready,
  output wire [9:0]    io_outputs_0_payload_Energy,
  output reg           io_outputs_1_valid,
  input  wire          io_outputs_1_ready,
  output wire [9:0]    io_outputs_1_payload_Energy
);

  wire                when_Stream_l999;
  wire                when_Stream_l999_1;

  always @(*) begin
    io_input_ready = 1'b0;
    if(!when_Stream_l999) begin
      io_input_ready = io_outputs_0_ready;
    end
    if(!when_Stream_l999_1) begin
      io_input_ready = io_outputs_1_ready;
    end
  end

  assign io_outputs_0_payload_Energy = io_input_payload_Energy;
  assign when_Stream_l999 = (1'b0 != io_select);
  always @(*) begin
    if(when_Stream_l999) begin
      io_outputs_0_valid = 1'b0;
    end else begin
      io_outputs_0_valid = io_input_valid;
    end
  end

  assign io_outputs_1_payload_Energy = io_input_payload_Energy;
  assign when_Stream_l999_1 = (1'b1 != io_select);
  always @(*) begin
    if(when_Stream_l999_1) begin
      io_outputs_1_valid = 1'b0;
    end else begin
      io_outputs_1_valid = io_input_valid;
    end
  end


endmodule
