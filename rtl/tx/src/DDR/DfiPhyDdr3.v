// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : DfiPhyDdr3
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module DfiPhyDdr3 (
  input  wire          io_clk_work,
  input  wire          io_clk_ddr,
  input  wire          io_clk_ddr90,
  input  wire          io_clk_ref,
  input  wire          io_rst,
  output wire          io_initDone,
  input  wire [14:0]   io_dfi_control_address,
  input  wire [2:0]    io_dfi_control_bank,
  input  wire [0:0]    io_dfi_control_rasN,
  input  wire [0:0]    io_dfi_control_casN,
  input  wire [0:0]    io_dfi_control_weN,
  input  wire [0:0]    io_dfi_control_csN,
  input  wire [0:0]    io_dfi_control_cke,
  input  wire [0:0]    io_dfi_control_odt,
  input  wire [0:0]    io_dfi_control_resetN,
  input  wire          io_dfi_write_wr_0_wrdataEn,
  input  wire [31:0]   io_dfi_write_wr_0_wrdata,
  input  wire [3:0]    io_dfi_write_wr_0_wrdataMask,
  input  wire          io_dfi_read_rden_0,
  output wire          io_dfi_read_rd_0_rddataValid,
  output wire [31:0]   io_dfi_read_rd_0_rddata,
  output wire [3:0]    io_dfi_read_rd_0_rddataDnv,
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
  input  wire          clk_out4,
  input  wire          rstN
);

  wire       [14:0]   ddr3Phy_dfi_address_i;
  wire       [2:0]    ddr3Phy_dfi_bank_i;
  wire       [0:0]    ddr3Phy_dfi_ras_n_i;
  wire       [0:0]    ddr3Phy_dfi_cas_n_i;
  wire       [0:0]    ddr3Phy_dfi_we_n_i;
  wire       [0:0]    ddr3Phy_dfi_cs_n_i;
  wire       [0:0]    ddr3Phy_dfi_cke_i;
  wire       [0:0]    ddr3Phy_dfi_odt_i;
  wire       [0:0]    ddr3Phy_dfi_reset_n_i;
  wire                ddr3Phy_dfi_wrdata_en_i;
  wire       [31:0]   ddr3Phy_dfi_wrdata_i;
  wire       [3:0]    ddr3Phy_dfi_wrdata_mask_i;
  wire                ddr3Phy_dfi_rddata_en_i;
  wire       [14:0]   init_io_control_address;
  wire       [2:0]    init_io_control_bank;
  wire       [0:0]    init_io_control_rasN;
  wire       [0:0]    init_io_control_casN;
  wire       [0:0]    init_io_control_weN;
  wire       [0:0]    init_io_control_csN;
  wire       [0:0]    init_io_control_cke;
  wire       [0:0]    init_io_control_odt;
  wire       [0:0]    init_io_control_resetN;
  wire                init_io_initDone;
  wire                ddr3Phy_dfi_rddata_valid_o;
  wire       [31:0]   ddr3Phy_dfi_rddata_o;
  wire       [3:0]    ddr3Phy_dfi_rddata_dnv_o;
  wire       [0:0]    ddr3Phy_ddr3_ck_p_o;
  wire       [0:0]    ddr3Phy_ddr3_ck_n_o;
  wire       [0:0]    ddr3Phy_ddr3_cke_o;
  wire       [0:0]    ddr3Phy_ddr3_reset_n_o;
  wire       [0:0]    ddr3Phy_ddr3_ras_n_o;
  wire       [0:0]    ddr3Phy_ddr3_cas_n_o;
  wire       [0:0]    ddr3Phy_ddr3_we_n_o;
  wire       [0:0]    ddr3Phy_ddr3_cs_n_o;
  wire       [2:0]    ddr3Phy_ddr3_ba_o;
  wire       [14:0]   ddr3Phy_ddr3_addr_o;
  wire       [0:0]    ddr3Phy_ddr3_odt_o;
  wire       [1:0]    ddr3Phy_ddr3_dm_o;
  wire       [36:0]   _zz__zz_initDfi_write_wr_0_wrdataEn;
  wire       [0:0]    _zz_initDfi_read_rden_0;
  reg        [14:0]   initCtrlReg_address;
  reg        [2:0]    initCtrlReg_bank;
  reg        [0:0]    initCtrlReg_rasN;
  reg        [0:0]    initCtrlReg_casN;
  reg        [0:0]    initCtrlReg_weN;
  reg        [0:0]    initCtrlReg_csN;
  reg        [0:0]    initCtrlReg_cke;
  reg        [0:0]    initCtrlReg_odt;
  reg        [0:0]    initCtrlReg_resetN;
  wire       [14:0]   initDfi_control_address;
  wire       [2:0]    initDfi_control_bank;
  wire       [0:0]    initDfi_control_rasN;
  wire       [0:0]    initDfi_control_casN;
  wire       [0:0]    initDfi_control_weN;
  wire       [0:0]    initDfi_control_csN;
  wire       [0:0]    initDfi_control_cke;
  wire       [0:0]    initDfi_control_odt;
  wire       [0:0]    initDfi_control_resetN;
  wire                initDfi_write_wr_0_wrdataEn;
  wire       [31:0]   initDfi_write_wr_0_wrdata;
  wire       [3:0]    initDfi_write_wr_0_wrdataMask;
  wire                initDfi_read_rden_0;
  wire                initDfi_read_rd_0_rddataValid;
  wire       [31:0]   initDfi_read_rd_0_rddata;
  wire       [3:0]    initDfi_read_rd_0_rddataDnv;
  wire       [36:0]   _zz_initDfi_write_wr_0_wrdataEn;

  assign _zz__zz_initDfi_write_wr_0_wrdataEn = 37'h0;
  assign _zz_initDfi_read_rden_0 = 1'b0;
  Initialize init (
    .io_control_address (init_io_control_address[14:0]), //o
    .io_control_bank    (init_io_control_bank[2:0]    ), //o
    .io_control_rasN    (init_io_control_rasN         ), //o
    .io_control_casN    (init_io_control_casN         ), //o
    .io_control_weN     (init_io_control_weN          ), //o
    .io_control_csN     (init_io_control_csN          ), //o
    .io_control_cke     (init_io_control_cke          ), //o
    .io_control_odt     (init_io_control_odt          ), //o
    .io_control_resetN  (init_io_control_resetN       ), //o
    .io_initDone        (init_io_initDone             ), //o
    .clk_out4           (clk_out4                     ), //i
    .rstN               (rstN                         )  //i
  );
  ddr3_dfi_phy #(
    .REFCLK_FREQUENCY   (200),
    .DQS_TAP_DELAY_INIT (27 ),
    .DQ_TAP_DELAY_INIT  (0  ),
    .TPHY_RDLAT         (5  ),
    .TPHY_WRLAT         (5  )
  ) ddr3Phy (
    .clk_i              (io_clk_work                   ), //i
    .clk_ddr_i          (io_clk_ddr                    ), //i
    .clk_ddr90_i        (io_clk_ddr90                  ), //i
    .clk_ref_i          (io_clk_ref                    ), //i
    .rst_i              (io_rst                        ), //i
    .cfg_valid_i        (1'b0                          ), //i
    .cfg_i              (32'h0                         ), //i
    .dfi_address_i      (ddr3Phy_dfi_address_i[14:0]   ), //i
    .dfi_bank_i         (ddr3Phy_dfi_bank_i[2:0]       ), //i
    .dfi_ras_n_i        (ddr3Phy_dfi_ras_n_i           ), //i
    .dfi_cas_n_i        (ddr3Phy_dfi_cas_n_i           ), //i
    .dfi_we_n_i         (ddr3Phy_dfi_we_n_i            ), //i
    .dfi_cs_n_i         (ddr3Phy_dfi_cs_n_i            ), //i
    .dfi_cke_i          (ddr3Phy_dfi_cke_i             ), //i
    .dfi_odt_i          (ddr3Phy_dfi_odt_i             ), //i
    .dfi_reset_n_i      (ddr3Phy_dfi_reset_n_i         ), //i
    .dfi_wrdata_en_i    (ddr3Phy_dfi_wrdata_en_i       ), //i
    .dfi_wrdata_i       (ddr3Phy_dfi_wrdata_i[31:0]    ), //i
    .dfi_wrdata_mask_i  (ddr3Phy_dfi_wrdata_mask_i[3:0]), //i
    .dfi_rddata_en_i    (ddr3Phy_dfi_rddata_en_i       ), //i
    .dfi_rddata_valid_o (ddr3Phy_dfi_rddata_valid_o    ), //o
    .dfi_rddata_o       (ddr3Phy_dfi_rddata_o[31:0]    ), //o
    .dfi_rddata_dnv_o   (ddr3Phy_dfi_rddata_dnv_o[3:0] ), //o
    .ddr3_ck_p_o        (ddr3Phy_ddr3_ck_p_o           ), //o
    .ddr3_ck_n_o        (ddr3Phy_ddr3_ck_n_o           ), //o
    .ddr3_cke_o         (ddr3Phy_ddr3_cke_o            ), //o
    .ddr3_reset_n_o     (ddr3Phy_ddr3_reset_n_o        ), //o
    .ddr3_ras_n_o       (ddr3Phy_ddr3_ras_n_o          ), //o
    .ddr3_cas_n_o       (ddr3Phy_ddr3_cas_n_o          ), //o
    .ddr3_we_n_o        (ddr3Phy_ddr3_we_n_o           ), //o
    .ddr3_cs_n_o        (ddr3Phy_ddr3_cs_n_o           ), //o
    .ddr3_ba_o          (ddr3Phy_ddr3_ba_o[2:0]        ), //o
    .ddr3_addr_o        (ddr3Phy_ddr3_addr_o[14:0]     ), //o
    .ddr3_odt_o         (ddr3Phy_ddr3_odt_o            ), //o
    .ddr3_dm_o          (ddr3Phy_ddr3_dm_o[1:0]        ), //o
    .ddr3_dqs_p_io      (io_ddr3_dqsP                  ), //~
    .ddr3_dqs_n_io      (io_ddr3_dqsN                  ), //~
    .ddr3_dq_io         (io_ddr3_dq                    )  //~
  );
  assign io_initDone = init_io_initDone;
  assign initDfi_control_address = initCtrlReg_address;
  assign initDfi_control_bank = initCtrlReg_bank;
  assign initDfi_control_rasN = initCtrlReg_rasN;
  assign initDfi_control_casN = initCtrlReg_casN;
  assign initDfi_control_weN = initCtrlReg_weN;
  assign initDfi_control_csN = initCtrlReg_csN;
  assign initDfi_control_cke = initCtrlReg_cke;
  assign initDfi_control_odt = initCtrlReg_odt;
  assign initDfi_control_resetN = initCtrlReg_resetN;
  assign _zz_initDfi_write_wr_0_wrdataEn = _zz__zz_initDfi_write_wr_0_wrdataEn[36 : 0];
  assign initDfi_write_wr_0_wrdataEn = _zz_initDfi_write_wr_0_wrdataEn[0];
  assign initDfi_write_wr_0_wrdata = _zz_initDfi_write_wr_0_wrdataEn[32 : 1];
  assign initDfi_write_wr_0_wrdataMask = _zz_initDfi_write_wr_0_wrdataEn[36 : 33];
  assign initDfi_read_rden_0 = _zz_initDfi_read_rden_0[0];
  assign io_ddr3_ckP = ddr3Phy_ddr3_ck_p_o;
  assign io_ddr3_ckN = ddr3Phy_ddr3_ck_n_o;
  assign io_ddr3_cke = ddr3Phy_ddr3_cke_o;
  assign io_ddr3_resetN = ddr3Phy_ddr3_reset_n_o;
  assign io_ddr3_rasN = ddr3Phy_ddr3_ras_n_o;
  assign io_ddr3_casN = ddr3Phy_ddr3_cas_n_o;
  assign io_ddr3_weN = ddr3Phy_ddr3_we_n_o;
  assign io_ddr3_csN = ddr3Phy_ddr3_cs_n_o;
  assign io_ddr3_ba = ddr3Phy_ddr3_ba_o;
  assign io_ddr3_addr = ddr3Phy_ddr3_addr_o;
  assign io_ddr3_odt = ddr3Phy_ddr3_odt_o;
  assign io_ddr3_dm = ddr3Phy_ddr3_dm_o;
  assign ddr3Phy_dfi_address_i = (init_io_initDone ? io_dfi_control_address : initDfi_control_address);
  assign ddr3Phy_dfi_bank_i = (init_io_initDone ? io_dfi_control_bank : initDfi_control_bank);
  assign ddr3Phy_dfi_ras_n_i = (init_io_initDone ? io_dfi_control_rasN : initDfi_control_rasN);
  assign ddr3Phy_dfi_cas_n_i = (init_io_initDone ? io_dfi_control_casN : initDfi_control_casN);
  assign ddr3Phy_dfi_we_n_i = (init_io_initDone ? io_dfi_control_weN : initDfi_control_weN);
  assign ddr3Phy_dfi_cs_n_i = (init_io_initDone ? io_dfi_control_csN : initDfi_control_csN);
  assign ddr3Phy_dfi_cke_i = (init_io_initDone ? io_dfi_control_cke : initDfi_control_cke);
  assign ddr3Phy_dfi_odt_i = (init_io_initDone ? io_dfi_control_odt : initDfi_control_odt);
  assign ddr3Phy_dfi_reset_n_i = (init_io_initDone ? io_dfi_control_resetN : initDfi_control_resetN);
  assign ddr3Phy_dfi_wrdata_en_i = (init_io_initDone ? io_dfi_write_wr_0_wrdataEn : initDfi_write_wr_0_wrdataEn);
  assign ddr3Phy_dfi_wrdata_i = (init_io_initDone ? io_dfi_write_wr_0_wrdata : initDfi_write_wr_0_wrdata);
  assign ddr3Phy_dfi_wrdata_mask_i = (init_io_initDone ? io_dfi_write_wr_0_wrdataMask : initDfi_write_wr_0_wrdataMask);
  assign ddr3Phy_dfi_rddata_en_i = (init_io_initDone ? io_dfi_read_rden_0 : initDfi_read_rden_0);
  assign io_dfi_read_rd_0_rddataValid = ddr3Phy_dfi_rddata_valid_o;
  assign io_dfi_read_rd_0_rddata = ddr3Phy_dfi_rddata_o;
  assign io_dfi_read_rd_0_rddataDnv = ddr3Phy_dfi_rddata_dnv_o;
  always @(posedge clk_out4) begin
    initCtrlReg_address <= init_io_control_address;
    initCtrlReg_bank <= init_io_control_bank;
    initCtrlReg_rasN <= init_io_control_rasN;
    initCtrlReg_casN <= init_io_control_casN;
    initCtrlReg_weN <= init_io_control_weN;
    initCtrlReg_csN <= init_io_control_csN;
    initCtrlReg_cke <= init_io_control_cke;
    initCtrlReg_odt <= init_io_control_odt;
    initCtrlReg_resetN <= init_io_control_resetN;
  end


endmodule
