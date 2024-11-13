// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : CmdTxd
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module CmdTxd (
  input  wire          io_task_read,
  input  wire          io_task_write,
  input  wire          io_task_active,
  input  wire          io_task_precharge,
  input  wire          io_task_last,
  input  wire [0:0]    io_task_address_byte,
  input  wire [9:0]    io_task_address_column,
  input  wire [2:0]    io_task_address_bank,
  input  wire [14:0]   io_task_address_row,
  input  wire [17:0]   io_task_context,
  input  wire          io_task_prechargeAll,
  input  wire          io_task_refresh,
  output reg           io_cmd_0_valid,
  output reg           io_cmd_0_payload_weN,
  output reg           io_cmd_0_payload_casN,
  output reg           io_cmd_0_payload_rasN,
  output reg  [0:0]    io_cmd_0_payload_csN,
  output reg           io_address_0_valid,
  output reg  [2:0]    io_address_0_payload_bank,
  output reg  [14:0]   io_address_0_payload_address
);

  wire       [3:0]    _zz_io_cmd_0_payload_weN;
  wire       [3:0]    ACTIVE;
  wire       [3:0]    WRITE;
  wire       [3:0]    READ;
  wire       [3:0]    PRECHARGE;
  wire       [3:0]    PRECHARGEALL;
  wire       [3:0]    REFRESH;

  always @(*) begin
    io_cmd_0_valid = 1'b0;
    if(io_task_active) begin
      io_cmd_0_valid = 1'b1;
    end
    if(io_task_write) begin
      io_cmd_0_valid = 1'b1;
    end
    if(io_task_read) begin
      io_cmd_0_valid = 1'b1;
    end
    if(io_task_precharge) begin
      io_cmd_0_valid = 1'b1;
    end
    if(io_task_prechargeAll) begin
      io_cmd_0_valid = 1'b1;
    end
    if(io_task_refresh) begin
      io_cmd_0_valid = 1'b1;
    end
  end

  assign _zz_io_cmd_0_payload_weN = 4'b1111;
  always @(*) begin
    io_cmd_0_payload_weN = _zz_io_cmd_0_payload_weN[0];
    if(io_task_active) begin
      io_cmd_0_payload_weN = ACTIVE[0];
    end
    if(io_task_write) begin
      io_cmd_0_payload_weN = WRITE[0];
    end
    if(io_task_read) begin
      io_cmd_0_payload_weN = READ[0];
    end
    if(io_task_precharge) begin
      io_cmd_0_payload_weN = PRECHARGE[0];
    end
    if(io_task_prechargeAll) begin
      io_cmd_0_payload_weN = PRECHARGEALL[0];
    end
    if(io_task_refresh) begin
      io_cmd_0_payload_weN = REFRESH[0];
    end
  end

  always @(*) begin
    io_cmd_0_payload_casN = _zz_io_cmd_0_payload_weN[1];
    if(io_task_active) begin
      io_cmd_0_payload_casN = ACTIVE[1];
    end
    if(io_task_write) begin
      io_cmd_0_payload_casN = WRITE[1];
    end
    if(io_task_read) begin
      io_cmd_0_payload_casN = READ[1];
    end
    if(io_task_precharge) begin
      io_cmd_0_payload_casN = PRECHARGE[1];
    end
    if(io_task_prechargeAll) begin
      io_cmd_0_payload_casN = PRECHARGEALL[1];
    end
    if(io_task_refresh) begin
      io_cmd_0_payload_casN = REFRESH[1];
    end
  end

  always @(*) begin
    io_cmd_0_payload_rasN = _zz_io_cmd_0_payload_weN[2];
    if(io_task_active) begin
      io_cmd_0_payload_rasN = ACTIVE[2];
    end
    if(io_task_write) begin
      io_cmd_0_payload_rasN = WRITE[2];
    end
    if(io_task_read) begin
      io_cmd_0_payload_rasN = READ[2];
    end
    if(io_task_precharge) begin
      io_cmd_0_payload_rasN = PRECHARGE[2];
    end
    if(io_task_prechargeAll) begin
      io_cmd_0_payload_rasN = PRECHARGEALL[2];
    end
    if(io_task_refresh) begin
      io_cmd_0_payload_rasN = REFRESH[2];
    end
  end

  always @(*) begin
    io_cmd_0_payload_csN = _zz_io_cmd_0_payload_weN[3 : 3];
    if(io_task_active) begin
      io_cmd_0_payload_csN = ACTIVE[3 : 3];
    end
    if(io_task_write) begin
      io_cmd_0_payload_csN = WRITE[3 : 3];
    end
    if(io_task_read) begin
      io_cmd_0_payload_csN = READ[3 : 3];
    end
    if(io_task_precharge) begin
      io_cmd_0_payload_csN = PRECHARGE[3 : 3];
    end
    if(io_task_prechargeAll) begin
      io_cmd_0_payload_csN = PRECHARGEALL[3 : 3];
    end
    if(io_task_refresh) begin
      io_cmd_0_payload_csN = REFRESH[3 : 3];
    end
  end

  always @(*) begin
    io_address_0_valid = 1'b0;
    if(io_task_active) begin
      io_address_0_valid = 1'b1;
    end
    if(io_task_write) begin
      io_address_0_valid = 1'b1;
    end
    if(io_task_read) begin
      io_address_0_valid = 1'b1;
    end
    if(io_task_precharge) begin
      io_address_0_valid = 1'b1;
    end
    if(io_task_prechargeAll) begin
      io_address_0_valid = 1'b1;
    end
    if(io_task_refresh) begin
      io_address_0_valid = 1'b1;
    end
  end

  always @(*) begin
    io_address_0_payload_address = 15'h0;
    if(io_task_active) begin
      io_address_0_payload_address = io_task_address_row;
    end
    if(io_task_write) begin
      io_address_0_payload_address[9 : 0] = io_task_address_column;
      io_address_0_payload_address[10] = 1'b0;
    end
    if(io_task_read) begin
      io_address_0_payload_address[9 : 0] = io_task_address_column;
      io_address_0_payload_address[10] = 1'b0;
    end
    if(io_task_precharge) begin
      io_address_0_payload_address[10] = 1'b0;
    end
    if(io_task_prechargeAll) begin
      io_address_0_payload_address[10] = 1'b1;
    end
  end

  always @(*) begin
    io_address_0_payload_bank = 3'b000;
    if(io_task_active) begin
      io_address_0_payload_bank = io_task_address_bank;
    end
    if(io_task_write) begin
      io_address_0_payload_bank = io_task_address_bank;
    end
    if(io_task_read) begin
      io_address_0_payload_bank = io_task_address_bank;
    end
    if(io_task_precharge) begin
      io_address_0_payload_bank = io_task_address_bank;
    end
  end

  assign ACTIVE = {(~ 1'b1),3'b011};
  assign WRITE = {(~ 1'b1),3'b100};
  assign READ = {(~ 1'b1),3'b101};
  assign PRECHARGE = {(~ 1'b1),3'b010};
  assign PRECHARGEALL = {(~ 1'b1),3'b010};
  assign REFRESH = {(~ 1'b1),3'b001};

endmodule
