// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : QAM16_Demapping
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module QAM16_Demapping (
  input  wire          EnergyInEn,
  input  wire [13:0]   EnergyPos,
  input  wire [13:0]   EnergyNeg,
  input  wire          inputDataEn,
  input  wire [9:0]    inputDataR,
  input  wire [9:0]    inputDataI,
  input  wire [7:0]    inputSymbol,
  output wire          outputDataEn,
  output wire [3:0]    outDataDemod,
  output wire [7:0]    outputSymbol,
  input  wire          clk_out1,
  input  wire          rstN
);

  reg        [27:0]   mem_spinal_port0;
  reg        [27:0]   mem_spinal_port1;
  wire       [5:0]    _zz_wrAddr_valueNext;
  wire       [0:0]    _zz_wrAddr_valueNext_1;
  wire       [5:0]    _zz_rdAddr_valueNext;
  wire       [0:0]    _zz_rdAddr_valueNext_1;
  wire                _zz_mem_port;
  wire                _zz__zz_AdjustI_E_P;
  wire                _zz_mem_port_1;
  wire                _zz__zz_AdjustI_E_N;
  wire       [27:0]   _zz_mem_port_2;
  wire       [13:0]   _zz_AdjustI_E_P_1;
  wire       [13:0]   _zz_AdjustI_E_N_1;
  wire       [13:0]   _zz_AdjustQ_E_P;
  wire       [13:0]   _zz_AdjustQ_E_N;
  reg                 _zz_1;
  wire                DataInStream_valid;
  wire       [13:0]   DataInStream_payload_Pos;
  wire       [13:0]   DataInStream_payload_Neg;
  reg                 wrAddr_willIncrement;
  wire                wrAddr_willClear;
  reg        [5:0]    wrAddr_valueNext;
  reg        [5:0]    wrAddr_value;
  wire                wrAddr_willOverflowIfInc;
  wire                wrAddr_willOverflow;
  reg                 rdAddr_willIncrement;
  wire                rdAddr_willClear;
  reg        [5:0]    rdAddr_valueNext;
  reg        [5:0]    rdAddr_value;
  wire                rdAddr_willOverflowIfInc;
  wire                rdAddr_willOverflow;
  wire       [13:0]   _zz_AdjustI_E_P;
  wire       [13:0]   _zz_AdjustI_E_N;
  wire                AdjustI_0_P;
  wire                AdjustI_E_P;
  wire                AdjustI_E_N;
  wire                AdjustQ_0_P;
  wire                AdjustQ_E_P;
  wire                AdjustQ_E_N;
  reg        [3:0]    TempOut;
  reg                 inputDataEn_regNext;
  reg        [3:0]    TempOut_regNext;
  reg        [7:0]    inputSymbol_regNext;
  reg [27:0] mem [0:63];

  assign _zz_wrAddr_valueNext_1 = wrAddr_willIncrement;
  assign _zz_wrAddr_valueNext = {5'd0, _zz_wrAddr_valueNext_1};
  assign _zz_rdAddr_valueNext_1 = rdAddr_willIncrement;
  assign _zz_rdAddr_valueNext = {5'd0, _zz_rdAddr_valueNext_1};
  assign _zz_AdjustI_E_P_1 = {{4{inputDataR[9]}}, inputDataR};
  assign _zz_AdjustI_E_N_1 = {{4{inputDataR[9]}}, inputDataR};
  assign _zz_AdjustQ_E_P = {{4{inputDataI[9]}}, inputDataI};
  assign _zz_AdjustQ_E_N = {{4{inputDataI[9]}}, inputDataI};
  assign _zz__zz_AdjustI_E_P = 1'b1;
  assign _zz__zz_AdjustI_E_N = 1'b1;
  assign _zz_mem_port_2 = {DataInStream_payload_Neg,DataInStream_payload_Pos};
  always @(posedge clk_out1) begin
    if(_zz__zz_AdjustI_E_P) begin
      mem_spinal_port0 <= mem[rdAddr_value];
    end
  end

  always @(posedge clk_out1) begin
    if(_zz__zz_AdjustI_E_N) begin
      mem_spinal_port1 <= mem[rdAddr_value];
    end
  end

  always @(posedge clk_out1) begin
    if(_zz_1) begin
      mem[wrAddr_value] <= _zz_mem_port_2;
    end
  end

  always @(*) begin
    _zz_1 = 1'b0;
    if(DataInStream_valid) begin
      _zz_1 = 1'b1;
    end
  end

  assign DataInStream_valid = EnergyInEn;
  assign DataInStream_payload_Pos = EnergyPos;
  assign DataInStream_payload_Neg = EnergyNeg;
  always @(*) begin
    wrAddr_willIncrement = 1'b0;
    if(DataInStream_valid) begin
      wrAddr_willIncrement = 1'b1;
    end
  end

  assign wrAddr_willClear = 1'b0;
  assign wrAddr_willOverflowIfInc = (wrAddr_value == 6'h2f);
  assign wrAddr_willOverflow = (wrAddr_willOverflowIfInc && wrAddr_willIncrement);
  always @(*) begin
    if(wrAddr_willOverflow) begin
      wrAddr_valueNext = 6'h0;
    end else begin
      wrAddr_valueNext = (wrAddr_value + _zz_wrAddr_valueNext);
    end
    if(wrAddr_willClear) begin
      wrAddr_valueNext = 6'h0;
    end
  end

  always @(*) begin
    rdAddr_willIncrement = 1'b0;
    if(inputDataEn) begin
      rdAddr_willIncrement = 1'b1;
    end
  end

  assign rdAddr_willClear = 1'b0;
  assign rdAddr_willOverflowIfInc = (rdAddr_value == 6'h2f);
  assign rdAddr_willOverflow = (rdAddr_willOverflowIfInc && rdAddr_willIncrement);
  always @(*) begin
    if(rdAddr_willOverflow) begin
      rdAddr_valueNext = 6'h0;
    end else begin
      rdAddr_valueNext = (rdAddr_value + _zz_rdAddr_valueNext);
    end
    if(rdAddr_willClear) begin
      rdAddr_valueNext = 6'h0;
    end
  end

  assign _zz_AdjustI_E_P = mem_spinal_port0[13 : 0];
  assign _zz_AdjustI_E_N = mem_spinal_port1[27 : 14];
  assign AdjustI_0_P = ($signed(10'h0) < $signed(inputDataR));
  assign AdjustI_E_P = ($signed(_zz_AdjustI_E_P_1) <= $signed(_zz_AdjustI_E_P));
  assign AdjustI_E_N = ($signed(_zz_AdjustI_E_N) <= $signed(_zz_AdjustI_E_N_1));
  assign AdjustQ_0_P = ($signed(10'h0) < $signed(inputDataI));
  assign AdjustQ_E_P = ($signed(_zz_AdjustQ_E_P) <= $signed(_zz_AdjustI_E_P));
  assign AdjustQ_E_N = ($signed(_zz_AdjustI_E_N) <= $signed(_zz_AdjustQ_E_N));
  always @(*) begin
    TempOut[3 : 2] = {(AdjustI_0_P ? AdjustI_E_P : AdjustI_E_N),AdjustI_0_P};
    TempOut[1 : 0] = {(AdjustQ_0_P ? AdjustQ_E_P : AdjustQ_E_N),AdjustQ_0_P};
  end

  assign outputDataEn = inputDataEn_regNext;
  assign outDataDemod = TempOut_regNext;
  assign outputSymbol = inputSymbol_regNext;
  always @(posedge clk_out1 or negedge rstN) begin
    if(!rstN) begin
      wrAddr_value <= 6'h0;
      rdAddr_value <= 6'h0;
      inputDataEn_regNext <= 1'b0;
      TempOut_regNext <= 4'b0000;
      inputSymbol_regNext <= 8'h0;
    end else begin
      wrAddr_value <= wrAddr_valueNext;
      rdAddr_value <= rdAddr_valueNext;
      inputDataEn_regNext <= inputDataEn;
      TempOut_regNext <= TempOut;
      inputSymbol_regNext <= inputSymbol;
    end
  end


endmodule
