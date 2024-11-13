// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : WrDataTxd
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module WrDataTxd (
  input  wire          io_write,
  input  wire          io_taskWrData_valid,
  output reg           io_taskWrData_ready,
  input  wire [31:0]   io_taskWrData_payload_data,
  input  wire [3:0]    io_taskWrData_payload_mask,
  output wire          io_idfiWrData_0_valid,
  output wire [31:0]   io_idfiWrData_0_payload_wrData,
  output wire [3:0]    io_idfiWrData_0_payload_wrDataMask,
  input  wire          clk_out4,
  input  wire          rstN
);

  wire                writeHistory_0;
  wire                writeHistory_1;
  wire                writeHistory_2;
  wire                writeHistory_3;
  wire                _zz_writeHistory_0;
  reg                 _zz_writeHistory_1;
  reg                 _zz_writeHistory_2;
  reg                 _zz_writeHistory_3;
  wire                write;
  reg                 wrens_0;
  wire                wrensHistory_0_0;
  wire                wrensHistory_0_1;
  wire                wrensHistory_0_2;
  wire                wrensHistory_0_3;
  wire                wrensHistory_0_4;
  wire                wrensHistory_0_5;
  wire                _zz_wrensHistory_0_0;
  reg                 _zz_wrensHistory_0_1;
  reg                 _zz_wrensHistory_0_2;
  reg                 _zz_wrensHistory_0_3;
  reg                 _zz_wrensHistory_0_4;
  reg                 _zz_wrensHistory_0_5;

  assign _zz_writeHistory_0 = io_write;
  assign writeHistory_0 = _zz_writeHistory_0;
  assign writeHistory_1 = _zz_writeHistory_1;
  assign writeHistory_2 = _zz_writeHistory_2;
  assign writeHistory_3 = _zz_writeHistory_3;
  assign write = (|{writeHistory_3,{writeHistory_2,{writeHistory_1,writeHistory_0}}});
  assign _zz_wrensHistory_0_0 = wrens_0;
  assign wrensHistory_0_0 = _zz_wrensHistory_0_0;
  assign wrensHistory_0_1 = _zz_wrensHistory_0_1;
  assign wrensHistory_0_2 = _zz_wrensHistory_0_2;
  assign wrensHistory_0_3 = _zz_wrensHistory_0_3;
  assign wrensHistory_0_4 = _zz_wrensHistory_0_4;
  assign wrensHistory_0_5 = _zz_wrensHistory_0_5;
  always @(*) begin
    wrens_0 = 1'b0;
    if(write) begin
      wrens_0 = 1'b1;
    end
  end

  always @(*) begin
    io_taskWrData_ready = 1'b0;
    if(wrensHistory_0_4) begin
      io_taskWrData_ready = 1'b1;
    end
  end

  assign io_idfiWrData_0_valid = wrensHistory_0_4;
  assign io_idfiWrData_0_payload_wrData = io_taskWrData_payload_data[31 : 0];
  assign io_idfiWrData_0_payload_wrDataMask = io_taskWrData_payload_mask[3 : 0];
  always @(posedge clk_out4) begin
    _zz_writeHistory_1 <= _zz_writeHistory_0;
    _zz_writeHistory_2 <= _zz_writeHistory_1;
    _zz_writeHistory_3 <= _zz_writeHistory_2;
  end

  always @(posedge clk_out4 or negedge rstN) begin
    if(!rstN) begin
      _zz_wrensHistory_0_1 <= 1'b0;
      _zz_wrensHistory_0_2 <= 1'b0;
      _zz_wrensHistory_0_3 <= 1'b0;
      _zz_wrensHistory_0_4 <= 1'b0;
      _zz_wrensHistory_0_5 <= 1'b0;
    end else begin
      _zz_wrensHistory_0_1 <= _zz_wrensHistory_0_0;
      _zz_wrensHistory_0_2 <= _zz_wrensHistory_0_1;
      _zz_wrensHistory_0_3 <= _zz_wrensHistory_0_2;
      _zz_wrensHistory_0_4 <= _zz_wrensHistory_0_3;
      _zz_wrensHistory_0_5 <= _zz_wrensHistory_0_4;
      `ifndef SYNTHESIS
        `ifdef FORMAL
          assert((! ((! io_taskWrData_valid) && io_taskWrData_ready))); // Task2IDFI.scala:L185
        `else
          if(!(! ((! io_taskWrData_valid) && io_taskWrData_ready))) begin
            $display("ERROR SDRAM write data stream starved !"); // Task2IDFI.scala:L185
          end
        `endif
      `endif
    end
  end


endmodule
