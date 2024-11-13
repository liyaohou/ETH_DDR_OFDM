// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : Interim_function
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module Interim_function (
  input  wire          inputDataEn,
  input  wire [9:0]    inputDataR,
  input  wire [9:0]    inputDataI,
  input  wire [7:0]    inputSymbol,
  output wire          outputDataEn,
  output wire [9:0]    outputDataR,
  output wire [9:0]    outputDataI,
  output wire [7:0]    outputSymbol,
  input  wire          clk_out1,
  input  wire          rstN
);

  wire                pilots_Picking_1_outputDataEn;
  wire       [9:0]    pilots_Picking_1_outputDataR;
  wire       [9:0]    pilots_Picking_1_outputDataI;
  wire       [7:0]    pilots_Picking_1_outputSymbol;
  wire                pilots_Picking_1_pilot_valid;
  wire                pilots_Picking_1_pilot_payload_last;
  wire       [9:0]    pilots_Picking_1_pilot_payload_fragment_Re;
  wire       [9:0]    pilots_Picking_1_pilot_payload_fragment_Im;
  wire       [3:0]    pilots_Picking_1_pilot_payload_fragment_Index;
  wire                order_Rechanged_1_outputDataEn;
  wire       [9:0]    order_Rechanged_1_outputDataR;
  wire       [9:0]    order_Rechanged_1_outputDataI;
  wire       [7:0]    order_Rechanged_1_outputSymbol;
  wire                remove_Pilots_1_outputDataEn;
  wire       [9:0]    remove_Pilots_1_outputDataR;
  wire       [9:0]    remove_Pilots_1_outputDataI;
  wire       [7:0]    remove_Pilots_1_outputSymbol;

  Pilots_Picking pilots_Picking_1 (
    .inputDataEn                  (inputDataEn                                       ), //i
    .inputDataR                   (inputDataR[9:0]                                   ), //i
    .inputDataI                   (inputDataI[9:0]                                   ), //i
    .inputSymbol                  (inputSymbol[7:0]                                  ), //i
    .outputDataEn                 (pilots_Picking_1_outputDataEn                     ), //o
    .outputDataR                  (pilots_Picking_1_outputDataR[9:0]                 ), //o
    .outputDataI                  (pilots_Picking_1_outputDataI[9:0]                 ), //o
    .outputSymbol                 (pilots_Picking_1_outputSymbol[7:0]                ), //o
    .pilot_valid                  (pilots_Picking_1_pilot_valid                      ), //o
    .pilot_ready                  (1'b1                                              ), //i
    .pilot_payload_last           (pilots_Picking_1_pilot_payload_last               ), //o
    .pilot_payload_fragment_Re    (pilots_Picking_1_pilot_payload_fragment_Re[9:0]   ), //o
    .pilot_payload_fragment_Im    (pilots_Picking_1_pilot_payload_fragment_Im[9:0]   ), //o
    .pilot_payload_fragment_Index (pilots_Picking_1_pilot_payload_fragment_Index[3:0]), //o
    .clk_out1                     (clk_out1                                          ), //i
    .rstN                         (rstN                                              )  //i
  );
  Order_Rechanged order_Rechanged_1 (
    .inputDataEn  (pilots_Picking_1_outputDataEn      ), //i
    .inputDataR   (pilots_Picking_1_outputDataR[9:0]  ), //i
    .inputDataI   (pilots_Picking_1_outputDataI[9:0]  ), //i
    .inputSymbol  (pilots_Picking_1_outputSymbol[7:0] ), //i
    .outputDataEn (order_Rechanged_1_outputDataEn     ), //o
    .outputDataR  (order_Rechanged_1_outputDataR[9:0] ), //o
    .outputDataI  (order_Rechanged_1_outputDataI[9:0] ), //o
    .outputSymbol (order_Rechanged_1_outputSymbol[7:0]), //o
    .clk_out1     (clk_out1                           ), //i
    .rstN         (rstN                               )  //i
  );
  Remove_Pilots remove_Pilots_1 (
    .inputDataEn  (order_Rechanged_1_outputDataEn     ), //i
    .inputDataR   (order_Rechanged_1_outputDataR[9:0] ), //i
    .inputDataI   (order_Rechanged_1_outputDataI[9:0] ), //i
    .inputSymbol  (order_Rechanged_1_outputSymbol[7:0]), //i
    .outputDataEn (remove_Pilots_1_outputDataEn       ), //o
    .outputDataR  (remove_Pilots_1_outputDataR[9:0]   ), //o
    .outputDataI  (remove_Pilots_1_outputDataI[9:0]   ), //o
    .outputSymbol (remove_Pilots_1_outputSymbol[7:0]  ), //o
    .clk_out1     (clk_out1                           ), //i
    .rstN         (rstN                               )  //i
  );
  assign outputDataEn = remove_Pilots_1_outputDataEn;
  assign outputDataR = remove_Pilots_1_outputDataR;
  assign outputDataI = remove_Pilots_1_outputDataI;
  assign outputSymbol = remove_Pilots_1_outputSymbol;

endmodule
