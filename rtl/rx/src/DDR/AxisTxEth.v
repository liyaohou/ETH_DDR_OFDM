// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : AxisTxEth
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module AxisTxEth (
  output reg           io_txCtrl_valid,
  input  wire          io_txCtrl_ready,
  input  wire          io_axiIn_valid,
  output wire          io_axiIn_ready,
  input  wire [7:0]    io_axiIn_payload_data,
  input  wire          io_axiIn_payload_last,
  input  wire [0:0]    io_axiIn_payload_user,
  output wire          io_axiOut_valid,
  input  wire          io_axiOut_ready,
  output wire [7:0]    io_axiOut_payload_data,
  output wire          io_axiOut_payload_last,
  output wire [0:0]    io_axiOut_payload_user,
  input  wire          io_start,
  input  wire          io_rxEnd,
  output reg           io_txEnd,
  input  wire          clk_out1,
  input  wire          rstN
);
  localparam fsm_enumDef_3_BOOT = 3'd0;
  localparam fsm_enumDef_3_idle = 3'd1;
  localparam fsm_enumDef_3_need = 3'd2;
  localparam fsm_enumDef_3_rxd = 3'd3;
  localparam fsm_enumDef_3_txd = 3'd4;
  localparam fsm_enumDef_3_end_1 = 3'd5;

  wire       [0:0]    fifo_io_push_payload_user;
  wire                fifo_io_pop_ready;
  wire                fifo_io_push_ready;
  wire                fifo_io_pop_valid;
  wire       [7:0]    fifo_io_pop_payload_data;
  wire                fifo_io_pop_payload_last;
  wire       [0:0]    fifo_io_pop_payload_user;
  wire       [11:0]   fifo_io_occupancy;
  wire       [11:0]   fifo_io_availability;
  wire                fsm_wantExit;
  reg                 fsm_wantStart;
  wire                fsm_wantKill;
  wire                _zz_io_axiOut_valid;
  wire       [0:0]    _zz_io_axiOut_payload_user;
  reg        [2:0]    fsm_stateReg;
  reg        [2:0]    fsm_stateNext;
  reg                 io_start_regNext;
  wire                when_AxisTxEth_l29;
  wire                io_axiIn_fire;
  wire                when_AxisTxEth_l38;
  wire                when_AxisTxEth_l42;
  wire                fifo_io_pop_fire;
  wire                when_AxisTxEth_l45;
  wire                fsm_onExit_BOOT;
  wire                fsm_onExit_idle;
  wire                fsm_onExit_need;
  wire                fsm_onExit_rxd;
  wire                fsm_onExit_txd;
  wire                fsm_onExit_end_1;
  wire                fsm_onEntry_BOOT;
  wire                fsm_onEntry_idle;
  wire                fsm_onEntry_need;
  wire                fsm_onEntry_rxd;
  wire                fsm_onEntry_txd;
  wire                fsm_onEntry_end_1;
  `ifndef SYNTHESIS
  reg [39:0] fsm_stateReg_string;
  reg [39:0] fsm_stateNext_string;
  `endif


  StreamFifoLowLatency_7 fifo (
    .io_push_valid        (io_axiIn_valid               ), //i
    .io_push_ready        (fifo_io_push_ready           ), //o
    .io_push_payload_data (io_axiIn_payload_data[7:0]   ), //i
    .io_push_payload_last (io_axiIn_payload_last        ), //i
    .io_push_payload_user (fifo_io_push_payload_user    ), //i
    .io_pop_valid         (fifo_io_pop_valid            ), //o
    .io_pop_ready         (fifo_io_pop_ready            ), //i
    .io_pop_payload_data  (fifo_io_pop_payload_data[7:0]), //o
    .io_pop_payload_last  (fifo_io_pop_payload_last     ), //o
    .io_pop_payload_user  (fifo_io_pop_payload_user     ), //o
    .io_flush             (1'b0                         ), //i
    .io_occupancy         (fifo_io_occupancy[11:0]      ), //o
    .io_availability      (fifo_io_availability[11:0]   ), //o
    .clk_out1             (clk_out1                     ), //i
    .rstN                 (rstN                         )  //i
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(fsm_stateReg)
      fsm_enumDef_3_BOOT : fsm_stateReg_string = "BOOT ";
      fsm_enumDef_3_idle : fsm_stateReg_string = "idle ";
      fsm_enumDef_3_need : fsm_stateReg_string = "need ";
      fsm_enumDef_3_rxd : fsm_stateReg_string = "rxd  ";
      fsm_enumDef_3_txd : fsm_stateReg_string = "txd  ";
      fsm_enumDef_3_end_1 : fsm_stateReg_string = "end_1";
      default : fsm_stateReg_string = "?????";
    endcase
  end
  always @(*) begin
    case(fsm_stateNext)
      fsm_enumDef_3_BOOT : fsm_stateNext_string = "BOOT ";
      fsm_enumDef_3_idle : fsm_stateNext_string = "idle ";
      fsm_enumDef_3_need : fsm_stateNext_string = "need ";
      fsm_enumDef_3_rxd : fsm_stateNext_string = "rxd  ";
      fsm_enumDef_3_txd : fsm_stateNext_string = "txd  ";
      fsm_enumDef_3_end_1 : fsm_stateNext_string = "end_1";
      default : fsm_stateNext_string = "?????";
    endcase
  end
  `endif

  assign io_axiIn_ready = fifo_io_push_ready;
  assign fifo_io_push_payload_user[0 : 0] = io_axiIn_payload_user[0 : 0];
  assign fsm_wantExit = 1'b0;
  always @(*) begin
    fsm_wantStart = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_3_idle : begin
      end
      fsm_enumDef_3_need : begin
      end
      fsm_enumDef_3_rxd : begin
      end
      fsm_enumDef_3_txd : begin
      end
      fsm_enumDef_3_end_1 : begin
      end
      default : begin
        fsm_wantStart = 1'b1;
      end
    endcase
  end

  assign fsm_wantKill = 1'b0;
  assign _zz_io_axiOut_valid = (! (fsm_stateReg == fsm_enumDef_3_rxd));
  assign fifo_io_pop_ready = (io_axiOut_ready && _zz_io_axiOut_valid);
  assign _zz_io_axiOut_payload_user[0 : 0] = fifo_io_pop_payload_user[0 : 0];
  assign io_axiOut_valid = (fifo_io_pop_valid && _zz_io_axiOut_valid);
  assign io_axiOut_payload_data = fifo_io_pop_payload_data;
  assign io_axiOut_payload_last = fifo_io_pop_payload_last;
  assign io_axiOut_payload_user[0 : 0] = _zz_io_axiOut_payload_user[0 : 0];
  always @(*) begin
    io_txCtrl_valid = 1'b0;
    if(fsm_onEntry_need) begin
      io_txCtrl_valid = 1'b1;
    end
  end

  always @(*) begin
    io_txEnd = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_3_idle : begin
      end
      fsm_enumDef_3_need : begin
      end
      fsm_enumDef_3_rxd : begin
      end
      fsm_enumDef_3_txd : begin
      end
      fsm_enumDef_3_end_1 : begin
        if(when_AxisTxEth_l45) begin
          io_txEnd = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_stateNext = fsm_stateReg;
    case(fsm_stateReg)
      fsm_enumDef_3_idle : begin
        if(when_AxisTxEth_l29) begin
          fsm_stateNext = fsm_enumDef_3_need;
        end
      end
      fsm_enumDef_3_need : begin
        fsm_stateNext = fsm_enumDef_3_rxd;
      end
      fsm_enumDef_3_rxd : begin
        if(when_AxisTxEth_l38) begin
          fsm_stateNext = fsm_enumDef_3_txd;
        end
        if(io_rxEnd) begin
          fsm_stateNext = fsm_enumDef_3_end_1;
        end
      end
      fsm_enumDef_3_txd : begin
        if(when_AxisTxEth_l42) begin
          fsm_stateNext = fsm_enumDef_3_need;
        end
        if(io_rxEnd) begin
          fsm_stateNext = fsm_enumDef_3_end_1;
        end
      end
      fsm_enumDef_3_end_1 : begin
        if(when_AxisTxEth_l45) begin
          fsm_stateNext = fsm_enumDef_3_idle;
        end
      end
      default : begin
      end
    endcase
    if(fsm_wantStart) begin
      fsm_stateNext = fsm_enumDef_3_idle;
    end
    if(fsm_wantKill) begin
      fsm_stateNext = fsm_enumDef_3_BOOT;
    end
  end

  assign when_AxisTxEth_l29 = (io_start && (! io_start_regNext));
  assign io_axiIn_fire = (io_axiIn_valid && io_axiIn_ready);
  assign when_AxisTxEth_l38 = (io_axiIn_payload_last && io_axiIn_fire);
  assign when_AxisTxEth_l42 = (fifo_io_occupancy == 12'h0);
  assign fifo_io_pop_fire = (fifo_io_pop_valid && fifo_io_pop_ready);
  assign when_AxisTxEth_l45 = (fifo_io_pop_payload_last && fifo_io_pop_fire);
  assign fsm_onExit_BOOT = ((fsm_stateNext != fsm_enumDef_3_BOOT) && (fsm_stateReg == fsm_enumDef_3_BOOT));
  assign fsm_onExit_idle = ((fsm_stateNext != fsm_enumDef_3_idle) && (fsm_stateReg == fsm_enumDef_3_idle));
  assign fsm_onExit_need = ((fsm_stateNext != fsm_enumDef_3_need) && (fsm_stateReg == fsm_enumDef_3_need));
  assign fsm_onExit_rxd = ((fsm_stateNext != fsm_enumDef_3_rxd) && (fsm_stateReg == fsm_enumDef_3_rxd));
  assign fsm_onExit_txd = ((fsm_stateNext != fsm_enumDef_3_txd) && (fsm_stateReg == fsm_enumDef_3_txd));
  assign fsm_onExit_end_1 = ((fsm_stateNext != fsm_enumDef_3_end_1) && (fsm_stateReg == fsm_enumDef_3_end_1));
  assign fsm_onEntry_BOOT = ((fsm_stateNext == fsm_enumDef_3_BOOT) && (fsm_stateReg != fsm_enumDef_3_BOOT));
  assign fsm_onEntry_idle = ((fsm_stateNext == fsm_enumDef_3_idle) && (fsm_stateReg != fsm_enumDef_3_idle));
  assign fsm_onEntry_need = ((fsm_stateNext == fsm_enumDef_3_need) && (fsm_stateReg != fsm_enumDef_3_need));
  assign fsm_onEntry_rxd = ((fsm_stateNext == fsm_enumDef_3_rxd) && (fsm_stateReg != fsm_enumDef_3_rxd));
  assign fsm_onEntry_txd = ((fsm_stateNext == fsm_enumDef_3_txd) && (fsm_stateReg != fsm_enumDef_3_txd));
  assign fsm_onEntry_end_1 = ((fsm_stateNext == fsm_enumDef_3_end_1) && (fsm_stateReg != fsm_enumDef_3_end_1));
  always @(posedge clk_out1 or negedge rstN) begin
    if(!rstN) begin
      fsm_stateReg <= fsm_enumDef_3_BOOT;
    end else begin
      fsm_stateReg <= fsm_stateNext;
    end
  end

  always @(posedge clk_out1) begin
    io_start_regNext <= io_start;
  end


endmodule
