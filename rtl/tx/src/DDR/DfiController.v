// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : DfiController
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module DfiController (
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
  output wire [14:0]   io_dfi_control_address,
  output wire [2:0]    io_dfi_control_bank,
  output wire [0:0]    io_dfi_control_rasN,
  output wire [0:0]    io_dfi_control_casN,
  output wire [0:0]    io_dfi_control_weN,
  output wire [0:0]    io_dfi_control_csN,
  output wire [0:0]    io_dfi_control_cke,
  output wire          io_dfi_write_wr_0_wrdataEn,
  output wire [31:0]   io_dfi_write_wr_0_wrdata,
  output wire [3:0]    io_dfi_write_wr_0_wrdataMask,
  output wire          io_dfi_read_rden_0,
  input  wire          io_dfi_read_rd_0_rddataValid,
  input  wire [31:0]   io_dfi_read_rd_0_rddata,
  input  wire          clk_out4,
  input  wire          rstN
);

  wire                bmbBridge_1_io_bmb_cmd_ready;
  wire                bmbBridge_1_io_bmb_rsp_valid;
  wire                bmbBridge_1_io_bmb_rsp_payload_last;
  wire       [0:0]    bmbBridge_1_io_bmb_rsp_payload_fragment_opcode;
  wire       [31:0]   bmbBridge_1_io_bmb_rsp_payload_fragment_data;
  wire       [3:0]    bmbBridge_1_io_bmb_rsp_payload_fragment_context;
  wire                bmbBridge_1_io_taskPort_writeData_valid;
  wire       [31:0]   bmbBridge_1_io_taskPort_writeData_payload_data;
  wire       [3:0]    bmbBridge_1_io_taskPort_writeData_payload_mask;
  wire                bmbBridge_1_io_taskPort_rsp_ready;
  wire                bmbBridge_1_io_taskPort_tasks_read;
  wire                bmbBridge_1_io_taskPort_tasks_write;
  wire                bmbBridge_1_io_taskPort_tasks_active;
  wire                bmbBridge_1_io_taskPort_tasks_precharge;
  wire                bmbBridge_1_io_taskPort_tasks_last;
  wire       [0:0]    bmbBridge_1_io_taskPort_tasks_address_byte;
  wire       [9:0]    bmbBridge_1_io_taskPort_tasks_address_column;
  wire       [2:0]    bmbBridge_1_io_taskPort_tasks_address_bank;
  wire       [14:0]   bmbBridge_1_io_taskPort_tasks_address_row;
  wire       [17:0]   bmbBridge_1_io_taskPort_tasks_context;
  wire                bmbBridge_1_io_taskPort_tasks_prechargeAll;
  wire                bmbBridge_1_io_taskPort_tasks_refresh;
  wire                control_1_io_inport_writeData_ready;
  wire                control_1_io_inport_rsp_valid;
  wire                control_1_io_inport_rsp_payload_last;
  wire       [31:0]   control_1_io_inport_rsp_payload_fragment_data;
  wire       [17:0]   control_1_io_inport_rsp_payload_fragment_context;
  wire                control_1_io_outport_cmd_0_valid;
  wire                control_1_io_outport_cmd_0_payload_weN;
  wire                control_1_io_outport_cmd_0_payload_casN;
  wire                control_1_io_outport_cmd_0_payload_rasN;
  wire       [0:0]    control_1_io_outport_cmd_0_payload_csN;
  wire                control_1_io_outport_odt_0_valid;
  wire                control_1_io_outport_address_0_valid;
  wire       [2:0]    control_1_io_outport_address_0_payload_bank;
  wire       [14:0]   control_1_io_outport_address_0_payload_address;
  wire                control_1_io_outport_wrData_0_valid;
  wire       [31:0]   control_1_io_outport_wrData_0_payload_wrData;
  wire       [3:0]    control_1_io_outport_wrData_0_payload_wrDataMask;
  wire                control_1_io_outport_wrCs_0_valid;
  wire                control_1_io_outport_rdData_0_ready;
  wire                control_1_io_outport_rdCs_0_valid;
  wire                control_1_io_outport_clkDisable_valid;
  wire       [0:0]    control_1_io_outport_clkDisable_payload;
  wire                control_1_io_outport_lpCtrlReq_valid;
  wire       [0:0]    control_1_io_outport_cke_0;
  wire                control_1_io_outport_rdEn_0;
  wire                alignment_1_io_inIdfiport_rdData_0_valid;
  wire                alignment_1_io_inIdfiport_rdData_0_payload_last;
  wire       [31:0]   alignment_1_io_inIdfiport_rdData_0_payload_fragment_rdData;
  wire       [14:0]   alignment_1_io_outDfiport_control_address;
  wire       [2:0]    alignment_1_io_outDfiport_control_bank;
  wire       [0:0]    alignment_1_io_outDfiport_control_rasN;
  wire       [0:0]    alignment_1_io_outDfiport_control_casN;
  wire       [0:0]    alignment_1_io_outDfiport_control_weN;
  wire       [0:0]    alignment_1_io_outDfiport_control_csN;
  wire       [0:0]    alignment_1_io_outDfiport_control_cke;
  wire                alignment_1_io_outDfiport_read_rden_0;
  wire                alignment_1_io_outDfiport_write_wr_0_wrdataEn;
  wire       [31:0]   alignment_1_io_outDfiport_write_wr_0_wrdata;
  wire       [3:0]    alignment_1_io_outDfiport_write_wr_0_wrdataMask;

  BmbBridge bmbBridge_1 (
    .io_bmb_cmd_valid                         (io_bmb_cmd_valid                                      ), //i
    .io_bmb_cmd_ready                         (bmbBridge_1_io_bmb_cmd_ready                          ), //o
    .io_bmb_cmd_payload_last                  (io_bmb_cmd_payload_last                               ), //i
    .io_bmb_cmd_payload_fragment_opcode       (io_bmb_cmd_payload_fragment_opcode                    ), //i
    .io_bmb_cmd_payload_fragment_address      (io_bmb_cmd_payload_fragment_address[28:0]             ), //i
    .io_bmb_cmd_payload_fragment_length       (io_bmb_cmd_payload_fragment_length[9:0]               ), //i
    .io_bmb_cmd_payload_fragment_data         (io_bmb_cmd_payload_fragment_data[31:0]                ), //i
    .io_bmb_cmd_payload_fragment_mask         (io_bmb_cmd_payload_fragment_mask[3:0]                 ), //i
    .io_bmb_cmd_payload_fragment_context      (io_bmb_cmd_payload_fragment_context[3:0]              ), //i
    .io_bmb_rsp_valid                         (bmbBridge_1_io_bmb_rsp_valid                          ), //o
    .io_bmb_rsp_ready                         (io_bmb_rsp_ready                                      ), //i
    .io_bmb_rsp_payload_last                  (bmbBridge_1_io_bmb_rsp_payload_last                   ), //o
    .io_bmb_rsp_payload_fragment_opcode       (bmbBridge_1_io_bmb_rsp_payload_fragment_opcode        ), //o
    .io_bmb_rsp_payload_fragment_data         (bmbBridge_1_io_bmb_rsp_payload_fragment_data[31:0]    ), //o
    .io_bmb_rsp_payload_fragment_context      (bmbBridge_1_io_bmb_rsp_payload_fragment_context[3:0]  ), //o
    .io_taskPort_tasks_read                   (bmbBridge_1_io_taskPort_tasks_read                    ), //o
    .io_taskPort_tasks_write                  (bmbBridge_1_io_taskPort_tasks_write                   ), //o
    .io_taskPort_tasks_active                 (bmbBridge_1_io_taskPort_tasks_active                  ), //o
    .io_taskPort_tasks_precharge              (bmbBridge_1_io_taskPort_tasks_precharge               ), //o
    .io_taskPort_tasks_last                   (bmbBridge_1_io_taskPort_tasks_last                    ), //o
    .io_taskPort_tasks_address_byte           (bmbBridge_1_io_taskPort_tasks_address_byte            ), //o
    .io_taskPort_tasks_address_column         (bmbBridge_1_io_taskPort_tasks_address_column[9:0]     ), //o
    .io_taskPort_tasks_address_bank           (bmbBridge_1_io_taskPort_tasks_address_bank[2:0]       ), //o
    .io_taskPort_tasks_address_row            (bmbBridge_1_io_taskPort_tasks_address_row[14:0]       ), //o
    .io_taskPort_tasks_context                (bmbBridge_1_io_taskPort_tasks_context[17:0]           ), //o
    .io_taskPort_tasks_prechargeAll           (bmbBridge_1_io_taskPort_tasks_prechargeAll            ), //o
    .io_taskPort_tasks_refresh                (bmbBridge_1_io_taskPort_tasks_refresh                 ), //o
    .io_taskPort_writeData_valid              (bmbBridge_1_io_taskPort_writeData_valid               ), //o
    .io_taskPort_writeData_ready              (control_1_io_inport_writeData_ready                   ), //i
    .io_taskPort_writeData_payload_data       (bmbBridge_1_io_taskPort_writeData_payload_data[31:0]  ), //o
    .io_taskPort_writeData_payload_mask       (bmbBridge_1_io_taskPort_writeData_payload_mask[3:0]   ), //o
    .io_taskPort_rsp_valid                    (control_1_io_inport_rsp_valid                         ), //i
    .io_taskPort_rsp_ready                    (bmbBridge_1_io_taskPort_rsp_ready                     ), //o
    .io_taskPort_rsp_payload_last             (control_1_io_inport_rsp_payload_last                  ), //i
    .io_taskPort_rsp_payload_fragment_data    (control_1_io_inport_rsp_payload_fragment_data[31:0]   ), //i
    .io_taskPort_rsp_payload_fragment_context (control_1_io_inport_rsp_payload_fragment_context[17:0]), //i
    .clk_out4                                 (clk_out4                                              ), //i
    .rstN                                     (rstN                                                  )  //i
  );
  Control control_1 (
    .io_inport_tasks_read                        (bmbBridge_1_io_taskPort_tasks_read                              ), //i
    .io_inport_tasks_write                       (bmbBridge_1_io_taskPort_tasks_write                             ), //i
    .io_inport_tasks_active                      (bmbBridge_1_io_taskPort_tasks_active                            ), //i
    .io_inport_tasks_precharge                   (bmbBridge_1_io_taskPort_tasks_precharge                         ), //i
    .io_inport_tasks_last                        (bmbBridge_1_io_taskPort_tasks_last                              ), //i
    .io_inport_tasks_address_byte                (bmbBridge_1_io_taskPort_tasks_address_byte                      ), //i
    .io_inport_tasks_address_column              (bmbBridge_1_io_taskPort_tasks_address_column[9:0]               ), //i
    .io_inport_tasks_address_bank                (bmbBridge_1_io_taskPort_tasks_address_bank[2:0]                 ), //i
    .io_inport_tasks_address_row                 (bmbBridge_1_io_taskPort_tasks_address_row[14:0]                 ), //i
    .io_inport_tasks_context                     (bmbBridge_1_io_taskPort_tasks_context[17:0]                     ), //i
    .io_inport_tasks_prechargeAll                (bmbBridge_1_io_taskPort_tasks_prechargeAll                      ), //i
    .io_inport_tasks_refresh                     (bmbBridge_1_io_taskPort_tasks_refresh                           ), //i
    .io_inport_writeData_valid                   (bmbBridge_1_io_taskPort_writeData_valid                         ), //i
    .io_inport_writeData_ready                   (control_1_io_inport_writeData_ready                             ), //o
    .io_inport_writeData_payload_data            (bmbBridge_1_io_taskPort_writeData_payload_data[31:0]            ), //i
    .io_inport_writeData_payload_mask            (bmbBridge_1_io_taskPort_writeData_payload_mask[3:0]             ), //i
    .io_inport_rsp_valid                         (control_1_io_inport_rsp_valid                                   ), //o
    .io_inport_rsp_ready                         (bmbBridge_1_io_taskPort_rsp_ready                               ), //i
    .io_inport_rsp_payload_last                  (control_1_io_inport_rsp_payload_last                            ), //o
    .io_inport_rsp_payload_fragment_data         (control_1_io_inport_rsp_payload_fragment_data[31:0]             ), //o
    .io_inport_rsp_payload_fragment_context      (control_1_io_inport_rsp_payload_fragment_context[17:0]          ), //o
    .io_outport_cke_0                            (control_1_io_outport_cke_0                                      ), //o
    .io_outport_cmd_0_valid                      (control_1_io_outport_cmd_0_valid                                ), //o
    .io_outport_cmd_0_payload_weN                (control_1_io_outport_cmd_0_payload_weN                          ), //o
    .io_outport_cmd_0_payload_casN               (control_1_io_outport_cmd_0_payload_casN                         ), //o
    .io_outport_cmd_0_payload_rasN               (control_1_io_outport_cmd_0_payload_rasN                         ), //o
    .io_outport_cmd_0_payload_csN                (control_1_io_outport_cmd_0_payload_csN                          ), //o
    .io_outport_odt_0_valid                      (control_1_io_outport_odt_0_valid                                ), //o
    .io_outport_address_0_valid                  (control_1_io_outport_address_0_valid                            ), //o
    .io_outport_address_0_payload_bank           (control_1_io_outport_address_0_payload_bank[2:0]                ), //o
    .io_outport_address_0_payload_address        (control_1_io_outport_address_0_payload_address[14:0]            ), //o
    .io_outport_wrData_0_valid                   (control_1_io_outport_wrData_0_valid                             ), //o
    .io_outport_wrData_0_payload_wrData          (control_1_io_outport_wrData_0_payload_wrData[31:0]              ), //o
    .io_outport_wrData_0_payload_wrDataMask      (control_1_io_outport_wrData_0_payload_wrDataMask[3:0]           ), //o
    .io_outport_wrCs_0_valid                     (control_1_io_outport_wrCs_0_valid                               ), //o
    .io_outport_rdEn_0                           (control_1_io_outport_rdEn_0                                     ), //o
    .io_outport_rdData_0_valid                   (alignment_1_io_inIdfiport_rdData_0_valid                        ), //i
    .io_outport_rdData_0_ready                   (control_1_io_outport_rdData_0_ready                             ), //o
    .io_outport_rdData_0_payload_last            (alignment_1_io_inIdfiport_rdData_0_payload_last                 ), //i
    .io_outport_rdData_0_payload_fragment_rdData (alignment_1_io_inIdfiport_rdData_0_payload_fragment_rdData[31:0]), //i
    .io_outport_rdCs_0_valid                     (control_1_io_outport_rdCs_0_valid                               ), //o
    .io_outport_clkDisable_valid                 (control_1_io_outport_clkDisable_valid                           ), //o
    .io_outport_clkDisable_payload               (control_1_io_outport_clkDisable_payload                         ), //o
    .io_outport_lpCtrlReq_valid                  (control_1_io_outport_lpCtrlReq_valid                            ), //o
    .clk_out4                                    (clk_out4                                                        ), //i
    .rstN                                        (rstN                                                            )  //i
  );
  Alignment alignment_1 (
    .io_inIdfiport_cke_0                            (control_1_io_outport_cke_0                                      ), //i
    .io_inIdfiport_cmd_0_valid                      (control_1_io_outport_cmd_0_valid                                ), //i
    .io_inIdfiport_cmd_0_payload_weN                (control_1_io_outport_cmd_0_payload_weN                          ), //i
    .io_inIdfiport_cmd_0_payload_casN               (control_1_io_outport_cmd_0_payload_casN                         ), //i
    .io_inIdfiport_cmd_0_payload_rasN               (control_1_io_outport_cmd_0_payload_rasN                         ), //i
    .io_inIdfiport_cmd_0_payload_csN                (control_1_io_outport_cmd_0_payload_csN                          ), //i
    .io_inIdfiport_odt_0_valid                      (control_1_io_outport_odt_0_valid                                ), //i
    .io_inIdfiport_address_0_valid                  (control_1_io_outport_address_0_valid                            ), //i
    .io_inIdfiport_address_0_payload_bank           (control_1_io_outport_address_0_payload_bank[2:0]                ), //i
    .io_inIdfiport_address_0_payload_address        (control_1_io_outport_address_0_payload_address[14:0]            ), //i
    .io_inIdfiport_wrData_0_valid                   (control_1_io_outport_wrData_0_valid                             ), //i
    .io_inIdfiport_wrData_0_payload_wrData          (control_1_io_outport_wrData_0_payload_wrData[31:0]              ), //i
    .io_inIdfiport_wrData_0_payload_wrDataMask      (control_1_io_outport_wrData_0_payload_wrDataMask[3:0]           ), //i
    .io_inIdfiport_wrCs_0_valid                     (control_1_io_outport_wrCs_0_valid                               ), //i
    .io_inIdfiport_rdEn_0                           (control_1_io_outport_rdEn_0                                     ), //i
    .io_inIdfiport_rdData_0_valid                   (alignment_1_io_inIdfiport_rdData_0_valid                        ), //o
    .io_inIdfiport_rdData_0_ready                   (control_1_io_outport_rdData_0_ready                             ), //i
    .io_inIdfiport_rdData_0_payload_last            (alignment_1_io_inIdfiport_rdData_0_payload_last                 ), //o
    .io_inIdfiport_rdData_0_payload_fragment_rdData (alignment_1_io_inIdfiport_rdData_0_payload_fragment_rdData[31:0]), //o
    .io_inIdfiport_rdCs_0_valid                     (control_1_io_outport_rdCs_0_valid                               ), //i
    .io_inIdfiport_clkDisable_valid                 (control_1_io_outport_clkDisable_valid                           ), //i
    .io_inIdfiport_clkDisable_payload               (control_1_io_outport_clkDisable_payload                         ), //i
    .io_inIdfiport_lpCtrlReq_valid                  (control_1_io_outport_lpCtrlReq_valid                            ), //i
    .io_outDfiport_control_address                  (alignment_1_io_outDfiport_control_address[14:0]                 ), //o
    .io_outDfiport_control_bank                     (alignment_1_io_outDfiport_control_bank[2:0]                     ), //o
    .io_outDfiport_control_rasN                     (alignment_1_io_outDfiport_control_rasN                          ), //o
    .io_outDfiport_control_casN                     (alignment_1_io_outDfiport_control_casN                          ), //o
    .io_outDfiport_control_weN                      (alignment_1_io_outDfiport_control_weN                           ), //o
    .io_outDfiport_control_csN                      (alignment_1_io_outDfiport_control_csN                           ), //o
    .io_outDfiport_control_cke                      (alignment_1_io_outDfiport_control_cke                           ), //o
    .io_outDfiport_write_wr_0_wrdataEn              (alignment_1_io_outDfiport_write_wr_0_wrdataEn                   ), //o
    .io_outDfiport_write_wr_0_wrdata                (alignment_1_io_outDfiport_write_wr_0_wrdata[31:0]               ), //o
    .io_outDfiport_write_wr_0_wrdataMask            (alignment_1_io_outDfiport_write_wr_0_wrdataMask[3:0]            ), //o
    .io_outDfiport_read_rden_0                      (alignment_1_io_outDfiport_read_rden_0                           ), //o
    .io_outDfiport_read_rd_0_rddataValid            (io_dfi_read_rd_0_rddataValid                                    ), //i
    .io_outDfiport_read_rd_0_rddata                 (io_dfi_read_rd_0_rddata[31:0]                                   ), //i
    .clk_out4                                       (clk_out4                                                        ), //i
    .rstN                                           (rstN                                                            )  //i
  );
  assign io_bmb_cmd_ready = bmbBridge_1_io_bmb_cmd_ready;
  assign io_bmb_rsp_valid = bmbBridge_1_io_bmb_rsp_valid;
  assign io_bmb_rsp_payload_last = bmbBridge_1_io_bmb_rsp_payload_last;
  assign io_bmb_rsp_payload_fragment_opcode = bmbBridge_1_io_bmb_rsp_payload_fragment_opcode;
  assign io_bmb_rsp_payload_fragment_data = bmbBridge_1_io_bmb_rsp_payload_fragment_data;
  assign io_bmb_rsp_payload_fragment_context = bmbBridge_1_io_bmb_rsp_payload_fragment_context;
  assign io_dfi_control_address = alignment_1_io_outDfiport_control_address;
  assign io_dfi_control_bank = alignment_1_io_outDfiport_control_bank;
  assign io_dfi_control_rasN = alignment_1_io_outDfiport_control_rasN;
  assign io_dfi_control_casN = alignment_1_io_outDfiport_control_casN;
  assign io_dfi_control_weN = alignment_1_io_outDfiport_control_weN;
  assign io_dfi_control_csN = alignment_1_io_outDfiport_control_csN;
  assign io_dfi_control_cke = alignment_1_io_outDfiport_control_cke;
  assign io_dfi_write_wr_0_wrdataEn = alignment_1_io_outDfiport_write_wr_0_wrdataEn;
  assign io_dfi_write_wr_0_wrdata = alignment_1_io_outDfiport_write_wr_0_wrdata;
  assign io_dfi_write_wr_0_wrdataMask = alignment_1_io_outDfiport_write_wr_0_wrdataMask;
  assign io_dfi_read_rden_0 = alignment_1_io_outDfiport_read_rden_0;

endmodule
