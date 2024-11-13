// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : BufferCC_2
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module BufferCC_2 (
  input  wire [9:0]    io_dataIn,
  output wire [9:0]    io_dataOut,
  input  wire          clk_out4,
  input  wire          adapter_bmbCCDomain_axi4StreamToBmb_workClockArea_ddr3AxisTxIf_toplevel_rstN_synchronized
);

  (* async_reg = "true" , altera_attribute = "-name ADV_NETLIST_OPT_ALLOWED NEVER_ALLOW" *) reg        [9:0]    buffers_0;
  (* async_reg = "true" *) reg        [9:0]    buffers_1;

  assign io_dataOut = buffers_1;
  always @(posedge clk_out4 or negedge adapter_bmbCCDomain_axi4StreamToBmb_workClockArea_ddr3AxisTxIf_toplevel_rstN_synchronized) begin
    if(!adapter_bmbCCDomain_axi4StreamToBmb_workClockArea_ddr3AxisTxIf_toplevel_rstN_synchronized) begin
      buffers_0 <= 10'h0;
      buffers_1 <= 10'h0;
    end else begin
      buffers_0 <= io_dataIn;
      buffers_1 <= buffers_0;
    end
  end


endmodule
