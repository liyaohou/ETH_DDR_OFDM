// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : EnergyComputation
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module EnergyComputation (
  input  wire          io_AveLongTrainingEnable,
  input  wire [7:0]    io_AveLongTrainingRe,
  input  wire [7:0]    io_AveLongTrainingIm,
  output wire          io_EnergyEnable,
  output wire [9:0]    io_Energy,
  input  wire          clk_out1,
  input  wire          rstN
);

  wire       [16:0]   _zz_sum;
  wire       [16:0]   _zz_sum_1;
  wire       [8:0]    _zz_io_Energy;
  reg        [15:0]   AveLongTrainingReModulus;
  reg        [15:0]   AveLongTrainingImModulus;
  reg                 io_AveLongTrainingEnable_regNext;
  wire       [16:0]   sum;

  assign _zz_sum = {AveLongTrainingReModulus[15],AveLongTrainingReModulus};
  assign _zz_sum_1 = {AveLongTrainingImModulus[15],AveLongTrainingImModulus};
  assign _zz_io_Energy = sum[14 : 6];
  assign io_EnergyEnable = io_AveLongTrainingEnable_regNext;
  assign sum = ($signed(_zz_sum) + $signed(_zz_sum_1));
  assign io_Energy = {sum[16],_zz_io_Energy};
  always @(posedge clk_out1 or negedge rstN) begin
    if(!rstN) begin
      AveLongTrainingReModulus <= 16'h0;
      AveLongTrainingImModulus <= 16'h0;
      io_AveLongTrainingEnable_regNext <= 1'b0;
    end else begin
      io_AveLongTrainingEnable_regNext <= io_AveLongTrainingEnable;
      if(io_EnergyEnable) begin
        AveLongTrainingReModulus <= ($signed(io_AveLongTrainingRe) * $signed(io_AveLongTrainingRe));
        AveLongTrainingImModulus <= ($signed(io_AveLongTrainingIm) * $signed(io_AveLongTrainingIm));
      end else begin
        AveLongTrainingReModulus <= 16'h0;
        AveLongTrainingImModulus <= 16'h0;
      end
    end
  end


endmodule
