// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : Channel_Equalizer
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module Channel_Equalizer (
  input  wire          DataInEnable,
  input  wire [7:0]    DataInRe,
  input  wire [7:0]    DataInIm,
  input  wire [7:0]    DataInSymbol,
  output wire          DataOutEnable,
  output wire [9:0]    DataOutRe,
  output wire [9:0]    DataOutIm,
  output wire [7:0]    DataOutSymbol,
  output wire          EnergyEnable,
  output wire [9:0]    Energy,
  input  wire          clk_out1,
  input  wire          rstN
);

  wire                ltp_picking_1_DataOutEnable;
  wire                ltp_picking_1_AveLongTrainingEnable;
  wire       [7:0]    ltp_picking_1_DataOutSymbol;
  wire       [7:0]    ltp_picking_1_DataOutRe;
  wire       [7:0]    ltp_picking_1_DataOutIm;
  wire       [7:0]    ltp_picking_1_AveLongTrainingRe;
  wire       [7:0]    ltp_picking_1_AveLongTrainingIm;
  wire                channelEstimating_1_ChannelCoefEnable;
  wire       [7:0]    channelEstimating_1_ChannelCoefRe;
  wire       [7:0]    channelEstimating_1_ChannelCoefIm;
  wire                energyComputation_1_io_EnergyEnable;
  wire       [9:0]    energyComputation_1_io_Energy;
  wire                channelCompensation_1_DataOutEnable;
  wire       [9:0]    channelCompensation_1_DataOutRe;
  wire       [9:0]    channelCompensation_1_DataOutIm;
  wire       [7:0]    channelCompensation_1_DataOutSymbol;

  LTP_Picking ltp_picking_1 (
    .DataInEnable          (DataInEnable                        ), //i
    .DataOutEnable         (ltp_picking_1_DataOutEnable         ), //o
    .AveLongTrainingEnable (ltp_picking_1_AveLongTrainingEnable ), //o
    .DataInSymbol          (DataInSymbol[7:0]                   ), //i
    .DataOutSymbol         (ltp_picking_1_DataOutSymbol[7:0]    ), //o
    .DataInRe              (DataInRe[7:0]                       ), //i
    .DataInIm              (DataInIm[7:0]                       ), //i
    .DataOutRe             (ltp_picking_1_DataOutRe[7:0]        ), //o
    .DataOutIm             (ltp_picking_1_DataOutIm[7:0]        ), //o
    .AveLongTrainingRe     (ltp_picking_1_AveLongTrainingRe[7:0]), //o
    .AveLongTrainingIm     (ltp_picking_1_AveLongTrainingIm[7:0]), //o
    .clk_out1              (clk_out1                            ), //i
    .rstN                  (rstN                                )  //i
  );
  ChannelEstimating channelEstimating_1 (
    .AveLongTrainingEnable (ltp_picking_1_AveLongTrainingEnable   ), //i
    .AveLongTrainingRe     (ltp_picking_1_AveLongTrainingRe[7:0]  ), //i
    .AveLongTrainingIm     (ltp_picking_1_AveLongTrainingIm[7:0]  ), //i
    .ChannelCoefEnable     (channelEstimating_1_ChannelCoefEnable ), //o
    .ChannelCoefRe         (channelEstimating_1_ChannelCoefRe[7:0]), //o
    .ChannelCoefIm         (channelEstimating_1_ChannelCoefIm[7:0]), //o
    .clk_out1              (clk_out1                              ), //i
    .rstN                  (rstN                                  )  //i
  );
  EnergyComputation energyComputation_1 (
    .io_AveLongTrainingEnable (ltp_picking_1_AveLongTrainingEnable ), //i
    .io_AveLongTrainingRe     (ltp_picking_1_AveLongTrainingRe[7:0]), //i
    .io_AveLongTrainingIm     (ltp_picking_1_AveLongTrainingIm[7:0]), //i
    .io_EnergyEnable          (energyComputation_1_io_EnergyEnable ), //o
    .io_Energy                (energyComputation_1_io_Energy[9:0]  ), //o
    .clk_out1                 (clk_out1                            ), //i
    .rstN                     (rstN                                )  //i
  );
  ChannelCompensation channelCompensation_1 (
    .ChannelCoefEnable (channelEstimating_1_ChannelCoefEnable   ), //i
    .ChannelCoefRe     (channelEstimating_1_ChannelCoefRe[7:0]  ), //i
    .ChannelCoefIm     (channelEstimating_1_ChannelCoefIm[7:0]  ), //i
    .DataInEnable      (ltp_picking_1_DataOutEnable             ), //i
    .DataInRe          (ltp_picking_1_DataOutRe[7:0]            ), //i
    .DataInIm          (ltp_picking_1_DataOutIm[7:0]            ), //i
    .DataInSymbol      (ltp_picking_1_DataOutSymbol[7:0]        ), //i
    .DataOutEnable     (channelCompensation_1_DataOutEnable     ), //o
    .DataOutRe         (channelCompensation_1_DataOutRe[9:0]    ), //o
    .DataOutIm         (channelCompensation_1_DataOutIm[9:0]    ), //o
    .DataOutSymbol     (channelCompensation_1_DataOutSymbol[7:0]), //o
    .clk_out1          (clk_out1                                ), //i
    .rstN              (rstN                                    )  //i
  );
  assign EnergyEnable = energyComputation_1_io_EnergyEnable;
  assign Energy = energyComputation_1_io_Energy;
  assign DataOutEnable = channelCompensation_1_DataOutEnable;
  assign DataOutRe = channelCompensation_1_DataOutRe;
  assign DataOutIm = channelCompensation_1_DataOutIm;
  assign DataOutSymbol = channelCompensation_1_DataOutSymbol;

endmodule
