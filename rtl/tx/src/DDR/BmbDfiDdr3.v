// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : BmbDfiDdr3
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module BmbDfiDdr3 (
  input  wire          io_clk1,
  input  wire          io_clk2,
  input  wire          io_clk3,
  input  wire          io_clk4,
  input  wire          io_bmb_cmd_valid,
  output wire          io_bmb_cmd_ready,
  input  wire          io_bmb_cmd_payload_last,
  input  wire [0:0]    io_bmb_cmd_payload_fragment_opcode,
  input  wire [28:0]   io_bmb_cmd_payload_fragment_address,
  input  wire [9:0]    io_bmb_cmd_payload_fragment_length,
  input  wire [31:0]   io_bmb_cmd_payload_fragment_data,
  input  wire [3:0]    io_bmb_cmd_payload_fragment_mask,
  input  wire [3:0]    io_bmb_cmd_payload_fragment_context,
  output wire          io_bmb_rsp_valid,
  input  wire          io_bmb_rsp_ready,
  output wire          io_bmb_rsp_payload_last,
  output wire [0:0]    io_bmb_rsp_payload_fragment_opcode,
  output wire [31:0]   io_bmb_rsp_payload_fragment_data,
  output wire [3:0]    io_bmb_rsp_payload_fragment_context,
  output wire [0:0]    io_ddr3_ckP,
  output wire [0:0]    io_ddr3_ckN,
  output wire [0:0]    io_ddr3_cke,
  output wire [0:0]    io_ddr3_resetN,
  output wire [0:0]    io_ddr3_rasN,
  output wire [0:0]    io_ddr3_casN,
  output wire [0:0]    io_ddr3_weN,
  output wire [0:0]    io_ddr3_csN,
  output wire [2:0]    io_ddr3_ba,
  output wire [14:0]   io_ddr3_addr,
  output wire [0:0]    io_ddr3_odt,
  output wire [1:0]    io_ddr3_dm,
  inout  wire [1:0]    io_ddr3_dqsP,
  inout  wire [1:0]    io_ddr3_dqsN,
  inout  wire [15:0]   io_ddr3_dq,
  output wire          io_initDone,
  input  wire          clk_out4,
  input  wire          rstN
);

  wire                clockArea_dfiController_io_dfi_read_rd_0_rddataValid;
  wire                ddr3_dfi_phy_0_io_rst;
  wire       [0:0]    ddr3_dfi_phy_0_io_dfi_control_csN;
  wire       [0:0]    ddr3_dfi_phy_0_io_dfi_control_cke;
  wire                clockArea_dfiController_io_bmb_cmd_ready;
  wire                clockArea_dfiController_io_bmb_rsp_valid;
  wire                clockArea_dfiController_io_bmb_rsp_payload_last;
  wire       [0:0]    clockArea_dfiController_io_bmb_rsp_payload_fragment_opcode;
  wire       [31:0]   clockArea_dfiController_io_bmb_rsp_payload_fragment_data;
  wire       [3:0]    clockArea_dfiController_io_bmb_rsp_payload_fragment_context;
  wire       [14:0]   clockArea_dfiController_io_dfi_control_address;
  wire       [2:0]    clockArea_dfiController_io_dfi_control_bank;
  wire       [0:0]    clockArea_dfiController_io_dfi_control_rasN;
  wire       [0:0]    clockArea_dfiController_io_dfi_control_casN;
  wire       [0:0]    clockArea_dfiController_io_dfi_control_weN;
  wire       [0:0]    clockArea_dfiController_io_dfi_control_csN;
  wire       [0:0]    clockArea_dfiController_io_dfi_control_cke;
  wire                clockArea_dfiController_io_dfi_read_rden_0;
  wire                clockArea_dfiController_io_dfi_write_wr_0_wrdataEn;
  wire       [31:0]   clockArea_dfiController_io_dfi_write_wr_0_wrdata;
  wire       [3:0]    clockArea_dfiController_io_dfi_write_wr_0_wrdataMask;
  wire                ddr3_dfi_phy_0_io_initDone;
  wire                ddr3_dfi_phy_0_io_dfi_read_rd_0_rddataValid;
  wire       [31:0]   ddr3_dfi_phy_0_io_dfi_read_rd_0_rddata;
  wire       [3:0]    ddr3_dfi_phy_0_io_dfi_read_rd_0_rddataDnv;
  wire       [0:0]    ddr3_dfi_phy_0_io_ddr3_ckP;
  wire       [0:0]    ddr3_dfi_phy_0_io_ddr3_ckN;
  wire       [0:0]    ddr3_dfi_phy_0_io_ddr3_cke;
  wire       [0:0]    ddr3_dfi_phy_0_io_ddr3_resetN;
  wire       [0:0]    ddr3_dfi_phy_0_io_ddr3_rasN;
  wire       [0:0]    ddr3_dfi_phy_0_io_ddr3_casN;
  wire       [0:0]    ddr3_dfi_phy_0_io_ddr3_weN;
  wire       [0:0]    ddr3_dfi_phy_0_io_ddr3_csN;
  wire       [2:0]    ddr3_dfi_phy_0_io_ddr3_ba;
  wire       [14:0]   ddr3_dfi_phy_0_io_ddr3_addr;
  wire       [0:0]    ddr3_dfi_phy_0_io_ddr3_odt;
  wire       [1:0]    ddr3_dfi_phy_0_io_ddr3_dm;
  wire                _zz_io_bmb_rsp_valid;
  wire                _zz_io_bmb_rsp_ready;
  wire                _zz_io_bmb_rsp_payload_last;
  wire       [0:0]    _zz_io_bmb_rsp_payload_fragment_opcode;
  wire       [31:0]   _zz_io_bmb_rsp_payload_fragment_data;
  wire       [3:0]    _zz_io_bmb_rsp_payload_fragment_context;
  wire                io_bmb_cmd_s2mPipe_valid;
  reg                 io_bmb_cmd_s2mPipe_ready;
  wire                io_bmb_cmd_s2mPipe_payload_last;
  wire       [0:0]    io_bmb_cmd_s2mPipe_payload_fragment_opcode;
  wire       [28:0]   io_bmb_cmd_s2mPipe_payload_fragment_address;
  wire       [9:0]    io_bmb_cmd_s2mPipe_payload_fragment_length;
  wire       [31:0]   io_bmb_cmd_s2mPipe_payload_fragment_data;
  wire       [3:0]    io_bmb_cmd_s2mPipe_payload_fragment_mask;
  wire       [3:0]    io_bmb_cmd_s2mPipe_payload_fragment_context;
  reg                 io_bmb_cmd_rValidN;
  reg                 io_bmb_cmd_rData_last;
  reg        [0:0]    io_bmb_cmd_rData_fragment_opcode;
  reg        [28:0]   io_bmb_cmd_rData_fragment_address;
  reg        [9:0]    io_bmb_cmd_rData_fragment_length;
  reg        [31:0]   io_bmb_cmd_rData_fragment_data;
  reg        [3:0]    io_bmb_cmd_rData_fragment_mask;
  reg        [3:0]    io_bmb_cmd_rData_fragment_context;
  wire                io_bmb_cmd_s2mPipe_m2sPipe_valid;
  wire                io_bmb_cmd_s2mPipe_m2sPipe_ready;
  wire                io_bmb_cmd_s2mPipe_m2sPipe_payload_last;
  wire       [0:0]    io_bmb_cmd_s2mPipe_m2sPipe_payload_fragment_opcode;
  wire       [28:0]   io_bmb_cmd_s2mPipe_m2sPipe_payload_fragment_address;
  wire       [9:0]    io_bmb_cmd_s2mPipe_m2sPipe_payload_fragment_length;
  wire       [31:0]   io_bmb_cmd_s2mPipe_m2sPipe_payload_fragment_data;
  wire       [3:0]    io_bmb_cmd_s2mPipe_m2sPipe_payload_fragment_mask;
  wire       [3:0]    io_bmb_cmd_s2mPipe_m2sPipe_payload_fragment_context;
  reg                 io_bmb_cmd_s2mPipe_rValid;
  reg                 io_bmb_cmd_s2mPipe_rData_last;
  reg        [0:0]    io_bmb_cmd_s2mPipe_rData_fragment_opcode;
  reg        [28:0]   io_bmb_cmd_s2mPipe_rData_fragment_address;
  reg        [9:0]    io_bmb_cmd_s2mPipe_rData_fragment_length;
  reg        [31:0]   io_bmb_cmd_s2mPipe_rData_fragment_data;
  reg        [3:0]    io_bmb_cmd_s2mPipe_rData_fragment_mask;
  reg        [3:0]    io_bmb_cmd_s2mPipe_rData_fragment_context;
  wire                when_Stream_l393;
  reg                 _zz_1;
  reg                 _zz_io_bmb_rsp_payload_last_1;
  reg                 _zz_io_bmb_rsp_payload_last_2;
  reg        [0:0]    _zz_io_bmb_rsp_payload_fragment_opcode_1;
  reg        [31:0]   _zz_io_bmb_rsp_payload_fragment_data_1;
  reg        [3:0]    _zz_io_bmb_rsp_payload_fragment_context_1;
  wire                _zz_io_bmb_rsp_valid_1;
  reg                 _zz_io_bmb_rsp_valid_2;
  reg                 _zz_io_bmb_rsp_payload_last_3;
  reg        [0:0]    _zz_io_bmb_rsp_payload_fragment_opcode_2;
  reg        [31:0]   _zz_io_bmb_rsp_payload_fragment_data_2;
  reg        [3:0]    _zz_io_bmb_rsp_payload_fragment_context_2;
  wire                when_Stream_l393_1;

  DfiController clockArea_dfiController (
    .io_bmb_cmd_valid                    (io_bmb_cmd_s2mPipe_m2sPipe_valid                                ), //i
    .io_bmb_cmd_ready                    (clockArea_dfiController_io_bmb_cmd_ready                        ), //o
    .io_bmb_cmd_payload_last             (io_bmb_cmd_s2mPipe_m2sPipe_payload_last                         ), //i
    .io_bmb_cmd_payload_fragment_opcode  (io_bmb_cmd_s2mPipe_m2sPipe_payload_fragment_opcode              ), //i
    .io_bmb_cmd_payload_fragment_address (io_bmb_cmd_s2mPipe_m2sPipe_payload_fragment_address[28:0]       ), //i
    .io_bmb_cmd_payload_fragment_length  (io_bmb_cmd_s2mPipe_m2sPipe_payload_fragment_length[9:0]         ), //i
    .io_bmb_cmd_payload_fragment_data    (io_bmb_cmd_s2mPipe_m2sPipe_payload_fragment_data[31:0]          ), //i
    .io_bmb_cmd_payload_fragment_mask    (io_bmb_cmd_s2mPipe_m2sPipe_payload_fragment_mask[3:0]           ), //i
    .io_bmb_cmd_payload_fragment_context (io_bmb_cmd_s2mPipe_m2sPipe_payload_fragment_context[3:0]        ), //i
    .io_bmb_rsp_valid                    (clockArea_dfiController_io_bmb_rsp_valid                        ), //o
    .io_bmb_rsp_ready                    (_zz_io_bmb_rsp_ready                                            ), //i
    .io_bmb_rsp_payload_last             (clockArea_dfiController_io_bmb_rsp_payload_last                 ), //o
    .io_bmb_rsp_payload_fragment_opcode  (clockArea_dfiController_io_bmb_rsp_payload_fragment_opcode      ), //o
    .io_bmb_rsp_payload_fragment_data    (clockArea_dfiController_io_bmb_rsp_payload_fragment_data[31:0]  ), //o
    .io_bmb_rsp_payload_fragment_context (clockArea_dfiController_io_bmb_rsp_payload_fragment_context[3:0]), //o
    .io_dfi_control_address              (clockArea_dfiController_io_dfi_control_address[14:0]            ), //o
    .io_dfi_control_bank                 (clockArea_dfiController_io_dfi_control_bank[2:0]                ), //o
    .io_dfi_control_rasN                 (clockArea_dfiController_io_dfi_control_rasN                     ), //o
    .io_dfi_control_casN                 (clockArea_dfiController_io_dfi_control_casN                     ), //o
    .io_dfi_control_weN                  (clockArea_dfiController_io_dfi_control_weN                      ), //o
    .io_dfi_control_csN                  (clockArea_dfiController_io_dfi_control_csN                      ), //o
    .io_dfi_control_cke                  (clockArea_dfiController_io_dfi_control_cke                      ), //o
    .io_dfi_write_wr_0_wrdataEn          (clockArea_dfiController_io_dfi_write_wr_0_wrdataEn              ), //o
    .io_dfi_write_wr_0_wrdata            (clockArea_dfiController_io_dfi_write_wr_0_wrdata[31:0]          ), //o
    .io_dfi_write_wr_0_wrdataMask        (clockArea_dfiController_io_dfi_write_wr_0_wrdataMask[3:0]       ), //o
    .io_dfi_read_rden_0                  (clockArea_dfiController_io_dfi_read_rden_0                      ), //o
    .io_dfi_read_rd_0_rddataValid        (clockArea_dfiController_io_dfi_read_rd_0_rddataValid            ), //i
    .io_dfi_read_rd_0_rddata             (ddr3_dfi_phy_0_io_dfi_read_rd_0_rddata[31:0]                    ), //i
    .clk_out4                            (clk_out4                                                        ), //i
    .rstN                                (rstN                                                            )  //i
  );
  DfiPhyDdr3 ddr3_dfi_phy_0 (
    .io_clk_work                  (io_clk1                                                  ), //i
    .io_clk_ddr                   (io_clk2                                                  ), //i
    .io_clk_ddr90                 (io_clk3                                                  ), //i
    .io_clk_ref                   (io_clk4                                                  ), //i
    .io_rst                       (ddr3_dfi_phy_0_io_rst                                    ), //i
    .io_initDone                  (ddr3_dfi_phy_0_io_initDone                               ), //o
    .io_dfi_control_address       (clockArea_dfiController_io_dfi_control_address[14:0]     ), //i
    .io_dfi_control_bank          (clockArea_dfiController_io_dfi_control_bank[2:0]         ), //i
    .io_dfi_control_rasN          (clockArea_dfiController_io_dfi_control_rasN              ), //i
    .io_dfi_control_casN          (clockArea_dfiController_io_dfi_control_casN              ), //i
    .io_dfi_control_weN           (clockArea_dfiController_io_dfi_control_weN               ), //i
    .io_dfi_control_csN           (ddr3_dfi_phy_0_io_dfi_control_csN                        ), //i
    .io_dfi_control_cke           (ddr3_dfi_phy_0_io_dfi_control_cke                        ), //i
    .io_dfi_control_odt           (1'b0                                                     ), //i
    .io_dfi_control_resetN        (1'b1                                                     ), //i
    .io_dfi_write_wr_0_wrdataEn   (clockArea_dfiController_io_dfi_write_wr_0_wrdataEn       ), //i
    .io_dfi_write_wr_0_wrdata     (clockArea_dfiController_io_dfi_write_wr_0_wrdata[31:0]   ), //i
    .io_dfi_write_wr_0_wrdataMask (clockArea_dfiController_io_dfi_write_wr_0_wrdataMask[3:0]), //i
    .io_dfi_read_rden_0           (clockArea_dfiController_io_dfi_read_rden_0               ), //i
    .io_dfi_read_rd_0_rddataValid (ddr3_dfi_phy_0_io_dfi_read_rd_0_rddataValid              ), //o
    .io_dfi_read_rd_0_rddata      (ddr3_dfi_phy_0_io_dfi_read_rd_0_rddata[31:0]             ), //o
    .io_dfi_read_rd_0_rddataDnv   (ddr3_dfi_phy_0_io_dfi_read_rd_0_rddataDnv[3:0]           ), //o
    .io_ddr3_ckP                  (ddr3_dfi_phy_0_io_ddr3_ckP                               ), //o
    .io_ddr3_ckN                  (ddr3_dfi_phy_0_io_ddr3_ckN                               ), //o
    .io_ddr3_cke                  (ddr3_dfi_phy_0_io_ddr3_cke                               ), //o
    .io_ddr3_resetN               (ddr3_dfi_phy_0_io_ddr3_resetN                            ), //o
    .io_ddr3_rasN                 (ddr3_dfi_phy_0_io_ddr3_rasN                              ), //o
    .io_ddr3_casN                 (ddr3_dfi_phy_0_io_ddr3_casN                              ), //o
    .io_ddr3_weN                  (ddr3_dfi_phy_0_io_ddr3_weN                               ), //o
    .io_ddr3_csN                  (ddr3_dfi_phy_0_io_ddr3_csN                               ), //o
    .io_ddr3_ba                   (ddr3_dfi_phy_0_io_ddr3_ba[2:0]                           ), //o
    .io_ddr3_addr                 (ddr3_dfi_phy_0_io_ddr3_addr[14:0]                        ), //o
    .io_ddr3_odt                  (ddr3_dfi_phy_0_io_ddr3_odt                               ), //o
    .io_ddr3_dm                   (ddr3_dfi_phy_0_io_ddr3_dm[1:0]                           ), //o
    .io_ddr3_dqsP                 (io_ddr3_dqsP                                             ), //~
    .io_ddr3_dqsN                 (io_ddr3_dqsN                                             ), //~
    .io_ddr3_dq                   (io_ddr3_dq                                               ), //~
    .clk_out4                     (clk_out4                                                 ), //i
    .rstN                         (rstN                                                     )  //i
  );
  assign io_bmb_cmd_ready = io_bmb_cmd_rValidN;
  assign io_bmb_cmd_s2mPipe_valid = (io_bmb_cmd_valid || (! io_bmb_cmd_rValidN));
  assign io_bmb_cmd_s2mPipe_payload_last = (io_bmb_cmd_rValidN ? io_bmb_cmd_payload_last : io_bmb_cmd_rData_last);
  assign io_bmb_cmd_s2mPipe_payload_fragment_opcode = (io_bmb_cmd_rValidN ? io_bmb_cmd_payload_fragment_opcode : io_bmb_cmd_rData_fragment_opcode);
  assign io_bmb_cmd_s2mPipe_payload_fragment_address = (io_bmb_cmd_rValidN ? io_bmb_cmd_payload_fragment_address : io_bmb_cmd_rData_fragment_address);
  assign io_bmb_cmd_s2mPipe_payload_fragment_length = (io_bmb_cmd_rValidN ? io_bmb_cmd_payload_fragment_length : io_bmb_cmd_rData_fragment_length);
  assign io_bmb_cmd_s2mPipe_payload_fragment_data = (io_bmb_cmd_rValidN ? io_bmb_cmd_payload_fragment_data : io_bmb_cmd_rData_fragment_data);
  assign io_bmb_cmd_s2mPipe_payload_fragment_mask = (io_bmb_cmd_rValidN ? io_bmb_cmd_payload_fragment_mask : io_bmb_cmd_rData_fragment_mask);
  assign io_bmb_cmd_s2mPipe_payload_fragment_context = (io_bmb_cmd_rValidN ? io_bmb_cmd_payload_fragment_context : io_bmb_cmd_rData_fragment_context);
  always @(*) begin
    io_bmb_cmd_s2mPipe_ready = io_bmb_cmd_s2mPipe_m2sPipe_ready;
    if(when_Stream_l393) begin
      io_bmb_cmd_s2mPipe_ready = 1'b1;
    end
  end

  assign when_Stream_l393 = (! io_bmb_cmd_s2mPipe_m2sPipe_valid);
  assign io_bmb_cmd_s2mPipe_m2sPipe_valid = io_bmb_cmd_s2mPipe_rValid;
  assign io_bmb_cmd_s2mPipe_m2sPipe_payload_last = io_bmb_cmd_s2mPipe_rData_last;
  assign io_bmb_cmd_s2mPipe_m2sPipe_payload_fragment_opcode = io_bmb_cmd_s2mPipe_rData_fragment_opcode;
  assign io_bmb_cmd_s2mPipe_m2sPipe_payload_fragment_address = io_bmb_cmd_s2mPipe_rData_fragment_address;
  assign io_bmb_cmd_s2mPipe_m2sPipe_payload_fragment_length = io_bmb_cmd_s2mPipe_rData_fragment_length;
  assign io_bmb_cmd_s2mPipe_m2sPipe_payload_fragment_data = io_bmb_cmd_s2mPipe_rData_fragment_data;
  assign io_bmb_cmd_s2mPipe_m2sPipe_payload_fragment_mask = io_bmb_cmd_s2mPipe_rData_fragment_mask;
  assign io_bmb_cmd_s2mPipe_m2sPipe_payload_fragment_context = io_bmb_cmd_s2mPipe_rData_fragment_context;
  assign io_bmb_cmd_s2mPipe_m2sPipe_ready = clockArea_dfiController_io_bmb_cmd_ready;
  assign _zz_io_bmb_rsp_ready = _zz_io_bmb_rsp_payload_last_1;
  always @(*) begin
    _zz_1 = io_bmb_rsp_ready;
    if(when_Stream_l393_1) begin
      _zz_1 = 1'b1;
    end
  end

  assign when_Stream_l393_1 = (! _zz_io_bmb_rsp_valid_1);
  assign _zz_io_bmb_rsp_valid_1 = _zz_io_bmb_rsp_valid_2;
  assign io_bmb_rsp_valid = _zz_io_bmb_rsp_valid_1;
  assign io_bmb_rsp_payload_last = _zz_io_bmb_rsp_payload_last_3;
  assign io_bmb_rsp_payload_fragment_opcode = _zz_io_bmb_rsp_payload_fragment_opcode_2;
  assign io_bmb_rsp_payload_fragment_data = _zz_io_bmb_rsp_payload_fragment_data_2;
  assign io_bmb_rsp_payload_fragment_context = _zz_io_bmb_rsp_payload_fragment_context_2;
  assign _zz_io_bmb_rsp_valid = clockArea_dfiController_io_bmb_rsp_valid;
  assign _zz_io_bmb_rsp_payload_last = clockArea_dfiController_io_bmb_rsp_payload_last;
  assign _zz_io_bmb_rsp_payload_fragment_opcode = clockArea_dfiController_io_bmb_rsp_payload_fragment_opcode;
  assign _zz_io_bmb_rsp_payload_fragment_data = clockArea_dfiController_io_bmb_rsp_payload_fragment_data;
  assign _zz_io_bmb_rsp_payload_fragment_context = clockArea_dfiController_io_bmb_rsp_payload_fragment_context;
  assign clockArea_dfiController_io_dfi_read_rd_0_rddataValid = (|ddr3_dfi_phy_0_io_dfi_read_rd_0_rddataValid);
  assign io_initDone = (&ddr3_dfi_phy_0_io_initDone);
  assign ddr3_dfi_phy_0_io_rst = (! rstN);
  assign ddr3_dfi_phy_0_io_dfi_control_cke[0] = clockArea_dfiController_io_dfi_control_cke[0];
  assign ddr3_dfi_phy_0_io_dfi_control_csN[0] = clockArea_dfiController_io_dfi_control_csN[0];
  assign io_ddr3_ckP[0] = ddr3_dfi_phy_0_io_ddr3_ckP[0];
  assign io_ddr3_ckN[0] = ddr3_dfi_phy_0_io_ddr3_ckN[0];
  assign io_ddr3_cke[0] = ddr3_dfi_phy_0_io_ddr3_cke[0];
  assign io_ddr3_resetN[0] = ddr3_dfi_phy_0_io_ddr3_resetN[0];
  assign io_ddr3_rasN[0] = ddr3_dfi_phy_0_io_ddr3_rasN[0];
  assign io_ddr3_casN[0] = ddr3_dfi_phy_0_io_ddr3_casN[0];
  assign io_ddr3_weN[0] = ddr3_dfi_phy_0_io_ddr3_weN[0];
  assign io_ddr3_csN[0] = ddr3_dfi_phy_0_io_ddr3_csN[0];
  assign io_ddr3_ba[2 : 0] = ddr3_dfi_phy_0_io_ddr3_ba;
  assign io_ddr3_addr[14 : 0] = ddr3_dfi_phy_0_io_ddr3_addr;
  assign io_ddr3_odt[0] = ddr3_dfi_phy_0_io_ddr3_odt[0];
  assign io_ddr3_dm[1 : 0] = ddr3_dfi_phy_0_io_ddr3_dm;
  always @(posedge clk_out4 or negedge rstN) begin
    if(!rstN) begin
      io_bmb_cmd_rValidN <= 1'b1;
      io_bmb_cmd_s2mPipe_rValid <= 1'b0;
      _zz_io_bmb_rsp_payload_last_1 <= 1'b1;
      _zz_io_bmb_rsp_valid_2 <= 1'b0;
    end else begin
      if(io_bmb_cmd_valid) begin
        io_bmb_cmd_rValidN <= 1'b0;
      end
      if(io_bmb_cmd_s2mPipe_ready) begin
        io_bmb_cmd_rValidN <= 1'b1;
      end
      if(io_bmb_cmd_s2mPipe_ready) begin
        io_bmb_cmd_s2mPipe_rValid <= io_bmb_cmd_s2mPipe_valid;
      end
      if(_zz_io_bmb_rsp_valid) begin
        _zz_io_bmb_rsp_payload_last_1 <= 1'b0;
      end
      if(_zz_1) begin
        _zz_io_bmb_rsp_payload_last_1 <= 1'b1;
      end
      if(_zz_1) begin
        _zz_io_bmb_rsp_valid_2 <= (_zz_io_bmb_rsp_valid || (! _zz_io_bmb_rsp_payload_last_1));
      end
    end
  end

  always @(posedge clk_out4) begin
    if(io_bmb_cmd_ready) begin
      io_bmb_cmd_rData_last <= io_bmb_cmd_payload_last;
      io_bmb_cmd_rData_fragment_opcode <= io_bmb_cmd_payload_fragment_opcode;
      io_bmb_cmd_rData_fragment_address <= io_bmb_cmd_payload_fragment_address;
      io_bmb_cmd_rData_fragment_length <= io_bmb_cmd_payload_fragment_length;
      io_bmb_cmd_rData_fragment_data <= io_bmb_cmd_payload_fragment_data;
      io_bmb_cmd_rData_fragment_mask <= io_bmb_cmd_payload_fragment_mask;
      io_bmb_cmd_rData_fragment_context <= io_bmb_cmd_payload_fragment_context;
    end
    if(io_bmb_cmd_s2mPipe_ready) begin
      io_bmb_cmd_s2mPipe_rData_last <= io_bmb_cmd_s2mPipe_payload_last;
      io_bmb_cmd_s2mPipe_rData_fragment_opcode <= io_bmb_cmd_s2mPipe_payload_fragment_opcode;
      io_bmb_cmd_s2mPipe_rData_fragment_address <= io_bmb_cmd_s2mPipe_payload_fragment_address;
      io_bmb_cmd_s2mPipe_rData_fragment_length <= io_bmb_cmd_s2mPipe_payload_fragment_length;
      io_bmb_cmd_s2mPipe_rData_fragment_data <= io_bmb_cmd_s2mPipe_payload_fragment_data;
      io_bmb_cmd_s2mPipe_rData_fragment_mask <= io_bmb_cmd_s2mPipe_payload_fragment_mask;
      io_bmb_cmd_s2mPipe_rData_fragment_context <= io_bmb_cmd_s2mPipe_payload_fragment_context;
    end
    if(_zz_io_bmb_rsp_ready) begin
      _zz_io_bmb_rsp_payload_last_2 <= _zz_io_bmb_rsp_payload_last;
      _zz_io_bmb_rsp_payload_fragment_opcode_1 <= _zz_io_bmb_rsp_payload_fragment_opcode;
      _zz_io_bmb_rsp_payload_fragment_data_1 <= _zz_io_bmb_rsp_payload_fragment_data;
      _zz_io_bmb_rsp_payload_fragment_context_1 <= _zz_io_bmb_rsp_payload_fragment_context;
    end
    if(_zz_1) begin
      _zz_io_bmb_rsp_payload_last_3 <= (_zz_io_bmb_rsp_payload_last_1 ? _zz_io_bmb_rsp_payload_last : _zz_io_bmb_rsp_payload_last_2);
      _zz_io_bmb_rsp_payload_fragment_opcode_2 <= (_zz_io_bmb_rsp_payload_last_1 ? _zz_io_bmb_rsp_payload_fragment_opcode : _zz_io_bmb_rsp_payload_fragment_opcode_1);
      _zz_io_bmb_rsp_payload_fragment_data_2 <= (_zz_io_bmb_rsp_payload_last_1 ? _zz_io_bmb_rsp_payload_fragment_data : _zz_io_bmb_rsp_payload_fragment_data_1);
      _zz_io_bmb_rsp_payload_fragment_context_2 <= (_zz_io_bmb_rsp_payload_last_1 ? _zz_io_bmb_rsp_payload_fragment_context : _zz_io_bmb_rsp_payload_fragment_context_1);
    end
  end


endmodule
