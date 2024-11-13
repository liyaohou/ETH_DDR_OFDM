// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : BmbBridge
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module BmbBridge (
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
  output wire          io_taskPort_tasks_read,
  output wire          io_taskPort_tasks_write,
  output wire          io_taskPort_tasks_active,
  output wire          io_taskPort_tasks_precharge,
  output wire          io_taskPort_tasks_last,
  output wire [0:0]    io_taskPort_tasks_address_byte,
  output wire [9:0]    io_taskPort_tasks_address_column,
  output wire [2:0]    io_taskPort_tasks_address_bank,
  output wire [14:0]   io_taskPort_tasks_address_row,
  output wire [17:0]   io_taskPort_tasks_context,
  output wire          io_taskPort_tasks_prechargeAll,
  output wire          io_taskPort_tasks_refresh,
  output wire          io_taskPort_writeData_valid,
  input  wire          io_taskPort_writeData_ready,
  output wire [31:0]   io_taskPort_writeData_payload_data,
  output wire [3:0]    io_taskPort_writeData_payload_mask,
  input  wire          io_taskPort_rsp_valid,
  output reg           io_taskPort_rsp_ready,
  input  wire          io_taskPort_rsp_payload_last,
  input  wire [31:0]   io_taskPort_rsp_payload_fragment_data,
  input  wire [17:0]   io_taskPort_rsp_payload_fragment_context,
  input  wire          clk_out4,
  input  wire          rstN
);

  reg                 bmbAdapter_1_io_output_cmd_ready;
  reg                 bmbAdapter_1_io_output_writeData_ready;
  reg                 bmbAdapter_1_io_output_writeDataToken_ready;
  wire                bmbAdapter_1_io_input_cmd_ready;
  wire                bmbAdapter_1_io_input_rsp_valid;
  wire                bmbAdapter_1_io_input_rsp_payload_last;
  wire       [0:0]    bmbAdapter_1_io_input_rsp_payload_fragment_opcode;
  wire       [31:0]   bmbAdapter_1_io_input_rsp_payload_fragment_data;
  wire       [3:0]    bmbAdapter_1_io_input_rsp_payload_fragment_context;
  wire                bmbAdapter_1_io_output_cmd_valid;
  wire                bmbAdapter_1_io_output_cmd_payload_write;
  wire       [28:0]   bmbAdapter_1_io_output_cmd_payload_address;
  wire       [17:0]   bmbAdapter_1_io_output_cmd_payload_context;
  wire                bmbAdapter_1_io_output_cmd_payload_burstLast;
  wire       [1:0]    bmbAdapter_1_io_output_cmd_payload_length;
  wire                bmbAdapter_1_io_output_writeDataToken_valid;
  wire                bmbAdapter_1_io_output_writeDataToken_payload_valid;
  wire                bmbAdapter_1_io_output_writeDataToken_payload_ready;
  wire                bmbAdapter_1_io_output_writeData_valid;
  wire       [31:0]   bmbAdapter_1_io_output_writeData_payload_data;
  wire       [3:0]    bmbAdapter_1_io_output_writeData_payload_mask;
  wire                bmbAdapter_1_io_output_rsp_ready;
  wire                maketask_1_io_cmd_ready;
  wire                maketask_1_io_halt;
  wire                maketask_1_io_writeDataToken_ready;
  wire                maketask_1_io_output_read;
  wire                maketask_1_io_output_write;
  wire                maketask_1_io_output_active;
  wire                maketask_1_io_output_precharge;
  wire                maketask_1_io_output_last;
  wire       [0:0]    maketask_1_io_output_address_byte;
  wire       [9:0]    maketask_1_io_output_address_column;
  wire       [2:0]    maketask_1_io_output_address_bank;
  wire       [14:0]   maketask_1_io_output_address_row;
  wire       [17:0]   maketask_1_io_output_context;
  wire                maketask_1_io_output_prechargeAll;
  wire                maketask_1_io_output_refresh;
  wire                bmbAdapter_1_io_output_writeData_m2sPipe_valid;
  wire                bmbAdapter_1_io_output_writeData_m2sPipe_ready;
  wire       [31:0]   bmbAdapter_1_io_output_writeData_m2sPipe_payload_data;
  wire       [3:0]    bmbAdapter_1_io_output_writeData_m2sPipe_payload_mask;
  reg                 bmbAdapter_1_io_output_writeData_rValid;
  reg        [31:0]   bmbAdapter_1_io_output_writeData_rData_data;
  reg        [3:0]    bmbAdapter_1_io_output_writeData_rData_mask;
  wire                when_Stream_l393;
  wire                io_taskPort_rsp_m2sPipe_valid;
  wire                io_taskPort_rsp_m2sPipe_ready;
  wire                io_taskPort_rsp_m2sPipe_payload_last;
  wire       [31:0]   io_taskPort_rsp_m2sPipe_payload_fragment_data;
  wire       [17:0]   io_taskPort_rsp_m2sPipe_payload_fragment_context;
  reg                 io_taskPort_rsp_rValid;
  reg                 io_taskPort_rsp_rData_last;
  reg        [31:0]   io_taskPort_rsp_rData_fragment_data;
  reg        [17:0]   io_taskPort_rsp_rData_fragment_context;
  wire                when_Stream_l393_1;
  wire                bmbAdapter_1_io_output_cmd_m2sPipe_valid;
  wire                bmbAdapter_1_io_output_cmd_m2sPipe_ready;
  wire                bmbAdapter_1_io_output_cmd_m2sPipe_payload_write;
  wire       [28:0]   bmbAdapter_1_io_output_cmd_m2sPipe_payload_address;
  wire       [17:0]   bmbAdapter_1_io_output_cmd_m2sPipe_payload_context;
  wire                bmbAdapter_1_io_output_cmd_m2sPipe_payload_burstLast;
  wire       [1:0]    bmbAdapter_1_io_output_cmd_m2sPipe_payload_length;
  reg                 bmbAdapter_1_io_output_cmd_rValid;
  reg                 bmbAdapter_1_io_output_cmd_rData_write;
  reg        [28:0]   bmbAdapter_1_io_output_cmd_rData_address;
  reg        [17:0]   bmbAdapter_1_io_output_cmd_rData_context;
  reg                 bmbAdapter_1_io_output_cmd_rData_burstLast;
  reg        [1:0]    bmbAdapter_1_io_output_cmd_rData_length;
  wire                when_Stream_l393_2;
  wire                bmbAdapter_1_io_output_writeDataToken_m2sPipe_valid;
  wire                bmbAdapter_1_io_output_writeDataToken_m2sPipe_ready;
  wire                bmbAdapter_1_io_output_writeDataToken_m2sPipe_payload_valid;
  wire                bmbAdapter_1_io_output_writeDataToken_m2sPipe_payload_ready;
  reg                 bmbAdapter_1_io_output_writeDataToken_rValid;
  reg                 bmbAdapter_1_io_output_writeDataToken_rData_valid;
  reg                 bmbAdapter_1_io_output_writeDataToken_rData_ready;
  wire                when_Stream_l393_3;
  reg                 maketask_1_io_halt_regNext;

  BmbAdapter bmbAdapter_1 (
    .io_halt                                (maketask_1_io_halt_regNext                             ), //i
    .io_input_cmd_valid                     (io_bmb_cmd_valid                                       ), //i
    .io_input_cmd_ready                     (bmbAdapter_1_io_input_cmd_ready                        ), //o
    .io_input_cmd_payload_last              (io_bmb_cmd_payload_last                                ), //i
    .io_input_cmd_payload_fragment_opcode   (io_bmb_cmd_payload_fragment_opcode                     ), //i
    .io_input_cmd_payload_fragment_address  (io_bmb_cmd_payload_fragment_address[28:0]              ), //i
    .io_input_cmd_payload_fragment_length   (io_bmb_cmd_payload_fragment_length[9:0]                ), //i
    .io_input_cmd_payload_fragment_data     (io_bmb_cmd_payload_fragment_data[31:0]                 ), //i
    .io_input_cmd_payload_fragment_mask     (io_bmb_cmd_payload_fragment_mask[3:0]                  ), //i
    .io_input_cmd_payload_fragment_context  (io_bmb_cmd_payload_fragment_context[3:0]               ), //i
    .io_input_rsp_valid                     (bmbAdapter_1_io_input_rsp_valid                        ), //o
    .io_input_rsp_ready                     (io_bmb_rsp_ready                                       ), //i
    .io_input_rsp_payload_last              (bmbAdapter_1_io_input_rsp_payload_last                 ), //o
    .io_input_rsp_payload_fragment_opcode   (bmbAdapter_1_io_input_rsp_payload_fragment_opcode      ), //o
    .io_input_rsp_payload_fragment_data     (bmbAdapter_1_io_input_rsp_payload_fragment_data[31:0]  ), //o
    .io_input_rsp_payload_fragment_context  (bmbAdapter_1_io_input_rsp_payload_fragment_context[3:0]), //o
    .io_output_cmd_valid                    (bmbAdapter_1_io_output_cmd_valid                       ), //o
    .io_output_cmd_ready                    (bmbAdapter_1_io_output_cmd_ready                       ), //i
    .io_output_cmd_payload_write            (bmbAdapter_1_io_output_cmd_payload_write               ), //o
    .io_output_cmd_payload_address          (bmbAdapter_1_io_output_cmd_payload_address[28:0]       ), //o
    .io_output_cmd_payload_context          (bmbAdapter_1_io_output_cmd_payload_context[17:0]       ), //o
    .io_output_cmd_payload_burstLast        (bmbAdapter_1_io_output_cmd_payload_burstLast           ), //o
    .io_output_cmd_payload_length           (bmbAdapter_1_io_output_cmd_payload_length[1:0]         ), //o
    .io_output_writeData_valid              (bmbAdapter_1_io_output_writeData_valid                 ), //o
    .io_output_writeData_ready              (bmbAdapter_1_io_output_writeData_ready                 ), //i
    .io_output_writeData_payload_data       (bmbAdapter_1_io_output_writeData_payload_data[31:0]    ), //o
    .io_output_writeData_payload_mask       (bmbAdapter_1_io_output_writeData_payload_mask[3:0]     ), //o
    .io_output_writeDataToken_valid         (bmbAdapter_1_io_output_writeDataToken_valid            ), //o
    .io_output_writeDataToken_ready         (bmbAdapter_1_io_output_writeDataToken_ready            ), //i
    .io_output_writeDataToken_payload_valid (bmbAdapter_1_io_output_writeDataToken_payload_valid    ), //o
    .io_output_writeDataToken_payload_ready (bmbAdapter_1_io_output_writeDataToken_payload_ready    ), //o
    .io_output_rsp_valid                    (io_taskPort_rsp_m2sPipe_valid                          ), //i
    .io_output_rsp_ready                    (bmbAdapter_1_io_output_rsp_ready                       ), //o
    .io_output_rsp_payload_last             (io_taskPort_rsp_m2sPipe_payload_last                   ), //i
    .io_output_rsp_payload_fragment_data    (io_taskPort_rsp_m2sPipe_payload_fragment_data[31:0]    ), //i
    .io_output_rsp_payload_fragment_context (io_taskPort_rsp_m2sPipe_payload_fragment_context[17:0] ), //i
    .clk_out4                               (clk_out4                                               ), //i
    .rstN                                   (rstN                                                   )  //i
  );
  MakeTask maketask_1 (
    .io_cmd_valid                    (bmbAdapter_1_io_output_cmd_m2sPipe_valid                   ), //i
    .io_cmd_ready                    (maketask_1_io_cmd_ready                                    ), //o
    .io_cmd_payload_write            (bmbAdapter_1_io_output_cmd_m2sPipe_payload_write           ), //i
    .io_cmd_payload_address          (bmbAdapter_1_io_output_cmd_m2sPipe_payload_address[28:0]   ), //i
    .io_cmd_payload_context          (bmbAdapter_1_io_output_cmd_m2sPipe_payload_context[17:0]   ), //i
    .io_cmd_payload_burstLast        (bmbAdapter_1_io_output_cmd_m2sPipe_payload_burstLast       ), //i
    .io_cmd_payload_length           (bmbAdapter_1_io_output_cmd_m2sPipe_payload_length[1:0]     ), //i
    .io_halt                         (maketask_1_io_halt                                         ), //o
    .io_writeDataToken_valid         (bmbAdapter_1_io_output_writeDataToken_m2sPipe_valid        ), //i
    .io_writeDataToken_ready         (maketask_1_io_writeDataToken_ready                         ), //o
    .io_writeDataToken_payload_valid (bmbAdapter_1_io_output_writeDataToken_m2sPipe_payload_valid), //i
    .io_writeDataToken_payload_ready (bmbAdapter_1_io_output_writeDataToken_m2sPipe_payload_ready), //i
    .io_output_read                  (maketask_1_io_output_read                                  ), //o
    .io_output_write                 (maketask_1_io_output_write                                 ), //o
    .io_output_active                (maketask_1_io_output_active                                ), //o
    .io_output_precharge             (maketask_1_io_output_precharge                             ), //o
    .io_output_last                  (maketask_1_io_output_last                                  ), //o
    .io_output_address_byte          (maketask_1_io_output_address_byte                          ), //o
    .io_output_address_column        (maketask_1_io_output_address_column[9:0]                   ), //o
    .io_output_address_bank          (maketask_1_io_output_address_bank[2:0]                     ), //o
    .io_output_address_row           (maketask_1_io_output_address_row[14:0]                     ), //o
    .io_output_context               (maketask_1_io_output_context[17:0]                         ), //o
    .io_output_prechargeAll          (maketask_1_io_output_prechargeAll                          ), //o
    .io_output_refresh               (maketask_1_io_output_refresh                               ), //o
    .clk_out4                        (clk_out4                                                   ), //i
    .rstN                            (rstN                                                       )  //i
  );
  assign io_bmb_cmd_ready = bmbAdapter_1_io_input_cmd_ready;
  assign io_bmb_rsp_valid = bmbAdapter_1_io_input_rsp_valid;
  assign io_bmb_rsp_payload_last = bmbAdapter_1_io_input_rsp_payload_last;
  assign io_bmb_rsp_payload_fragment_opcode = bmbAdapter_1_io_input_rsp_payload_fragment_opcode;
  assign io_bmb_rsp_payload_fragment_data = bmbAdapter_1_io_input_rsp_payload_fragment_data;
  assign io_bmb_rsp_payload_fragment_context = bmbAdapter_1_io_input_rsp_payload_fragment_context;
  always @(*) begin
    bmbAdapter_1_io_output_writeData_ready = bmbAdapter_1_io_output_writeData_m2sPipe_ready;
    if(when_Stream_l393) begin
      bmbAdapter_1_io_output_writeData_ready = 1'b1;
    end
  end

  assign when_Stream_l393 = (! bmbAdapter_1_io_output_writeData_m2sPipe_valid);
  assign bmbAdapter_1_io_output_writeData_m2sPipe_valid = bmbAdapter_1_io_output_writeData_rValid;
  assign bmbAdapter_1_io_output_writeData_m2sPipe_payload_data = bmbAdapter_1_io_output_writeData_rData_data;
  assign bmbAdapter_1_io_output_writeData_m2sPipe_payload_mask = bmbAdapter_1_io_output_writeData_rData_mask;
  assign io_taskPort_writeData_valid = bmbAdapter_1_io_output_writeData_m2sPipe_valid;
  assign bmbAdapter_1_io_output_writeData_m2sPipe_ready = io_taskPort_writeData_ready;
  assign io_taskPort_writeData_payload_data = bmbAdapter_1_io_output_writeData_m2sPipe_payload_data;
  assign io_taskPort_writeData_payload_mask = bmbAdapter_1_io_output_writeData_m2sPipe_payload_mask;
  always @(*) begin
    io_taskPort_rsp_ready = io_taskPort_rsp_m2sPipe_ready;
    if(when_Stream_l393_1) begin
      io_taskPort_rsp_ready = 1'b1;
    end
  end

  assign when_Stream_l393_1 = (! io_taskPort_rsp_m2sPipe_valid);
  assign io_taskPort_rsp_m2sPipe_valid = io_taskPort_rsp_rValid;
  assign io_taskPort_rsp_m2sPipe_payload_last = io_taskPort_rsp_rData_last;
  assign io_taskPort_rsp_m2sPipe_payload_fragment_data = io_taskPort_rsp_rData_fragment_data;
  assign io_taskPort_rsp_m2sPipe_payload_fragment_context = io_taskPort_rsp_rData_fragment_context;
  assign io_taskPort_rsp_m2sPipe_ready = bmbAdapter_1_io_output_rsp_ready;
  always @(*) begin
    bmbAdapter_1_io_output_cmd_ready = bmbAdapter_1_io_output_cmd_m2sPipe_ready;
    if(when_Stream_l393_2) begin
      bmbAdapter_1_io_output_cmd_ready = 1'b1;
    end
  end

  assign when_Stream_l393_2 = (! bmbAdapter_1_io_output_cmd_m2sPipe_valid);
  assign bmbAdapter_1_io_output_cmd_m2sPipe_valid = bmbAdapter_1_io_output_cmd_rValid;
  assign bmbAdapter_1_io_output_cmd_m2sPipe_payload_write = bmbAdapter_1_io_output_cmd_rData_write;
  assign bmbAdapter_1_io_output_cmd_m2sPipe_payload_address = bmbAdapter_1_io_output_cmd_rData_address;
  assign bmbAdapter_1_io_output_cmd_m2sPipe_payload_context = bmbAdapter_1_io_output_cmd_rData_context;
  assign bmbAdapter_1_io_output_cmd_m2sPipe_payload_burstLast = bmbAdapter_1_io_output_cmd_rData_burstLast;
  assign bmbAdapter_1_io_output_cmd_m2sPipe_payload_length = bmbAdapter_1_io_output_cmd_rData_length;
  assign bmbAdapter_1_io_output_cmd_m2sPipe_ready = maketask_1_io_cmd_ready;
  always @(*) begin
    bmbAdapter_1_io_output_writeDataToken_ready = bmbAdapter_1_io_output_writeDataToken_m2sPipe_ready;
    if(when_Stream_l393_3) begin
      bmbAdapter_1_io_output_writeDataToken_ready = 1'b1;
    end
  end

  assign when_Stream_l393_3 = (! bmbAdapter_1_io_output_writeDataToken_m2sPipe_valid);
  assign bmbAdapter_1_io_output_writeDataToken_m2sPipe_valid = bmbAdapter_1_io_output_writeDataToken_rValid;
  assign bmbAdapter_1_io_output_writeDataToken_m2sPipe_payload_valid = bmbAdapter_1_io_output_writeDataToken_rData_valid;
  assign bmbAdapter_1_io_output_writeDataToken_m2sPipe_payload_ready = bmbAdapter_1_io_output_writeDataToken_rData_ready;
  assign bmbAdapter_1_io_output_writeDataToken_m2sPipe_ready = maketask_1_io_writeDataToken_ready;
  assign io_taskPort_tasks_read = maketask_1_io_output_read;
  assign io_taskPort_tasks_write = maketask_1_io_output_write;
  assign io_taskPort_tasks_active = maketask_1_io_output_active;
  assign io_taskPort_tasks_precharge = maketask_1_io_output_precharge;
  assign io_taskPort_tasks_last = maketask_1_io_output_last;
  assign io_taskPort_tasks_address_byte = maketask_1_io_output_address_byte;
  assign io_taskPort_tasks_address_column = maketask_1_io_output_address_column;
  assign io_taskPort_tasks_address_bank = maketask_1_io_output_address_bank;
  assign io_taskPort_tasks_address_row = maketask_1_io_output_address_row;
  assign io_taskPort_tasks_context = maketask_1_io_output_context;
  assign io_taskPort_tasks_prechargeAll = maketask_1_io_output_prechargeAll;
  assign io_taskPort_tasks_refresh = maketask_1_io_output_refresh;
  always @(posedge clk_out4 or negedge rstN) begin
    if(!rstN) begin
      bmbAdapter_1_io_output_writeData_rValid <= 1'b0;
      io_taskPort_rsp_rValid <= 1'b0;
      bmbAdapter_1_io_output_cmd_rValid <= 1'b0;
      bmbAdapter_1_io_output_writeDataToken_rValid <= 1'b0;
    end else begin
      if(bmbAdapter_1_io_output_writeData_ready) begin
        bmbAdapter_1_io_output_writeData_rValid <= bmbAdapter_1_io_output_writeData_valid;
      end
      if(io_taskPort_rsp_ready) begin
        io_taskPort_rsp_rValid <= io_taskPort_rsp_valid;
      end
      if(bmbAdapter_1_io_output_cmd_ready) begin
        bmbAdapter_1_io_output_cmd_rValid <= bmbAdapter_1_io_output_cmd_valid;
      end
      if(bmbAdapter_1_io_output_writeDataToken_ready) begin
        bmbAdapter_1_io_output_writeDataToken_rValid <= bmbAdapter_1_io_output_writeDataToken_valid;
      end
    end
  end

  always @(posedge clk_out4) begin
    if(bmbAdapter_1_io_output_writeData_ready) begin
      bmbAdapter_1_io_output_writeData_rData_data <= bmbAdapter_1_io_output_writeData_payload_data;
      bmbAdapter_1_io_output_writeData_rData_mask <= bmbAdapter_1_io_output_writeData_payload_mask;
    end
    if(io_taskPort_rsp_ready) begin
      io_taskPort_rsp_rData_last <= io_taskPort_rsp_payload_last;
      io_taskPort_rsp_rData_fragment_data <= io_taskPort_rsp_payload_fragment_data;
      io_taskPort_rsp_rData_fragment_context <= io_taskPort_rsp_payload_fragment_context;
    end
    if(bmbAdapter_1_io_output_cmd_ready) begin
      bmbAdapter_1_io_output_cmd_rData_write <= bmbAdapter_1_io_output_cmd_payload_write;
      bmbAdapter_1_io_output_cmd_rData_address <= bmbAdapter_1_io_output_cmd_payload_address;
      bmbAdapter_1_io_output_cmd_rData_context <= bmbAdapter_1_io_output_cmd_payload_context;
      bmbAdapter_1_io_output_cmd_rData_burstLast <= bmbAdapter_1_io_output_cmd_payload_burstLast;
      bmbAdapter_1_io_output_cmd_rData_length <= bmbAdapter_1_io_output_cmd_payload_length;
    end
    if(bmbAdapter_1_io_output_writeDataToken_ready) begin
      bmbAdapter_1_io_output_writeDataToken_rData_valid <= bmbAdapter_1_io_output_writeDataToken_payload_valid;
      bmbAdapter_1_io_output_writeDataToken_rData_ready <= bmbAdapter_1_io_output_writeDataToken_payload_ready;
    end
    maketask_1_io_halt_regNext <= maketask_1_io_halt;
  end


endmodule
