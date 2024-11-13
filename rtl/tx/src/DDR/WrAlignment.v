// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : WrAlignment
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module WrAlignment (
  input  wire          io_idfiWrData_0_valid,
  input  wire [31:0]   io_idfiWrData_0_payload_wrData,
  input  wire [3:0]    io_idfiWrData_0_payload_wrDataMask,
  output wire          io_dfiWr_wr_0_wrdataEn,
  output reg  [31:0]   io_dfiWr_wr_0_wrdata,
  output reg  [3:0]    io_dfiWr_wr_0_wrdataMask,
  input  wire          clk_out4,
  input  wire          rstN
);

  reg        [0:0]    delay;
  wire                _zz_when_DfiAlignment_l132;
  reg                 _zz_when_DfiAlignment_l132_1;
  wire                when_DfiAlignment_l132;
  wire       [31:0]   wrdatahistary_0_0_wrData;
  wire       [3:0]    wrdatahistary_0_0_wrDataMask;
  wire       [31:0]   wrdatahistary_0_1_wrData;
  wire       [3:0]    wrdatahistary_0_1_wrDataMask;
  wire       [31:0]   _zz_wrdatahistary_0_0_wrData;
  wire       [3:0]    _zz_wrdatahistary_0_0_wrDataMask;
  reg        [31:0]   _zz_wrdatahistary_0_1_wrData;
  reg        [3:0]    _zz_wrdatahistary_0_1_wrDataMask;
  reg        [31:0]   _zz_io_dfiWr_wr_0_wrdata;
  reg        [3:0]    _zz_io_dfiWr_wr_0_wrdataMask;

  assign io_dfiWr_wr_0_wrdataEn = io_idfiWrData_0_valid;
  assign _zz_when_DfiAlignment_l132 = (|io_idfiWrData_0_valid);
  assign when_DfiAlignment_l132 = (_zz_when_DfiAlignment_l132 && (! _zz_when_DfiAlignment_l132_1));
  assign _zz_wrdatahistary_0_0_wrData = io_idfiWrData_0_payload_wrData;
  assign _zz_wrdatahistary_0_0_wrDataMask = io_idfiWrData_0_payload_wrDataMask;
  assign wrdatahistary_0_0_wrData = _zz_wrdatahistary_0_0_wrData;
  assign wrdatahistary_0_0_wrDataMask = _zz_wrdatahistary_0_0_wrDataMask;
  assign wrdatahistary_0_1_wrData = _zz_wrdatahistary_0_1_wrData;
  assign wrdatahistary_0_1_wrDataMask = _zz_wrdatahistary_0_1_wrDataMask;
  always @(*) begin
    io_dfiWr_wr_0_wrdata = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    io_dfiWr_wr_0_wrdata = _zz_io_dfiWr_wr_0_wrdata;
  end

  always @(*) begin
    io_dfiWr_wr_0_wrdataMask = 4'bxxxx;
    io_dfiWr_wr_0_wrdataMask = _zz_io_dfiWr_wr_0_wrdataMask;
  end

  always @(*) begin
    _zz_io_dfiWr_wr_0_wrdata = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    case(delay)
      1'b0 : begin
        _zz_io_dfiWr_wr_0_wrdata = wrdatahistary_0_0_wrData;
      end
      default : begin
        _zz_io_dfiWr_wr_0_wrdata = wrdatahistary_0_1_wrData;
      end
    endcase
  end

  always @(*) begin
    _zz_io_dfiWr_wr_0_wrdataMask = 4'bxxxx;
    case(delay)
      1'b0 : begin
        _zz_io_dfiWr_wr_0_wrdataMask = wrdatahistary_0_0_wrDataMask;
      end
      default : begin
        _zz_io_dfiWr_wr_0_wrdataMask = wrdatahistary_0_1_wrDataMask;
      end
    endcase
  end

  always @(posedge clk_out4 or negedge rstN) begin
    if(!rstN) begin
      delay <= 1'b0;
    end else begin
      if(when_DfiAlignment_l132) begin
        delay <= 1'b0;
      end
    end
  end

  always @(posedge clk_out4) begin
    _zz_when_DfiAlignment_l132_1 <= _zz_when_DfiAlignment_l132;
    _zz_wrdatahistary_0_1_wrData <= _zz_wrdatahistary_0_0_wrData;
    _zz_wrdatahistary_0_1_wrDataMask <= _zz_wrdatahistary_0_0_wrDataMask;
  end


endmodule
