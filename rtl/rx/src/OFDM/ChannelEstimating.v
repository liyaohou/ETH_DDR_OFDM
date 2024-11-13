// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : ChannelEstimating
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module ChannelEstimating (
  input  wire          AveLongTrainingEnable,
  input  wire [7:0]    AveLongTrainingRe,
  input  wire [7:0]    AveLongTrainingIm,
  output wire          ChannelCoefEnable,
  output wire [7:0]    ChannelCoefRe,
  output wire [7:0]    ChannelCoefIm,
  input  wire          clk_out1,
  input  wire          rstN
);

  reg        [1:0]    LTSMem_spinal_port0;
  wire                _zz_switch_ChannelEstimating_l42;
  wire                _zz_LTSMem_port;
  reg        [5:0]    addr;
  reg        [7:0]    TempCoefRe;
  reg        [7:0]    TempCoefIm;
  reg                 AveLongTrainingEnable_regNext;
  wire       [1:0]    switch_ChannelEstimating_l42;
  reg                 AveLongTrainingEnable_regNext_1;
  reg        [7:0]    TempCoefRe_regNext;
  reg        [7:0]    TempCoefIm_regNext;
  reg [1:0] LTSMem [0:63];

  assign _zz_LTSMem_port = 1'b1;
  initial begin
    $readmemb("RxTop.v_toplevel_workClockArea_ofdm_rx_dataRestore_1_channel_Equalizer_1_channelEstimating_1_LTSMem.bin",LTSMem);
  end
  always @(posedge clk_out1) begin
    if(_zz_LTSMem_port) begin
      LTSMem_spinal_port0 <= LTSMem[addr];
    end
  end

  always @(*) begin
    TempCoefRe = 8'h0;
    if(AveLongTrainingEnable_regNext) begin
      case(switch_ChannelEstimating_l42)
        2'b00 : begin
          TempCoefRe = 8'h0;
        end
        2'b01 : begin
          TempCoefRe = AveLongTrainingRe;
        end
        default : begin
          TempCoefRe = (- AveLongTrainingRe);
        end
      endcase
    end
  end

  always @(*) begin
    TempCoefIm = 8'h0;
    if(AveLongTrainingEnable_regNext) begin
      case(switch_ChannelEstimating_l42)
        2'b00 : begin
          TempCoefIm = 8'h0;
        end
        2'b01 : begin
          TempCoefIm = (- AveLongTrainingIm);
        end
        default : begin
          TempCoefIm = AveLongTrainingIm;
        end
      endcase
    end
  end

  assign switch_ChannelEstimating_l42 = LTSMem_spinal_port0;
  assign ChannelCoefEnable = AveLongTrainingEnable_regNext_1;
  assign ChannelCoefRe = TempCoefRe_regNext;
  assign ChannelCoefIm = TempCoefIm_regNext;
  always @(posedge clk_out1 or negedge rstN) begin
    if(!rstN) begin
      addr <= 6'h0;
      AveLongTrainingEnable_regNext <= 1'b0;
      AveLongTrainingEnable_regNext_1 <= 1'b0;
      TempCoefRe_regNext <= 8'h0;
      TempCoefIm_regNext <= 8'h0;
    end else begin
      AveLongTrainingEnable_regNext <= AveLongTrainingEnable;
      if(AveLongTrainingEnable_regNext) begin
        addr <= (addr + 6'h01);
      end
      AveLongTrainingEnable_regNext_1 <= AveLongTrainingEnable;
      TempCoefRe_regNext <= TempCoefRe;
      TempCoefIm_regNext <= TempCoefIm;
    end
  end


endmodule
