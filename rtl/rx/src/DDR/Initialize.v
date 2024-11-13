// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : Initialize
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module Initialize (
  output wire [14:0]   io_control_address,
  output wire [2:0]    io_control_bank,
  output wire [0:0]    io_control_rasN,
  output wire [0:0]    io_control_casN,
  output wire [0:0]    io_control_weN,
  output wire [0:0]    io_control_csN,
  output wire [0:0]    io_control_cke,
  output wire [0:0]    io_control_odt,
  output wire [0:0]    io_control_resetN,
  output reg           io_initDone,
  input  wire          clk_out4,
  input  wire          rstN
);

  reg        [22:0]   refreshTimer;
  reg        [0:0]    cmd_weN;
  reg        [0:0]    cmd_casN;
  reg        [0:0]    cmd_rasN;
  reg        [0:0]    cmd_csN;
  reg        [14:0]   control_address;
  reg        [2:0]    control_bank;
  wire       [0:0]    control_rasN;
  wire       [0:0]    control_casN;
  wire       [0:0]    control_weN;
  wire       [0:0]    control_csN;
  reg        [0:0]    control_cke;
  wire       [0:0]    control_odt;
  wire       [0:0]    control_resetN;
  wire       [3:0]    _zz_cmd_weN;
  wire                when_Initialize_l51;
  wire                when_Initialize_l58;
  wire                when_Initialize_l61;
  wire       [3:0]    LOAD_MODE2;
  wire                when_Initialize_l66;
  wire       [3:0]    LOAD_MODE3;
  wire                when_Initialize_l71;
  wire       [3:0]    LOAD_MODE1;
  wire                when_Initialize_l76;
  wire       [3:0]    LOAD_MODE0;
  wire                when_Initialize_l81;
  wire       [3:0]    ZQCL;
  wire                when_Initialize_l85;
  wire       [3:0]    PRECHARGE;
  reg        [14:0]   control_regNext_address;
  reg        [2:0]    control_regNext_bank;
  reg        [0:0]    control_regNext_rasN;
  reg        [0:0]    control_regNext_casN;
  reg        [0:0]    control_regNext_weN;
  reg        [0:0]    control_regNext_csN;
  reg        [0:0]    control_regNext_cke;
  reg        [0:0]    control_regNext_odt;
  reg        [0:0]    control_regNext_resetN;

  assign _zz_cmd_weN = 4'b1111;
  always @(*) begin
    cmd_weN = _zz_cmd_weN[0 : 0];
    if(when_Initialize_l61) begin
      cmd_weN = LOAD_MODE2[0 : 0];
    end
    if(when_Initialize_l66) begin
      cmd_weN = LOAD_MODE3[0 : 0];
    end
    if(when_Initialize_l71) begin
      cmd_weN = LOAD_MODE1[0 : 0];
    end
    if(when_Initialize_l76) begin
      cmd_weN = LOAD_MODE0[0 : 0];
    end
    if(when_Initialize_l81) begin
      cmd_weN = ZQCL[0 : 0];
    end
    if(when_Initialize_l85) begin
      cmd_weN = PRECHARGE[0 : 0];
    end
  end

  always @(*) begin
    cmd_casN = _zz_cmd_weN[1 : 1];
    if(when_Initialize_l61) begin
      cmd_casN = LOAD_MODE2[1 : 1];
    end
    if(when_Initialize_l66) begin
      cmd_casN = LOAD_MODE3[1 : 1];
    end
    if(when_Initialize_l71) begin
      cmd_casN = LOAD_MODE1[1 : 1];
    end
    if(when_Initialize_l76) begin
      cmd_casN = LOAD_MODE0[1 : 1];
    end
    if(when_Initialize_l81) begin
      cmd_casN = ZQCL[1 : 1];
    end
    if(when_Initialize_l85) begin
      cmd_casN = PRECHARGE[1 : 1];
    end
  end

  always @(*) begin
    cmd_rasN = _zz_cmd_weN[2 : 2];
    if(when_Initialize_l61) begin
      cmd_rasN = LOAD_MODE2[2 : 2];
    end
    if(when_Initialize_l66) begin
      cmd_rasN = LOAD_MODE3[2 : 2];
    end
    if(when_Initialize_l71) begin
      cmd_rasN = LOAD_MODE1[2 : 2];
    end
    if(when_Initialize_l76) begin
      cmd_rasN = LOAD_MODE0[2 : 2];
    end
    if(when_Initialize_l81) begin
      cmd_rasN = ZQCL[2 : 2];
    end
    if(when_Initialize_l85) begin
      cmd_rasN = PRECHARGE[2 : 2];
    end
  end

  always @(*) begin
    cmd_csN = _zz_cmd_weN[3 : 3];
    if(when_Initialize_l61) begin
      cmd_csN = LOAD_MODE2[3 : 3];
    end
    if(when_Initialize_l66) begin
      cmd_csN = LOAD_MODE3[3 : 3];
    end
    if(when_Initialize_l71) begin
      cmd_csN = LOAD_MODE1[3 : 3];
    end
    if(when_Initialize_l76) begin
      cmd_csN = LOAD_MODE0[3 : 3];
    end
    if(when_Initialize_l81) begin
      cmd_csN = ZQCL[3 : 3];
    end
    if(when_Initialize_l85) begin
      cmd_csN = PRECHARGE[3 : 3];
    end
  end

  always @(*) begin
    io_initDone = 1'b0;
    if(when_Initialize_l51) begin
      io_initDone = 1'b1;
    end
  end

  always @(*) begin
    control_cke = 1'b1;
    if(when_Initialize_l58) begin
      control_cke = 1'b0;
    end
  end

  assign control_odt = 1'b0;
  assign control_resetN = 1'b1;
  always @(*) begin
    control_address = 15'h0;
    if(when_Initialize_l61) begin
      control_address = 15'h0008;
    end
    if(when_Initialize_l66) begin
      control_address = 15'h0;
    end
    if(when_Initialize_l71) begin
      control_address = 15'h0001;
    end
    if(when_Initialize_l76) begin
      control_address = 15'h0120;
    end
    if(when_Initialize_l81) begin
      control_address[10] = 1'b1;
    end
    if(when_Initialize_l85) begin
      control_address[10] = 1'b1;
    end
  end

  always @(*) begin
    control_bank = 3'b000;
    if(when_Initialize_l61) begin
      control_bank = 3'b010;
    end
    if(when_Initialize_l66) begin
      control_bank = 3'b011;
    end
    if(when_Initialize_l71) begin
      control_bank = 3'b001;
    end
    if(when_Initialize_l76) begin
      control_bank = 3'b000;
    end
  end

  assign when_Initialize_l51 = (refreshTimer == 23'h0);
  assign when_Initialize_l58 = (23'h00061a <= refreshTimer);
  assign when_Initialize_l61 = (refreshTimer == 23'h0005dc);
  assign LOAD_MODE2 = 4'b0000;
  assign when_Initialize_l66 = (refreshTimer == 23'h00059d);
  assign LOAD_MODE3 = 4'b0000;
  assign when_Initialize_l71 = (refreshTimer == 23'h00055f);
  assign LOAD_MODE1 = 4'b0000;
  assign when_Initialize_l76 = (refreshTimer == 23'h000520);
  assign LOAD_MODE0 = 4'b0000;
  assign when_Initialize_l81 = (refreshTimer == 23'h0004e2);
  assign ZQCL = 4'b0110;
  assign when_Initialize_l85 = (refreshTimer == 23'h000006);
  assign PRECHARGE = 4'b0010;
  assign control_rasN = cmd_rasN;
  assign control_casN = cmd_casN;
  assign control_weN = cmd_weN;
  assign control_csN = cmd_csN;
  assign io_control_address = control_regNext_address;
  assign io_control_bank = control_regNext_bank;
  assign io_control_rasN = control_regNext_rasN;
  assign io_control_casN = control_regNext_casN;
  assign io_control_weN = control_regNext_weN;
  assign io_control_csN = control_regNext_csN;
  assign io_control_cke = control_regNext_cke;
  assign io_control_odt = control_regNext_odt;
  assign io_control_resetN = control_regNext_resetN;
  always @(posedge clk_out4 or negedge rstN) begin
    if(!rstN) begin
      refreshTimer <= 23'h0;
    end else begin
      if(when_Initialize_l51) begin
        refreshTimer <= 23'h0;
      end else begin
        refreshTimer <= (refreshTimer - 23'h000001);
      end
    end
  end

  always @(posedge clk_out4) begin
    control_regNext_address <= control_address;
    control_regNext_bank <= control_bank;
    control_regNext_rasN <= control_rasN;
    control_regNext_casN <= control_casN;
    control_regNext_weN <= control_weN;
    control_regNext_csN <= control_csN;
    control_regNext_cke <= control_cke;
    control_regNext_odt <= control_odt;
    control_regNext_resetN <= control_resetN;
  end


endmodule
