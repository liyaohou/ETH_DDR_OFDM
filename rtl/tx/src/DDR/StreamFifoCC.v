// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : StreamFifoCC
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module StreamFifoCC (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire          io_push_payload_last,
  input  wire [0:0]    io_push_payload_fragment_opcode,
  input  wire [28:0]   io_push_payload_fragment_address,
  input  wire [9:0]    io_push_payload_fragment_length,
  input  wire [31:0]   io_push_payload_fragment_data,
  input  wire [3:0]    io_push_payload_fragment_mask,
  input  wire [3:0]    io_push_payload_fragment_context,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire          io_pop_payload_last,
  output wire [0:0]    io_pop_payload_fragment_opcode,
  output wire [28:0]   io_pop_payload_fragment_address,
  output wire [9:0]    io_pop_payload_fragment_length,
  output wire [31:0]   io_pop_payload_fragment_data,
  output wire [3:0]    io_pop_payload_fragment_mask,
  output wire [3:0]    io_pop_payload_fragment_context,
  output wire [9:0]    io_pushOccupancy,
  output wire [9:0]    io_popOccupancy,
  input  wire          clk_out1,
  input  wire          rstN,
  input  wire          clk_out4,
  output wire          adapter_bmbCCDomain_axi4StreamToBmb_workClockArea_ddr3AxisTxIf_toplevel_rstN_synchronized_1
);

  reg        [80:0]   ram_spinal_port1;
  wire       [9:0]    popToPushGray_buffercc_io_dataOut;
  wire                adapter_bmbCCDomain_axi4StreamToBmb_workClockArea_ddr3AxisTxIf_toplevel_rstN_asyncAssertSyncDeassert_buffercc_io_dataOut;
  wire       [9:0]    pushToPopGray_buffercc_io_dataOut;
  wire       [9:0]    _zz_pushCC_pushPtrGray;
  wire       [8:0]    _zz_ram_port;
  wire       [80:0]   _zz_ram_port_1;
  wire                _zz_io_pushOccupancy_9;
  wire       [9:0]    _zz_popCC_popPtrGray;
  wire                _zz_io_popOccupancy_9;
  reg                 _zz_1;
  wire       [9:0]    popToPushGray;
  wire       [9:0]    pushToPopGray;
  reg        [9:0]    pushCC_pushPtr;
  wire       [9:0]    pushCC_pushPtrPlus;
  wire                io_push_fire;
  (* altera_attribute = "-name ADV_NETLIST_OPT_ALLOWED NEVER_ALLOW" *) reg        [9:0]    pushCC_pushPtrGray;
  wire       [9:0]    pushCC_popPtrGray;
  wire                pushCC_full;
  wire                _zz_io_pushOccupancy;
  wire                _zz_io_pushOccupancy_1;
  wire                _zz_io_pushOccupancy_2;
  wire                _zz_io_pushOccupancy_3;
  wire                _zz_io_pushOccupancy_4;
  wire                _zz_io_pushOccupancy_5;
  wire                _zz_io_pushOccupancy_6;
  wire                _zz_io_pushOccupancy_7;
  wire                _zz_io_pushOccupancy_8;
  wire                adapter_bmbCCDomain_axi4StreamToBmb_workClockArea_ddr3AxisTxIf_toplevel_rstN_asyncAssertSyncDeassert;
  wire                adapter_bmbCCDomain_axi4StreamToBmb_workClockArea_ddr3AxisTxIf_toplevel_rstN_synchronized;
  reg        [9:0]    popCC_popPtr;
  (* keep , syn_keep *) wire       [9:0]    popCC_popPtrPlus /* synthesis syn_keep = 1 */ ;
  wire       [9:0]    popCC_popPtrGray;
  wire       [9:0]    popCC_pushPtrGray;
  wire                popCC_addressGen_valid;
  reg                 popCC_addressGen_ready;
  wire       [8:0]    popCC_addressGen_payload;
  wire                popCC_empty;
  wire                popCC_addressGen_fire;
  wire                popCC_readArbitation_valid;
  wire                popCC_readArbitation_ready;
  wire       [8:0]    popCC_readArbitation_payload;
  reg                 popCC_addressGen_rValid;
  reg        [8:0]    popCC_addressGen_rData;
  wire                when_Stream_l393;
  wire                popCC_readPort_cmd_valid;
  wire       [8:0]    popCC_readPort_cmd_payload;
  wire                popCC_readPort_rsp_last;
  wire       [0:0]    popCC_readPort_rsp_fragment_opcode;
  wire       [28:0]   popCC_readPort_rsp_fragment_address;
  wire       [9:0]    popCC_readPort_rsp_fragment_length;
  wire       [31:0]   popCC_readPort_rsp_fragment_data;
  wire       [3:0]    popCC_readPort_rsp_fragment_mask;
  wire       [3:0]    popCC_readPort_rsp_fragment_context;
  wire       [80:0]   _zz_popCC_readPort_rsp_last;
  wire       [79:0]   _zz_popCC_readPort_rsp_fragment_opcode;
  wire                popCC_readArbitation_translated_valid;
  wire                popCC_readArbitation_translated_ready;
  wire                popCC_readArbitation_translated_payload_last;
  wire       [0:0]    popCC_readArbitation_translated_payload_fragment_opcode;
  wire       [28:0]   popCC_readArbitation_translated_payload_fragment_address;
  wire       [9:0]    popCC_readArbitation_translated_payload_fragment_length;
  wire       [31:0]   popCC_readArbitation_translated_payload_fragment_data;
  wire       [3:0]    popCC_readArbitation_translated_payload_fragment_mask;
  wire       [3:0]    popCC_readArbitation_translated_payload_fragment_context;
  wire                popCC_readArbitation_fire;
  (* altera_attribute = "-name ADV_NETLIST_OPT_ALLOWED NEVER_ALLOW" *) reg        [9:0]    popCC_ptrToPush;
  reg        [9:0]    popCC_ptrToOccupancy;
  wire                _zz_io_popOccupancy;
  wire                _zz_io_popOccupancy_1;
  wire                _zz_io_popOccupancy_2;
  wire                _zz_io_popOccupancy_3;
  wire                _zz_io_popOccupancy_4;
  wire                _zz_io_popOccupancy_5;
  wire                _zz_io_popOccupancy_6;
  wire                _zz_io_popOccupancy_7;
  wire                _zz_io_popOccupancy_8;
  reg [80:0] ram [0:511];

  assign _zz_pushCC_pushPtrGray = (pushCC_pushPtrPlus >>> 1'b1);
  assign _zz_ram_port = pushCC_pushPtr[8:0];
  assign _zz_popCC_popPtrGray = (popCC_popPtr >>> 1'b1);
  assign _zz_ram_port_1 = {{io_push_payload_fragment_context,{io_push_payload_fragment_mask,{io_push_payload_fragment_data,{io_push_payload_fragment_length,{io_push_payload_fragment_address,io_push_payload_fragment_opcode}}}}},io_push_payload_last};
  assign _zz_io_pushOccupancy_9 = (pushCC_popPtrGray[0] ^ _zz_io_pushOccupancy);
  assign _zz_io_popOccupancy_9 = (popCC_pushPtrGray[0] ^ _zz_io_popOccupancy);
  always @(posedge clk_out1) begin
    if(_zz_1) begin
      ram[_zz_ram_port] <= _zz_ram_port_1;
    end
  end

  always @(posedge clk_out4) begin
    if(popCC_readPort_cmd_valid) begin
      ram_spinal_port1 <= ram[popCC_readPort_cmd_payload];
    end
  end

  (* keep_hierarchy = "TRUE" *) BufferCC popToPushGray_buffercc (
    .io_dataIn  (popToPushGray[9:0]                    ), //i
    .io_dataOut (popToPushGray_buffercc_io_dataOut[9:0]), //o
    .clk_out1   (clk_out1                              ), //i
    .rstN       (rstN                                  )  //i
  );
  (* keep_hierarchy = "TRUE" *) BufferCC_1 adapter_bmbCCDomain_axi4StreamToBmb_workClockArea_ddr3AxisTxIf_toplevel_rstN_asyncAssertSyncDeassert_buffercc (
    .io_dataIn  (adapter_bmbCCDomain_axi4StreamToBmb_workClockArea_ddr3AxisTxIf_toplevel_rstN_asyncAssertSyncDeassert                    ), //i
    .io_dataOut (adapter_bmbCCDomain_axi4StreamToBmb_workClockArea_ddr3AxisTxIf_toplevel_rstN_asyncAssertSyncDeassert_buffercc_io_dataOut), //o
    .clk_out4   (clk_out4                                                                                                                ), //i
    .rstN       (rstN                                                                                                                    )  //i
  );
  (* keep_hierarchy = "TRUE" *) BufferCC_2 pushToPopGray_buffercc (
    .io_dataIn                                                                                 (pushToPopGray[9:0]                                                                       ), //i
    .io_dataOut                                                                                (pushToPopGray_buffercc_io_dataOut[9:0]                                                   ), //o
    .clk_out4                                                                                  (clk_out4                                                                                 ), //i
    .adapter_bmbCCDomain_axi4StreamToBmb_workClockArea_ddr3AxisTxIf_toplevel_rstN_synchronized (adapter_bmbCCDomain_axi4StreamToBmb_workClockArea_ddr3AxisTxIf_toplevel_rstN_synchronized)  //i
  );
  always @(*) begin
    _zz_1 = 1'b0;
    if(io_push_fire) begin
      _zz_1 = 1'b1;
    end
  end

  assign pushCC_pushPtrPlus = (pushCC_pushPtr + 10'h001);
  assign io_push_fire = (io_push_valid && io_push_ready);
  assign pushCC_popPtrGray = popToPushGray_buffercc_io_dataOut;
  assign pushCC_full = ((pushCC_pushPtrGray[9 : 8] == (~ pushCC_popPtrGray[9 : 8])) && (pushCC_pushPtrGray[7 : 0] == pushCC_popPtrGray[7 : 0]));
  assign io_push_ready = (! pushCC_full);
  assign _zz_io_pushOccupancy = (pushCC_popPtrGray[1] ^ _zz_io_pushOccupancy_1);
  assign _zz_io_pushOccupancy_1 = (pushCC_popPtrGray[2] ^ _zz_io_pushOccupancy_2);
  assign _zz_io_pushOccupancy_2 = (pushCC_popPtrGray[3] ^ _zz_io_pushOccupancy_3);
  assign _zz_io_pushOccupancy_3 = (pushCC_popPtrGray[4] ^ _zz_io_pushOccupancy_4);
  assign _zz_io_pushOccupancy_4 = (pushCC_popPtrGray[5] ^ _zz_io_pushOccupancy_5);
  assign _zz_io_pushOccupancy_5 = (pushCC_popPtrGray[6] ^ _zz_io_pushOccupancy_6);
  assign _zz_io_pushOccupancy_6 = (pushCC_popPtrGray[7] ^ _zz_io_pushOccupancy_7);
  assign _zz_io_pushOccupancy_7 = (pushCC_popPtrGray[8] ^ _zz_io_pushOccupancy_8);
  assign _zz_io_pushOccupancy_8 = pushCC_popPtrGray[9];
  assign io_pushOccupancy = (pushCC_pushPtr - {_zz_io_pushOccupancy_8,{_zz_io_pushOccupancy_7,{_zz_io_pushOccupancy_6,{_zz_io_pushOccupancy_5,{_zz_io_pushOccupancy_4,{_zz_io_pushOccupancy_3,{_zz_io_pushOccupancy_2,{_zz_io_pushOccupancy_1,{_zz_io_pushOccupancy,_zz_io_pushOccupancy_9}}}}}}}}});
  assign adapter_bmbCCDomain_axi4StreamToBmb_workClockArea_ddr3AxisTxIf_toplevel_rstN_asyncAssertSyncDeassert = (1'b1 ^ 1'b0);
  assign adapter_bmbCCDomain_axi4StreamToBmb_workClockArea_ddr3AxisTxIf_toplevel_rstN_synchronized = adapter_bmbCCDomain_axi4StreamToBmb_workClockArea_ddr3AxisTxIf_toplevel_rstN_asyncAssertSyncDeassert_buffercc_io_dataOut;
  assign popCC_popPtrPlus = (popCC_popPtr + 10'h001);
  assign popCC_popPtrGray = (_zz_popCC_popPtrGray ^ popCC_popPtr);
  assign popCC_pushPtrGray = pushToPopGray_buffercc_io_dataOut;
  assign popCC_empty = (popCC_popPtrGray == popCC_pushPtrGray);
  assign popCC_addressGen_valid = (! popCC_empty);
  assign popCC_addressGen_payload = popCC_popPtr[8:0];
  assign popCC_addressGen_fire = (popCC_addressGen_valid && popCC_addressGen_ready);
  always @(*) begin
    popCC_addressGen_ready = popCC_readArbitation_ready;
    if(when_Stream_l393) begin
      popCC_addressGen_ready = 1'b1;
    end
  end

  assign when_Stream_l393 = (! popCC_readArbitation_valid);
  assign popCC_readArbitation_valid = popCC_addressGen_rValid;
  assign popCC_readArbitation_payload = popCC_addressGen_rData;
  assign _zz_popCC_readPort_rsp_last = ram_spinal_port1;
  assign _zz_popCC_readPort_rsp_fragment_opcode = _zz_popCC_readPort_rsp_last[80 : 1];
  assign popCC_readPort_rsp_last = _zz_popCC_readPort_rsp_last[0];
  assign popCC_readPort_rsp_fragment_opcode = _zz_popCC_readPort_rsp_fragment_opcode[0 : 0];
  assign popCC_readPort_rsp_fragment_address = _zz_popCC_readPort_rsp_fragment_opcode[29 : 1];
  assign popCC_readPort_rsp_fragment_length = _zz_popCC_readPort_rsp_fragment_opcode[39 : 30];
  assign popCC_readPort_rsp_fragment_data = _zz_popCC_readPort_rsp_fragment_opcode[71 : 40];
  assign popCC_readPort_rsp_fragment_mask = _zz_popCC_readPort_rsp_fragment_opcode[75 : 72];
  assign popCC_readPort_rsp_fragment_context = _zz_popCC_readPort_rsp_fragment_opcode[79 : 76];
  assign popCC_readPort_cmd_valid = popCC_addressGen_fire;
  assign popCC_readPort_cmd_payload = popCC_addressGen_payload;
  assign popCC_readArbitation_translated_valid = popCC_readArbitation_valid;
  assign popCC_readArbitation_ready = popCC_readArbitation_translated_ready;
  assign popCC_readArbitation_translated_payload_last = popCC_readPort_rsp_last;
  assign popCC_readArbitation_translated_payload_fragment_opcode = popCC_readPort_rsp_fragment_opcode;
  assign popCC_readArbitation_translated_payload_fragment_address = popCC_readPort_rsp_fragment_address;
  assign popCC_readArbitation_translated_payload_fragment_length = popCC_readPort_rsp_fragment_length;
  assign popCC_readArbitation_translated_payload_fragment_data = popCC_readPort_rsp_fragment_data;
  assign popCC_readArbitation_translated_payload_fragment_mask = popCC_readPort_rsp_fragment_mask;
  assign popCC_readArbitation_translated_payload_fragment_context = popCC_readPort_rsp_fragment_context;
  assign io_pop_valid = popCC_readArbitation_translated_valid;
  assign popCC_readArbitation_translated_ready = io_pop_ready;
  assign io_pop_payload_last = popCC_readArbitation_translated_payload_last;
  assign io_pop_payload_fragment_opcode = popCC_readArbitation_translated_payload_fragment_opcode;
  assign io_pop_payload_fragment_address = popCC_readArbitation_translated_payload_fragment_address;
  assign io_pop_payload_fragment_length = popCC_readArbitation_translated_payload_fragment_length;
  assign io_pop_payload_fragment_data = popCC_readArbitation_translated_payload_fragment_data;
  assign io_pop_payload_fragment_mask = popCC_readArbitation_translated_payload_fragment_mask;
  assign io_pop_payload_fragment_context = popCC_readArbitation_translated_payload_fragment_context;
  assign popCC_readArbitation_fire = (popCC_readArbitation_valid && popCC_readArbitation_ready);
  assign _zz_io_popOccupancy = (popCC_pushPtrGray[1] ^ _zz_io_popOccupancy_1);
  assign _zz_io_popOccupancy_1 = (popCC_pushPtrGray[2] ^ _zz_io_popOccupancy_2);
  assign _zz_io_popOccupancy_2 = (popCC_pushPtrGray[3] ^ _zz_io_popOccupancy_3);
  assign _zz_io_popOccupancy_3 = (popCC_pushPtrGray[4] ^ _zz_io_popOccupancy_4);
  assign _zz_io_popOccupancy_4 = (popCC_pushPtrGray[5] ^ _zz_io_popOccupancy_5);
  assign _zz_io_popOccupancy_5 = (popCC_pushPtrGray[6] ^ _zz_io_popOccupancy_6);
  assign _zz_io_popOccupancy_6 = (popCC_pushPtrGray[7] ^ _zz_io_popOccupancy_7);
  assign _zz_io_popOccupancy_7 = (popCC_pushPtrGray[8] ^ _zz_io_popOccupancy_8);
  assign _zz_io_popOccupancy_8 = popCC_pushPtrGray[9];
  assign io_popOccupancy = ({_zz_io_popOccupancy_8,{_zz_io_popOccupancy_7,{_zz_io_popOccupancy_6,{_zz_io_popOccupancy_5,{_zz_io_popOccupancy_4,{_zz_io_popOccupancy_3,{_zz_io_popOccupancy_2,{_zz_io_popOccupancy_1,{_zz_io_popOccupancy,_zz_io_popOccupancy_9}}}}}}}}} - popCC_ptrToOccupancy);
  assign pushToPopGray = pushCC_pushPtrGray;
  assign popToPushGray = popCC_ptrToPush;
  assign adapter_bmbCCDomain_axi4StreamToBmb_workClockArea_ddr3AxisTxIf_toplevel_rstN_synchronized_1 = adapter_bmbCCDomain_axi4StreamToBmb_workClockArea_ddr3AxisTxIf_toplevel_rstN_synchronized;
  always @(posedge clk_out1 or negedge rstN) begin
    if(!rstN) begin
      pushCC_pushPtr <= 10'h0;
      pushCC_pushPtrGray <= 10'h0;
    end else begin
      if(io_push_fire) begin
        pushCC_pushPtrGray <= (_zz_pushCC_pushPtrGray ^ pushCC_pushPtrPlus);
      end
      if(io_push_fire) begin
        pushCC_pushPtr <= pushCC_pushPtrPlus;
      end
    end
  end

  always @(posedge clk_out4 or negedge adapter_bmbCCDomain_axi4StreamToBmb_workClockArea_ddr3AxisTxIf_toplevel_rstN_synchronized) begin
    if(!adapter_bmbCCDomain_axi4StreamToBmb_workClockArea_ddr3AxisTxIf_toplevel_rstN_synchronized) begin
      popCC_popPtr <= 10'h0;
      popCC_addressGen_rValid <= 1'b0;
      popCC_ptrToPush <= 10'h0;
      popCC_ptrToOccupancy <= 10'h0;
    end else begin
      if(popCC_addressGen_fire) begin
        popCC_popPtr <= popCC_popPtrPlus;
      end
      if(popCC_addressGen_ready) begin
        popCC_addressGen_rValid <= popCC_addressGen_valid;
      end
      if(popCC_readArbitation_fire) begin
        popCC_ptrToPush <= popCC_popPtrGray;
      end
      if(popCC_readArbitation_fire) begin
        popCC_ptrToOccupancy <= popCC_popPtr;
      end
    end
  end

  always @(posedge clk_out4) begin
    if(popCC_addressGen_ready) begin
      popCC_addressGen_rData <= popCC_addressGen_payload;
    end
  end


endmodule
