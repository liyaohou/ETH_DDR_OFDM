// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : AxisRxRateCtrl
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module AxisRxRateCtrl (
  input  wire          io_axiIn_valid,
  output wire          io_axiIn_ready,
  input  wire [7:0]    io_axiIn_payload_data,
  input  wire          io_axiIn_payload_last,
  input  wire [0:0]    io_axiIn_payload_user,
  output wire          io_signalOut_valid,
  input  wire          io_signalOut_ready,
  output wire [7:0]    io_signalOut_payload_axis_data,
  output wire          io_signalOut_payload_axis_last,
  output wire [0:0]    io_signalOut_payload_axis_user,
  output wire          io_signalOut_payload_lastPiece,
  output reg           io_rxEnd_valid,
  input  wire          io_rxEnd_ready,
  input  wire          clk_out1,
  input  wire          rstN
);
  localparam fsm_enumDef_BOOT = 3'd0;
  localparam fsm_enumDef_idle = 3'd1;
  localparam fsm_enumDef_rxd = 3'd2;
  localparam fsm_enumDef_txd = 3'd3;
  localparam fsm_enumDef_end_1 = 3'd4;

  wire                fifo_io_push_valid;
  wire       [0:0]    fifo_io_push_payload_user;
  wire                fifo_io_pop_ready;
  wire       [0:0]    io_axiIn_fifo_io_push_payload_user;
  wire                io_axiIn_fifo_io_pop_ready;
  wire                fifo_io_push_ready;
  wire                fifo_io_pop_valid;
  wire       [7:0]    fifo_io_pop_payload_data;
  wire                fifo_io_pop_payload_last;
  wire       [0:0]    fifo_io_pop_payload_user;
  wire       [9:0]    fifo_io_occupancy;
  wire       [9:0]    fifo_io_availability;
  wire                io_axiIn_fifo_io_push_ready;
  wire                io_axiIn_fifo_io_pop_valid;
  wire       [7:0]    io_axiIn_fifo_io_pop_payload_data;
  wire                io_axiIn_fifo_io_pop_payload_last;
  wire       [0:0]    io_axiIn_fifo_io_pop_payload_user;
  wire       [10:0]   io_axiIn_fifo_io_occupancy;
  wire       [10:0]   io_axiIn_fifo_io_availability;
  wire                axiOut_valid;
  wire                axiOut_ready;
  wire       [7:0]    axiOut_payload_data;
  reg                 axiOut_payload_last;
  wire       [0:0]    axiOut_payload_user;
  wire                fsm_wantExit;
  reg                 fsm_wantStart;
  wire                fsm_wantKill;
  wire                _zz_io_push_valid;
  wire       [0:0]    _zz_io_push_payload_user;
  wire                _zz_axiOut_valid;
  reg        [2:0]    fsm_stateReg;
  reg        [2:0]    fsm_stateNext;
  wire                io_axiIn_isStall;
  reg                 io_axiIn_isStall_regNext;
  wire                io_axiIn_isNew;
  wire                when_AxisRxRateCtrl_l37;
  wire                when_AxisRxRateCtrl_l44;
  wire                when_AxisRxRateCtrl_l52;
  wire                fsm_onExit_BOOT;
  wire                fsm_onExit_idle;
  wire                fsm_onExit_rxd;
  wire                fsm_onExit_txd;
  wire                fsm_onExit_end_1;
  wire                fsm_onEntry_BOOT;
  wire                fsm_onEntry_idle;
  wire                fsm_onEntry_rxd;
  wire                fsm_onEntry_txd;
  wire                fsm_onEntry_end_1;
  `ifndef SYNTHESIS
  reg [39:0] fsm_stateReg_string;
  reg [39:0] fsm_stateNext_string;
  `endif


  StreamFifoLowLatency fifo (
    .io_push_valid        (fifo_io_push_valid                    ), //i
    .io_push_ready        (fifo_io_push_ready                    ), //o
    .io_push_payload_data (io_axiIn_fifo_io_pop_payload_data[7:0]), //i
    .io_push_payload_last (io_axiIn_fifo_io_pop_payload_last     ), //i
    .io_push_payload_user (fifo_io_push_payload_user             ), //i
    .io_pop_valid         (fifo_io_pop_valid                     ), //o
    .io_pop_ready         (fifo_io_pop_ready                     ), //i
    .io_pop_payload_data  (fifo_io_pop_payload_data[7:0]         ), //o
    .io_pop_payload_last  (fifo_io_pop_payload_last              ), //o
    .io_pop_payload_user  (fifo_io_pop_payload_user              ), //o
    .io_flush             (1'b0                                  ), //i
    .io_occupancy         (fifo_io_occupancy[9:0]                ), //o
    .io_availability      (fifo_io_availability[9:0]             ), //o
    .clk_out1             (clk_out1                              ), //i
    .rstN                 (rstN                                  )  //i
  );
  StreamFifoLowLatency_1 io_axiIn_fifo (
    .io_push_valid        (io_axiIn_valid                        ), //i
    .io_push_ready        (io_axiIn_fifo_io_push_ready           ), //o
    .io_push_payload_data (io_axiIn_payload_data[7:0]            ), //i
    .io_push_payload_last (io_axiIn_payload_last                 ), //i
    .io_push_payload_user (io_axiIn_fifo_io_push_payload_user    ), //i
    .io_pop_valid         (io_axiIn_fifo_io_pop_valid            ), //o
    .io_pop_ready         (io_axiIn_fifo_io_pop_ready            ), //i
    .io_pop_payload_data  (io_axiIn_fifo_io_pop_payload_data[7:0]), //o
    .io_pop_payload_last  (io_axiIn_fifo_io_pop_payload_last     ), //o
    .io_pop_payload_user  (io_axiIn_fifo_io_pop_payload_user     ), //o
    .io_flush             (1'b0                                  ), //i
    .io_occupancy         (io_axiIn_fifo_io_occupancy[10:0]      ), //o
    .io_availability      (io_axiIn_fifo_io_availability[10:0]   ), //o
    .clk_out1             (clk_out1                              ), //i
    .rstN                 (rstN                                  )  //i
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(fsm_stateReg)
      fsm_enumDef_BOOT : fsm_stateReg_string = "BOOT ";
      fsm_enumDef_idle : fsm_stateReg_string = "idle ";
      fsm_enumDef_rxd : fsm_stateReg_string = "rxd  ";
      fsm_enumDef_txd : fsm_stateReg_string = "txd  ";
      fsm_enumDef_end_1 : fsm_stateReg_string = "end_1";
      default : fsm_stateReg_string = "?????";
    endcase
  end
  always @(*) begin
    case(fsm_stateNext)
      fsm_enumDef_BOOT : fsm_stateNext_string = "BOOT ";
      fsm_enumDef_idle : fsm_stateNext_string = "idle ";
      fsm_enumDef_rxd : fsm_stateNext_string = "rxd  ";
      fsm_enumDef_txd : fsm_stateNext_string = "txd  ";
      fsm_enumDef_end_1 : fsm_stateNext_string = "end_1";
      default : fsm_stateNext_string = "?????";
    endcase
  end
  `endif

  always @(*) begin
    io_rxEnd_valid = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_idle : begin
      end
      fsm_enumDef_rxd : begin
      end
      fsm_enumDef_txd : begin
      end
      fsm_enumDef_end_1 : begin
        if(when_AxisRxRateCtrl_l52) begin
          io_rxEnd_valid = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign io_signalOut_valid = axiOut_valid;
  assign axiOut_ready = io_signalOut_ready;
  assign io_signalOut_payload_axis_data = axiOut_payload_data;
  assign io_signalOut_payload_axis_last = axiOut_payload_last;
  assign io_signalOut_payload_axis_user[0 : 0] = axiOut_payload_user[0 : 0];
  assign io_signalOut_payload_lastPiece = io_rxEnd_valid;
  assign fsm_wantExit = 1'b0;
  always @(*) begin
    fsm_wantStart = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_idle : begin
      end
      fsm_enumDef_rxd : begin
      end
      fsm_enumDef_txd : begin
      end
      fsm_enumDef_end_1 : begin
      end
      default : begin
        fsm_wantStart = 1'b1;
      end
    endcase
  end

  assign fsm_wantKill = 1'b0;
  assign io_axiIn_ready = io_axiIn_fifo_io_push_ready;
  assign io_axiIn_fifo_io_push_payload_user[0 : 0] = io_axiIn_payload_user[0 : 0];
  assign _zz_io_push_valid = (! (! ((fsm_stateReg == fsm_enumDef_rxd) || (fsm_stateReg == fsm_enumDef_end_1))));
  assign io_axiIn_fifo_io_pop_ready = (fifo_io_push_ready && _zz_io_push_valid);
  assign _zz_io_push_payload_user[0 : 0] = io_axiIn_fifo_io_pop_payload_user[0 : 0];
  assign fifo_io_push_valid = (io_axiIn_fifo_io_pop_valid && _zz_io_push_valid);
  assign fifo_io_push_payload_user[0 : 0] = _zz_io_push_payload_user[0 : 0];
  assign _zz_axiOut_valid = (! (fsm_stateReg == fsm_enumDef_rxd));
  assign fifo_io_pop_ready = (axiOut_ready && _zz_axiOut_valid);
  assign axiOut_valid = (fifo_io_pop_valid && _zz_axiOut_valid);
  assign axiOut_payload_user = 1'b0;
  assign axiOut_payload_data = fifo_io_pop_payload_data;
  always @(*) begin
    axiOut_payload_last = fifo_io_pop_payload_last;
    case(fsm_stateReg)
      fsm_enumDef_idle : begin
      end
      fsm_enumDef_rxd : begin
      end
      fsm_enumDef_txd : begin
        if(when_AxisRxRateCtrl_l44) begin
          axiOut_payload_last = 1'b1;
        end
      end
      fsm_enumDef_end_1 : begin
        if(when_AxisRxRateCtrl_l52) begin
          axiOut_payload_last = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_stateNext = fsm_stateReg;
    case(fsm_stateReg)
      fsm_enumDef_idle : begin
        if(io_axiIn_isNew) begin
          fsm_stateNext = fsm_enumDef_rxd;
        end
      end
      fsm_enumDef_rxd : begin
        if(when_AxisRxRateCtrl_l37) begin
          fsm_stateNext = fsm_enumDef_txd;
        end
        if(io_rxEnd_ready) begin
          fsm_stateNext = fsm_enumDef_end_1;
        end
      end
      fsm_enumDef_txd : begin
        if(when_AxisRxRateCtrl_l44) begin
          fsm_stateNext = fsm_enumDef_rxd;
        end else begin
          if(io_rxEnd_ready) begin
            fsm_stateNext = fsm_enumDef_end_1;
          end
        end
      end
      fsm_enumDef_end_1 : begin
        if(when_AxisRxRateCtrl_l52) begin
          fsm_stateNext = fsm_enumDef_idle;
        end
      end
      default : begin
      end
    endcase
    if(fsm_wantStart) begin
      fsm_stateNext = fsm_enumDef_idle;
    end
    if(fsm_wantKill) begin
      fsm_stateNext = fsm_enumDef_BOOT;
    end
  end

  assign io_axiIn_isStall = (io_axiIn_valid && (! io_axiIn_ready));
  assign io_axiIn_isNew = (io_axiIn_valid && (! io_axiIn_isStall_regNext));
  assign when_AxisRxRateCtrl_l37 = (10'h21c <= fifo_io_occupancy);
  assign when_AxisRxRateCtrl_l44 = (fifo_io_occupancy == 10'h001);
  assign when_AxisRxRateCtrl_l52 = (fifo_io_occupancy == 10'h001);
  assign fsm_onExit_BOOT = ((fsm_stateNext != fsm_enumDef_BOOT) && (fsm_stateReg == fsm_enumDef_BOOT));
  assign fsm_onExit_idle = ((fsm_stateNext != fsm_enumDef_idle) && (fsm_stateReg == fsm_enumDef_idle));
  assign fsm_onExit_rxd = ((fsm_stateNext != fsm_enumDef_rxd) && (fsm_stateReg == fsm_enumDef_rxd));
  assign fsm_onExit_txd = ((fsm_stateNext != fsm_enumDef_txd) && (fsm_stateReg == fsm_enumDef_txd));
  assign fsm_onExit_end_1 = ((fsm_stateNext != fsm_enumDef_end_1) && (fsm_stateReg == fsm_enumDef_end_1));
  assign fsm_onEntry_BOOT = ((fsm_stateNext == fsm_enumDef_BOOT) && (fsm_stateReg != fsm_enumDef_BOOT));
  assign fsm_onEntry_idle = ((fsm_stateNext == fsm_enumDef_idle) && (fsm_stateReg != fsm_enumDef_idle));
  assign fsm_onEntry_rxd = ((fsm_stateNext == fsm_enumDef_rxd) && (fsm_stateReg != fsm_enumDef_rxd));
  assign fsm_onEntry_txd = ((fsm_stateNext == fsm_enumDef_txd) && (fsm_stateReg != fsm_enumDef_txd));
  assign fsm_onEntry_end_1 = ((fsm_stateNext == fsm_enumDef_end_1) && (fsm_stateReg != fsm_enumDef_end_1));
  always @(posedge clk_out1 or negedge rstN) begin
    if(!rstN) begin
      fsm_stateReg <= fsm_enumDef_BOOT;
    end else begin
      fsm_stateReg <= fsm_stateNext;
    end
  end

  always @(posedge clk_out1 or negedge rstN) begin
    if(!rstN) begin
      io_axiIn_isStall_regNext <= 1'b0;
    end else begin
      io_axiIn_isStall_regNext <= io_axiIn_isStall;
    end
  end


endmodule
