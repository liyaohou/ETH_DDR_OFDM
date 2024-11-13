// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : Threshold_Adjusting
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module Threshold_Adjusting (
  input  wire          EnergyInEn,
  input  wire [9:0]    Energy,
  output wire          EnergyOutEn,
  output wire [13:0]   EnergyPos,
  output wire [13:0]   EnergyNeg,
  input  wire          clk_out1,
  input  wire          rstN
);

  wire                energyOrder_Rechanged_1_EnergyOutEn;
  wire       [9:0]    energyOrder_Rechanged_1_EnergyOut;
  wire                energyRemove_Pilots_1_EnergyOutEn;
  wire       [9:0]    energyRemove_Pilots_1_EnergyOut;
  wire       [13:0]   _zz_TempPos;
  wire       [8:0]    _zz_TempPos_1;
  wire       [8:0]    _zz_TempPos_2;
  reg                 EnergyInEn_regNext;
  wire       [8:0]    EnergyPos_2;
  wire       [6:0]    EnergyPos_8;
  wire       [13:0]   TempPos;
  wire       [13:0]   TempNeg;
  reg                 energyRemove_Pilots_1_EnergyOutEn_regNext;
  reg        [13:0]   TempPos_regNext;
  reg        [13:0]   TempNeg_regNext;

  assign _zz_TempPos_1 = (EnergyPos_2 + _zz_TempPos_2);
  assign _zz_TempPos = {5'd0, _zz_TempPos_1};
  assign _zz_TempPos_2 = {2'd0, EnergyPos_8};
  EnergyOrder_Rechanged energyOrder_Rechanged_1 (
    .EnergyInEn  (EnergyInEn_regNext                    ), //i
    .EnergyIn    (Energy[9:0]                           ), //i
    .EnergyOutEn (energyOrder_Rechanged_1_EnergyOutEn   ), //o
    .EnergyOut   (energyOrder_Rechanged_1_EnergyOut[9:0]), //o
    .clk_out1    (clk_out1                              ), //i
    .rstN        (rstN                                  )  //i
  );
  EnergyRemove_Pilots energyRemove_Pilots_1 (
    .EnergyInEn  (energyOrder_Rechanged_1_EnergyOutEn   ), //i
    .EnergyIn    (energyOrder_Rechanged_1_EnergyOut[9:0]), //i
    .EnergyOutEn (energyRemove_Pilots_1_EnergyOutEn     ), //o
    .EnergyOut   (energyRemove_Pilots_1_EnergyOut[9:0]  ), //o
    .clk_out1    (clk_out1                              ), //i
    .rstN        (rstN                                  )  //i
  );
  assign EnergyPos_2 = (energyRemove_Pilots_1_EnergyOut >>> 1'd1);
  assign EnergyPos_8 = (energyRemove_Pilots_1_EnergyOut >>> 2'd3);
  assign TempPos = _zz_TempPos;
  assign TempNeg = (- TempPos);
  assign EnergyOutEn = energyRemove_Pilots_1_EnergyOutEn_regNext;
  assign EnergyPos = TempPos_regNext;
  assign EnergyNeg = TempNeg_regNext;
  always @(posedge clk_out1 or negedge rstN) begin
    if(!rstN) begin
      EnergyInEn_regNext <= 1'b0;
      energyRemove_Pilots_1_EnergyOutEn_regNext <= 1'b0;
      TempPos_regNext <= 14'h0;
      TempNeg_regNext <= 14'h0;
    end else begin
      EnergyInEn_regNext <= EnergyInEn;
      energyRemove_Pilots_1_EnergyOutEn_regNext <= energyRemove_Pilots_1_EnergyOutEn;
      TempPos_regNext <= TempPos;
      TempNeg_regNext <= TempNeg;
    end
  end


endmodule
