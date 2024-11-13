// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : StreamMux_1
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module StreamMux_1 (
  input  wire [0:0]    io_select,
  input  wire          io_inputs_0_valid,
  output wire          io_inputs_0_ready,
  input  wire [9:0]    io_inputs_0_payload_Energy,
  input  wire          io_inputs_1_valid,
  output wire          io_inputs_1_ready,
  input  wire [9:0]    io_inputs_1_payload_Energy,
  output wire          io_output_valid,
  input  wire          io_output_ready,
  output wire [9:0]    io_output_payload_Energy
);

  reg                 _zz_io_output_valid;
  reg        [9:0]    _zz_io_output_payload_Energy;

  always @(*) begin
    case(io_select)
      1'b0 : begin
        _zz_io_output_valid = io_inputs_0_valid;
        _zz_io_output_payload_Energy = io_inputs_0_payload_Energy;
      end
      default : begin
        _zz_io_output_valid = io_inputs_1_valid;
        _zz_io_output_payload_Energy = io_inputs_1_payload_Energy;
      end
    endcase
  end

  assign io_inputs_0_ready = ((io_select == 1'b0) && io_output_ready);
  assign io_inputs_1_ready = ((io_select == 1'b1) && io_output_ready);
  assign io_output_valid = _zz_io_output_valid;
  assign io_output_payload_Energy = _zz_io_output_payload_Energy;

endmodule
