// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : Alignment
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module Alignment (
  input  wire [0:0]    io_inIdfiport_cke_0,
  input  wire          io_inIdfiport_cmd_0_valid,
  input  wire          io_inIdfiport_cmd_0_payload_weN,
  input  wire          io_inIdfiport_cmd_0_payload_casN,
  input  wire          io_inIdfiport_cmd_0_payload_rasN,
  input  wire [0:0]    io_inIdfiport_cmd_0_payload_csN,
  input  wire          io_inIdfiport_odt_0_valid,
  input  wire          io_inIdfiport_address_0_valid,
  input  wire [2:0]    io_inIdfiport_address_0_payload_bank,
  input  wire [14:0]   io_inIdfiport_address_0_payload_address,
  input  wire          io_inIdfiport_wrData_0_valid,
  input  wire [31:0]   io_inIdfiport_wrData_0_payload_wrData,
  input  wire [3:0]    io_inIdfiport_wrData_0_payload_wrDataMask,
  input  wire          io_inIdfiport_wrCs_0_valid,
  input  wire          io_inIdfiport_rdEn_0,
  output wire          io_inIdfiport_rdData_0_valid,
  input  wire          io_inIdfiport_rdData_0_ready,
  output wire          io_inIdfiport_rdData_0_payload_last,
  output wire [31:0]   io_inIdfiport_rdData_0_payload_fragment_rdData,
  input  wire          io_inIdfiport_rdCs_0_valid,
  input  wire          io_inIdfiport_clkDisable_valid,
  input  wire [0:0]    io_inIdfiport_clkDisable_payload,
  input  wire          io_inIdfiport_lpCtrlReq_valid,
  output wire [14:0]   io_outDfiport_control_address,
  output wire [2:0]    io_outDfiport_control_bank,
  output wire [0:0]    io_outDfiport_control_rasN,
  output wire [0:0]    io_outDfiport_control_casN,
  output wire [0:0]    io_outDfiport_control_weN,
  output wire [0:0]    io_outDfiport_control_csN,
  output wire [0:0]    io_outDfiport_control_cke,
  output wire          io_outDfiport_write_wr_0_wrdataEn,
  output wire [31:0]   io_outDfiport_write_wr_0_wrdata,
  output wire [3:0]    io_outDfiport_write_wr_0_wrdataMask,
  output wire          io_outDfiport_read_rden_0,
  input  wire          io_outDfiport_read_rd_0_rddataValid,
  input  wire [31:0]   io_outDfiport_read_rd_0_rddata,
  input  wire          clk_out4,
  input  wire          rstN
);

  wire       [0:0]    caAlignment_1_io_cke_0;
  wire       [14:0]   caAlignment_1_io_output_address;
  wire       [2:0]    caAlignment_1_io_output_bank;
  wire       [0:0]    caAlignment_1_io_output_rasN;
  wire       [0:0]    caAlignment_1_io_output_casN;
  wire       [0:0]    caAlignment_1_io_output_weN;
  wire       [0:0]    caAlignment_1_io_output_csN;
  wire       [0:0]    caAlignment_1_io_output_cke;
  wire                wrAlignment_1_io_dfiWr_wr_0_wrdataEn;
  wire       [31:0]   wrAlignment_1_io_dfiWr_wr_0_wrdata;
  wire       [3:0]    wrAlignment_1_io_dfiWr_wr_0_wrdataMask;
  wire                rdAlignment_1_io_idfiRd_0_valid;
  wire                rdAlignment_1_io_idfiRd_0_payload_last;
  wire       [31:0]   rdAlignment_1_io_idfiRd_0_payload_fragment_rdData;
  wire       [0:0]    _zz_io_cke_0;

  assign _zz_io_cke_0 = 1'b1;
  CAAlignment caAlignment_1 (
    .io_cmd_0_valid               (io_inIdfiport_cmd_0_valid                    ), //i
    .io_cmd_0_payload_weN         (io_inIdfiport_cmd_0_payload_weN              ), //i
    .io_cmd_0_payload_casN        (io_inIdfiport_cmd_0_payload_casN             ), //i
    .io_cmd_0_payload_rasN        (io_inIdfiport_cmd_0_payload_rasN             ), //i
    .io_cmd_0_payload_csN         (io_inIdfiport_cmd_0_payload_csN              ), //i
    .io_address_0_valid           (io_inIdfiport_address_0_valid                ), //i
    .io_address_0_payload_bank    (io_inIdfiport_address_0_payload_bank[2:0]    ), //i
    .io_address_0_payload_address (io_inIdfiport_address_0_payload_address[14:0]), //i
    .io_cke_0                     (caAlignment_1_io_cke_0                       ), //i
    .io_output_address            (caAlignment_1_io_output_address[14:0]        ), //o
    .io_output_bank               (caAlignment_1_io_output_bank[2:0]            ), //o
    .io_output_rasN               (caAlignment_1_io_output_rasN                 ), //o
    .io_output_casN               (caAlignment_1_io_output_casN                 ), //o
    .io_output_weN                (caAlignment_1_io_output_weN                  ), //o
    .io_output_csN                (caAlignment_1_io_output_csN                  ), //o
    .io_output_cke                (caAlignment_1_io_output_cke                  )  //o
  );
  WrAlignment wrAlignment_1 (
    .io_idfiWrData_0_valid              (io_inIdfiport_wrData_0_valid                  ), //i
    .io_idfiWrData_0_payload_wrData     (io_inIdfiport_wrData_0_payload_wrData[31:0]   ), //i
    .io_idfiWrData_0_payload_wrDataMask (io_inIdfiport_wrData_0_payload_wrDataMask[3:0]), //i
    .io_dfiWr_wr_0_wrdataEn             (wrAlignment_1_io_dfiWr_wr_0_wrdataEn          ), //o
    .io_dfiWr_wr_0_wrdata               (wrAlignment_1_io_dfiWr_wr_0_wrdata[31:0]      ), //o
    .io_dfiWr_wr_0_wrdataMask           (wrAlignment_1_io_dfiWr_wr_0_wrdataMask[3:0]   ), //o
    .clk_out4                           (clk_out4                                      ), //i
    .rstN                               (rstN                                          )  //i
  );
  RdAlignment rdAlignment_1 (
    .io_phaseClear                       (1'b0                                                   ), //i
    .io_dfiRd_0_rddataValid              (io_outDfiport_read_rd_0_rddataValid                    ), //i
    .io_dfiRd_0_rddata                   (io_outDfiport_read_rd_0_rddata[31:0]                   ), //i
    .io_idfiRd_0_valid                   (rdAlignment_1_io_idfiRd_0_valid                        ), //o
    .io_idfiRd_0_ready                   (io_inIdfiport_rdData_0_ready                           ), //i
    .io_idfiRd_0_payload_last            (rdAlignment_1_io_idfiRd_0_payload_last                 ), //o
    .io_idfiRd_0_payload_fragment_rdData (rdAlignment_1_io_idfiRd_0_payload_fragment_rdData[31:0]), //o
    .clk_out4                            (clk_out4                                               ), //i
    .rstN                                (rstN                                                   )  //i
  );
  assign caAlignment_1_io_cke_0 = _zz_io_cke_0[0 : 0];
  assign io_outDfiport_control_address = caAlignment_1_io_output_address;
  assign io_outDfiport_control_bank = caAlignment_1_io_output_bank;
  assign io_outDfiport_control_rasN = caAlignment_1_io_output_rasN;
  assign io_outDfiport_control_casN = caAlignment_1_io_output_casN;
  assign io_outDfiport_control_weN = caAlignment_1_io_output_weN;
  assign io_outDfiport_control_csN = caAlignment_1_io_output_csN;
  assign io_outDfiport_control_cke = caAlignment_1_io_output_cke;
  assign io_outDfiport_write_wr_0_wrdataEn = wrAlignment_1_io_dfiWr_wr_0_wrdataEn;
  assign io_outDfiport_write_wr_0_wrdata = wrAlignment_1_io_dfiWr_wr_0_wrdata;
  assign io_outDfiport_write_wr_0_wrdataMask = wrAlignment_1_io_dfiWr_wr_0_wrdataMask;
  assign io_inIdfiport_rdData_0_valid = rdAlignment_1_io_idfiRd_0_valid;
  assign io_inIdfiport_rdData_0_payload_last = rdAlignment_1_io_idfiRd_0_payload_last;
  assign io_inIdfiport_rdData_0_payload_fragment_rdData = rdAlignment_1_io_idfiRd_0_payload_fragment_rdData;
  assign io_outDfiport_read_rden_0 = io_inIdfiport_rdEn_0;

endmodule
