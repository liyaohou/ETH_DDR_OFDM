// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : ChannelCompensation
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module ChannelCompensation (
  input  wire          ChannelCoefEnable,
  input  wire [7:0]    ChannelCoefRe,
  input  wire [7:0]    ChannelCoefIm,
  input  wire          DataInEnable,
  input  wire [7:0]    DataInRe,
  input  wire [7:0]    DataInIm,
  input  wire [7:0]    DataInSymbol,
  output wire          DataOutEnable,
  output wire [9:0]    DataOutRe,
  output wire [9:0]    DataOutIm,
  output wire [7:0]    DataOutSymbol,
  input  wire          clk_out1,
  input  wire          rstN
);

  reg        [15:0]   mem_spinal_port1;
  reg        [15:0]   mem_spinal_port2;
  wire       [15:0]   _zz_mem_port;
  wire                _zz_mem_port_1;
  wire                _zz__zz_TempB;
  wire                _zz_mem_port_2;
  wire                _zz__zz_TempB_1;
  wire       [8:0]    _zz_TempA1;
  wire       [8:0]    _zz_TempA1_1;
  wire       [8:0]    _zz_TempA2;
  wire       [8:0]    _zz_TempA2_1;
  wire       [8:0]    _zz_TempB_2;
  wire       [8:0]    _zz_TempB_3;
  wire       [17:0]   _zz_TempRe;
  wire       [17:0]   _zz_TempRe_1;
  wire       [17:0]   _zz_TempIm;
  wire       [17:0]   _zz_TempIm_1;
  wire       [8:0]    _zz_DataOutRe;
  wire       [8:0]    _zz_DataOutIm;
  reg                 _zz_1;
  wire                DataInStream_valid;
  wire       [7:0]    DataInStream_payload_Re;
  wire       [7:0]    DataInStream_payload_Im;
  reg        [5:0]    wrAddr;
  reg        [5:0]    rdAddr;
  reg                 DataInStream_valid_regNext;
  reg                 TempEn1;
  reg        [8:0]    TempA1;
  reg        [8:0]    TempA2;
  reg        [8:0]    TempB;
  reg        [7:0]    TempAR;
  reg        [7:0]    TempBR;
  reg        [7:0]    TempBI;
  wire       [7:0]    _zz_TempB;
  wire       [7:0]    _zz_TempB_1;
  reg                 DataInEnable_regNext;
  reg                 TempEn2;
  reg        [16:0]   TempARB;
  reg        [16:0]   TempA1BI;
  reg        [16:0]   TempA2BR;
  reg                 TempEn3;
  reg        [17:0]   TempRe;
  reg        [17:0]   TempIm;
  reg        [7:0]    DataInSymbol_delay_1;
  reg        [7:0]    DataInSymbol_delay_2;
  reg        [7:0]    DataInSymbol_delay_3;
  reg [15:0] mem [0:63];

  assign _zz_TempA1 = {DataInRe[7],DataInRe};
  assign _zz_TempA1_1 = {DataInIm[7],DataInIm};
  assign _zz_TempA2 = {DataInRe[7],DataInRe};
  assign _zz_TempA2_1 = {DataInIm[7],DataInIm};
  assign _zz_TempB_2 = {_zz_TempB[7],_zz_TempB};
  assign _zz_TempB_3 = {_zz_TempB_1[7],_zz_TempB_1};
  assign _zz_TempRe = {TempARB[16],TempARB};
  assign _zz_TempRe_1 = {TempA1BI[16],TempA1BI};
  assign _zz_TempIm = {TempARB[16],TempARB};
  assign _zz_TempIm_1 = {TempA2BR[16],TempA2BR};
  assign _zz_DataOutRe = TempRe[14 : 6];
  assign _zz_DataOutIm = TempIm[14 : 6];
  assign _zz_mem_port = {DataInStream_payload_Im,DataInStream_payload_Re};
  assign _zz__zz_TempB = 1'b1;
  assign _zz__zz_TempB_1 = 1'b1;
  always @(posedge clk_out1) begin
    if(_zz_1) begin
      mem[wrAddr] <= _zz_mem_port;
    end
  end

  always @(posedge clk_out1) begin
    if(_zz__zz_TempB) begin
      mem_spinal_port1 <= mem[rdAddr];
    end
  end

  always @(posedge clk_out1) begin
    if(_zz__zz_TempB_1) begin
      mem_spinal_port2 <= mem[rdAddr];
    end
  end

  always @(*) begin
    _zz_1 = 1'b0;
    if(DataInStream_valid_regNext) begin
      _zz_1 = 1'b1;
    end
  end

  assign DataInStream_valid = ChannelCoefEnable;
  assign DataInStream_payload_Re = ChannelCoefRe;
  assign DataInStream_payload_Im = ChannelCoefIm;
  assign _zz_TempB = mem_spinal_port1[7 : 0];
  assign _zz_TempB_1 = mem_spinal_port2[15 : 8];
  always @(*) begin
    if(DataInEnable_regNext) begin
      TempEn1 = 1'b1;
    end else begin
      TempEn1 = 1'b0;
    end
  end

  assign DataOutEnable = TempEn3;
  assign DataOutRe = {TempRe[17],_zz_DataOutRe};
  assign DataOutIm = {TempIm[17],_zz_DataOutIm};
  assign DataOutSymbol = DataInSymbol_delay_3;
  always @(posedge clk_out1 or negedge rstN) begin
    if(!rstN) begin
      wrAddr <= 6'h0;
      rdAddr <= 6'h0;
      DataInStream_valid_regNext <= 1'b0;
      TempA1 <= 9'h0;
      TempA2 <= 9'h0;
      TempB <= 9'h0;
      TempAR <= 8'h0;
      TempBR <= 8'h0;
      TempBI <= 8'h0;
      TempARB <= 17'h0;
      TempA1BI <= 17'h0;
      TempA2BR <= 17'h0;
      TempEn3 <= 1'b0;
      TempRe <= 18'h0;
      TempIm <= 18'h0;
    end else begin
      DataInStream_valid_regNext <= DataInStream_valid;
      if(DataInStream_valid_regNext) begin
        wrAddr <= (wrAddr + 6'h01);
      end
      if(DataInEnable_regNext) begin
        TempA1 <= ($signed(_zz_TempA1) + $signed(_zz_TempA1_1));
        TempA2 <= ($signed(_zz_TempA2) - $signed(_zz_TempA2_1));
        TempB <= ($signed(_zz_TempB_2) + $signed(_zz_TempB_3));
        TempAR <= DataInRe;
        TempBR <= _zz_TempB;
        TempBI <= _zz_TempB_1;
      end else begin
        TempA1 <= 9'h0;
        TempA2 <= 9'h0;
        TempB <= 9'h0;
        TempAR <= 8'h0;
        TempBR <= 8'h0;
        TempBI <= 8'h0;
      end
      if(DataInEnable) begin
        rdAddr <= (rdAddr + 6'h01);
      end
      if(TempEn2) begin
        TempARB <= ($signed(TempAR) * $signed(TempB));
        TempA1BI <= ($signed(TempA1) * $signed(TempBI));
        TempA2BR <= ($signed(TempA2) * $signed(TempBR));
      end else begin
        TempARB <= 17'h0;
        TempA1BI <= 17'h0;
        TempA2BR <= 17'h0;
      end
      TempEn3 <= TempEn2;
      if(TempEn3) begin
        TempRe <= ($signed(_zz_TempRe) - $signed(_zz_TempRe_1));
        TempIm <= ($signed(_zz_TempIm) - $signed(_zz_TempIm_1));
      end else begin
        TempRe <= 18'h0;
        TempIm <= 18'h0;
      end
    end
  end

  always @(posedge clk_out1) begin
    DataInEnable_regNext <= DataInEnable;
    TempEn2 <= TempEn1;
    DataInSymbol_delay_1 <= DataInSymbol;
    DataInSymbol_delay_2 <= DataInSymbol_delay_1;
    DataInSymbol_delay_3 <= DataInSymbol_delay_2;
  end


endmodule
