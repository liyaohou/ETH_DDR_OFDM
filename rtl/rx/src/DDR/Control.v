// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : Control
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module Control (
  input  wire          io_inport_tasks_read,
  input  wire          io_inport_tasks_write,
  input  wire          io_inport_tasks_active,
  input  wire          io_inport_tasks_precharge,
  input  wire          io_inport_tasks_last,
  input  wire [0:0]    io_inport_tasks_address_byte,
  input  wire [9:0]    io_inport_tasks_address_column,
  input  wire [2:0]    io_inport_tasks_address_bank,
  input  wire [14:0]   io_inport_tasks_address_row,
  input  wire [17:0]   io_inport_tasks_context,
  input  wire          io_inport_tasks_prechargeAll,
  input  wire          io_inport_tasks_refresh,
  input  wire          io_inport_writeData_valid,
  output wire          io_inport_writeData_ready,
  input  wire [31:0]   io_inport_writeData_payload_data,
  input  wire [3:0]    io_inport_writeData_payload_mask,
  output wire          io_inport_rsp_valid,
  input  wire          io_inport_rsp_ready,
  output wire          io_inport_rsp_payload_last,
  output wire [31:0]   io_inport_rsp_payload_fragment_data,
  output wire [17:0]   io_inport_rsp_payload_fragment_context,
  output wire [0:0]    io_outport_cke_0,
  output wire          io_outport_cmd_0_valid,
  output wire          io_outport_cmd_0_payload_weN,
  output wire          io_outport_cmd_0_payload_casN,
  output wire          io_outport_cmd_0_payload_rasN,
  output wire [0:0]    io_outport_cmd_0_payload_csN,
  output wire          io_outport_odt_0_valid,
  output wire          io_outport_address_0_valid,
  output wire [2:0]    io_outport_address_0_payload_bank,
  output wire [14:0]   io_outport_address_0_payload_address,
  output wire          io_outport_wrData_0_valid,
  output wire [31:0]   io_outport_wrData_0_payload_wrData,
  output wire [3:0]    io_outport_wrData_0_payload_wrDataMask,
  output wire          io_outport_wrCs_0_valid,
  output wire          io_outport_rdEn_0,
  input  wire          io_outport_rdData_0_valid,
  output wire          io_outport_rdData_0_ready,
  input  wire          io_outport_rdData_0_payload_last,
  input  wire [31:0]   io_outport_rdData_0_payload_fragment_rdData,
  output wire          io_outport_rdCs_0_valid,
  output wire          io_outport_clkDisable_valid,
  output wire [0:0]    io_outport_clkDisable_payload,
  output wire          io_outport_lpCtrlReq_valid,
  input  wire          clk_out4,
  input  wire          rstN
);

  wire                cmd_cmdtxd_io_cmd_0_valid;
  wire                cmd_cmdtxd_io_cmd_0_payload_weN;
  wire                cmd_cmdtxd_io_cmd_0_payload_casN;
  wire                cmd_cmdtxd_io_cmd_0_payload_rasN;
  wire       [0:0]    cmd_cmdtxd_io_cmd_0_payload_csN;
  wire                cmd_cmdtxd_io_address_0_valid;
  wire       [2:0]    cmd_cmdtxd_io_address_0_payload_bank;
  wire       [14:0]   cmd_cmdtxd_io_address_0_payload_address;
  wire                wrdata_wrdatatxd_io_taskWrData_ready;
  wire                wrdata_wrdatatxd_io_idfiWrData_0_valid;
  wire       [31:0]   wrdata_wrdatatxd_io_idfiWrData_0_payload_wrData;
  wire       [3:0]    wrdata_wrdatatxd_io_idfiWrData_0_payload_wrDataMask;
  wire                radata_rddatarxd_io_idfiRdData_0_ready;
  wire                radata_rddatarxd_io_rden_0;
  wire                radata_rddatarxd_io_taskRdData_valid;
  wire                radata_rddatarxd_io_taskRdData_payload_last;
  wire       [31:0]   radata_rddatarxd_io_taskRdData_payload_fragment_data;
  wire       [17:0]   radata_rddatarxd_io_taskRdData_payload_fragment_context;
  reg                 io_inport_tasks_init_read;
  reg                 io_inport_tasks_init_write;
  reg                 io_inport_tasks_init_active;
  reg                 io_inport_tasks_init_precharge;
  reg                 io_inport_tasks_init_last;
  reg        [0:0]    io_inport_tasks_init_address_byte;
  reg        [9:0]    io_inport_tasks_init_address_column;
  reg        [2:0]    io_inport_tasks_init_address_bank;
  reg        [14:0]   io_inport_tasks_init_address_row;
  reg        [17:0]   io_inport_tasks_init_context;
  reg                 io_inport_tasks_init_prechargeAll;
  reg                 io_inport_tasks_init_refresh;
  reg                 io_inport_tasks_write_regNext;
  reg                 io_inport_tasks_init_read_1;
  reg                 io_inport_tasks_init_write_1;
  reg                 io_inport_tasks_init_active_1;
  reg                 io_inport_tasks_init_precharge_1;
  reg                 io_inport_tasks_init_last_1;
  reg        [0:0]    io_inport_tasks_init_address_byte_1;
  reg        [9:0]    io_inport_tasks_init_address_column_1;
  reg        [2:0]    io_inport_tasks_init_address_bank_1;
  reg        [14:0]   io_inport_tasks_init_address_row_1;
  reg        [17:0]   io_inport_tasks_init_context_1;
  reg                 io_inport_tasks_init_prechargeAll_1;
  reg                 io_inport_tasks_init_refresh_1;
  wire                radata_rddatarxd_io_taskRdData_toStream_valid;
  wire                radata_rddatarxd_io_taskRdData_toStream_ready;
  wire                radata_rddatarxd_io_taskRdData_toStream_payload_last;
  wire       [31:0]   radata_rddatarxd_io_taskRdData_toStream_payload_fragment_data;
  wire       [17:0]   radata_rddatarxd_io_taskRdData_toStream_payload_fragment_context;

  CmdTxd cmd_cmdtxd (
    .io_task_read                 (io_inport_tasks_init_read                    ), //i
    .io_task_write                (io_inport_tasks_init_write                   ), //i
    .io_task_active               (io_inport_tasks_init_active                  ), //i
    .io_task_precharge            (io_inport_tasks_init_precharge               ), //i
    .io_task_last                 (io_inport_tasks_init_last                    ), //i
    .io_task_address_byte         (io_inport_tasks_init_address_byte            ), //i
    .io_task_address_column       (io_inport_tasks_init_address_column[9:0]     ), //i
    .io_task_address_bank         (io_inport_tasks_init_address_bank[2:0]       ), //i
    .io_task_address_row          (io_inport_tasks_init_address_row[14:0]       ), //i
    .io_task_context              (io_inport_tasks_init_context[17:0]           ), //i
    .io_task_prechargeAll         (io_inport_tasks_init_prechargeAll            ), //i
    .io_task_refresh              (io_inport_tasks_init_refresh                 ), //i
    .io_cmd_0_valid               (cmd_cmdtxd_io_cmd_0_valid                    ), //o
    .io_cmd_0_payload_weN         (cmd_cmdtxd_io_cmd_0_payload_weN              ), //o
    .io_cmd_0_payload_casN        (cmd_cmdtxd_io_cmd_0_payload_casN             ), //o
    .io_cmd_0_payload_rasN        (cmd_cmdtxd_io_cmd_0_payload_rasN             ), //o
    .io_cmd_0_payload_csN         (cmd_cmdtxd_io_cmd_0_payload_csN              ), //o
    .io_address_0_valid           (cmd_cmdtxd_io_address_0_valid                ), //o
    .io_address_0_payload_bank    (cmd_cmdtxd_io_address_0_payload_bank[2:0]    ), //o
    .io_address_0_payload_address (cmd_cmdtxd_io_address_0_payload_address[14:0])  //o
  );
  WrDataTxd wrdata_wrdatatxd (
    .io_write                           (io_inport_tasks_write_regNext                           ), //i
    .io_taskWrData_valid                (io_inport_writeData_valid                               ), //i
    .io_taskWrData_ready                (wrdata_wrdatatxd_io_taskWrData_ready                    ), //o
    .io_taskWrData_payload_data         (io_inport_writeData_payload_data[31:0]                  ), //i
    .io_taskWrData_payload_mask         (io_inport_writeData_payload_mask[3:0]                   ), //i
    .io_idfiWrData_0_valid              (wrdata_wrdatatxd_io_idfiWrData_0_valid                  ), //o
    .io_idfiWrData_0_payload_wrData     (wrdata_wrdatatxd_io_idfiWrData_0_payload_wrData[31:0]   ), //o
    .io_idfiWrData_0_payload_wrDataMask (wrdata_wrdatatxd_io_idfiWrData_0_payload_wrDataMask[3:0]), //o
    .clk_out4                           (clk_out4                                                ), //i
    .rstN                               (rstN                                                    )  //i
  );
  RdDataRxd radata_rddatarxd (
    .io_task_read                            (io_inport_tasks_init_read_1                                  ), //i
    .io_task_write                           (io_inport_tasks_init_write_1                                 ), //i
    .io_task_active                          (io_inport_tasks_init_active_1                                ), //i
    .io_task_precharge                       (io_inport_tasks_init_precharge_1                             ), //i
    .io_task_last                            (io_inport_tasks_init_last_1                                  ), //i
    .io_task_address_byte                    (io_inport_tasks_init_address_byte_1                          ), //i
    .io_task_address_column                  (io_inport_tasks_init_address_column_1[9:0]                   ), //i
    .io_task_address_bank                    (io_inport_tasks_init_address_bank_1[2:0]                     ), //i
    .io_task_address_row                     (io_inport_tasks_init_address_row_1[14:0]                     ), //i
    .io_task_context                         (io_inport_tasks_init_context_1[17:0]                         ), //i
    .io_task_prechargeAll                    (io_inport_tasks_init_prechargeAll_1                          ), //i
    .io_task_refresh                         (io_inport_tasks_init_refresh_1                               ), //i
    .io_idfiRdData_0_valid                   (io_outport_rdData_0_valid                                    ), //i
    .io_idfiRdData_0_ready                   (radata_rddatarxd_io_idfiRdData_0_ready                       ), //o
    .io_idfiRdData_0_payload_last            (io_outport_rdData_0_payload_last                             ), //i
    .io_idfiRdData_0_payload_fragment_rdData (io_outport_rdData_0_payload_fragment_rdData[31:0]            ), //i
    .io_rden_0                               (radata_rddatarxd_io_rden_0                                   ), //o
    .io_taskRdData_valid                     (radata_rddatarxd_io_taskRdData_valid                         ), //o
    .io_taskRdData_payload_last              (radata_rddatarxd_io_taskRdData_payload_last                  ), //o
    .io_taskRdData_payload_fragment_data     (radata_rddatarxd_io_taskRdData_payload_fragment_data[31:0]   ), //o
    .io_taskRdData_payload_fragment_context  (radata_rddatarxd_io_taskRdData_payload_fragment_context[17:0]), //o
    .clk_out4                                (clk_out4                                                     ), //i
    .rstN                                    (rstN                                                         )  //i
  );
  assign io_inport_writeData_ready = wrdata_wrdatatxd_io_taskWrData_ready;
  assign radata_rddatarxd_io_taskRdData_toStream_valid = radata_rddatarxd_io_taskRdData_valid;
  assign radata_rddatarxd_io_taskRdData_toStream_payload_last = radata_rddatarxd_io_taskRdData_payload_last;
  assign radata_rddatarxd_io_taskRdData_toStream_payload_fragment_data = radata_rddatarxd_io_taskRdData_payload_fragment_data;
  assign radata_rddatarxd_io_taskRdData_toStream_payload_fragment_context = radata_rddatarxd_io_taskRdData_payload_fragment_context;
  assign io_inport_rsp_valid = radata_rddatarxd_io_taskRdData_toStream_valid;
  assign radata_rddatarxd_io_taskRdData_toStream_ready = io_inport_rsp_ready;
  assign io_inport_rsp_payload_last = radata_rddatarxd_io_taskRdData_toStream_payload_last;
  assign io_inport_rsp_payload_fragment_data = radata_rddatarxd_io_taskRdData_toStream_payload_fragment_data;
  assign io_inport_rsp_payload_fragment_context = radata_rddatarxd_io_taskRdData_toStream_payload_fragment_context;
  assign io_outport_cmd_0_valid = cmd_cmdtxd_io_cmd_0_valid;
  assign io_outport_cmd_0_payload_weN = cmd_cmdtxd_io_cmd_0_payload_weN;
  assign io_outport_cmd_0_payload_casN = cmd_cmdtxd_io_cmd_0_payload_casN;
  assign io_outport_cmd_0_payload_rasN = cmd_cmdtxd_io_cmd_0_payload_rasN;
  assign io_outport_cmd_0_payload_csN = cmd_cmdtxd_io_cmd_0_payload_csN;
  assign io_outport_address_0_valid = cmd_cmdtxd_io_address_0_valid;
  assign io_outport_address_0_payload_bank = cmd_cmdtxd_io_address_0_payload_bank;
  assign io_outport_address_0_payload_address = cmd_cmdtxd_io_address_0_payload_address;
  assign io_outport_wrData_0_valid = wrdata_wrdatatxd_io_idfiWrData_0_valid;
  assign io_outport_wrData_0_payload_wrData = wrdata_wrdatatxd_io_idfiWrData_0_payload_wrData;
  assign io_outport_wrData_0_payload_wrDataMask = wrdata_wrdatatxd_io_idfiWrData_0_payload_wrDataMask;
  assign io_outport_rdData_0_ready = radata_rddatarxd_io_idfiRdData_0_ready;
  assign io_outport_rdEn_0 = radata_rddatarxd_io_rden_0;
  always @(posedge clk_out4 or negedge rstN) begin
    if(!rstN) begin
      io_inport_tasks_init_read <= 1'b0;
      io_inport_tasks_init_write <= 1'b0;
      io_inport_tasks_init_precharge <= 1'b0;
      io_inport_tasks_init_active <= 1'b0;
      io_inport_tasks_init_prechargeAll <= 1'b0;
      io_inport_tasks_init_refresh <= 1'b0;
      io_inport_tasks_write_regNext <= 1'b0;
      io_inport_tasks_init_read_1 <= 1'b0;
      io_inport_tasks_init_write_1 <= 1'b0;
      io_inport_tasks_init_precharge_1 <= 1'b0;
      io_inport_tasks_init_active_1 <= 1'b0;
      io_inport_tasks_init_prechargeAll_1 <= 1'b0;
      io_inport_tasks_init_refresh_1 <= 1'b0;
    end else begin
      io_inport_tasks_init_read <= io_inport_tasks_read;
      io_inport_tasks_init_write <= io_inport_tasks_write;
      io_inport_tasks_init_active <= io_inport_tasks_active;
      io_inport_tasks_init_precharge <= io_inport_tasks_precharge;
      io_inport_tasks_init_prechargeAll <= io_inport_tasks_prechargeAll;
      io_inport_tasks_init_refresh <= io_inport_tasks_refresh;
      io_inport_tasks_write_regNext <= io_inport_tasks_write;
      io_inport_tasks_init_read_1 <= io_inport_tasks_read;
      io_inport_tasks_init_write_1 <= io_inport_tasks_write;
      io_inport_tasks_init_active_1 <= io_inport_tasks_active;
      io_inport_tasks_init_precharge_1 <= io_inport_tasks_precharge;
      io_inport_tasks_init_prechargeAll_1 <= io_inport_tasks_prechargeAll;
      io_inport_tasks_init_refresh_1 <= io_inport_tasks_refresh;
    end
  end

  always @(posedge clk_out4) begin
    io_inport_tasks_init_last <= io_inport_tasks_last;
    io_inport_tasks_init_address_byte <= io_inport_tasks_address_byte;
    io_inport_tasks_init_address_column <= io_inport_tasks_address_column;
    io_inport_tasks_init_address_bank <= io_inport_tasks_address_bank;
    io_inport_tasks_init_address_row <= io_inport_tasks_address_row;
    io_inport_tasks_init_context <= io_inport_tasks_context;
    io_inport_tasks_init_last_1 <= io_inport_tasks_last;
    io_inport_tasks_init_address_byte_1 <= io_inport_tasks_address_byte;
    io_inport_tasks_init_address_column_1 <= io_inport_tasks_address_column;
    io_inport_tasks_init_address_bank_1 <= io_inport_tasks_address_bank;
    io_inport_tasks_init_address_row_1 <= io_inport_tasks_address_row;
    io_inport_tasks_init_context_1 <= io_inport_tasks_context;
  end


endmodule
