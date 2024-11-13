// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : HarMatch
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module HarMatch (
  output reg           io_hdr_valid,
  input  wire          io_hdr_ready,
  input  wire          io_signalIn_valid,
  output wire          io_signalIn_ready,
  input  wire [7:0]    io_signalIn_payload_axis_data,
  input  wire          io_signalIn_payload_axis_last,
  input  wire [0:0]    io_signalIn_payload_axis_user,
  input  wire          io_signalIn_payload_lastPiece,
  output reg           io_signalOut_valid,
  input  wire          io_signalOut_ready,
  output reg  [7:0]    io_signalOut_payload_axis_data,
  output reg           io_signalOut_payload_axis_last,
  output reg  [0:0]    io_signalOut_payload_axis_user,
  output reg           io_signalOut_payload_lastPiece,
  input  wire          clk_out1,
  input  wire          rstN
);
  localparam fsm_enumDef_1_BOOT = 2'd0;
  localparam fsm_enumDef_1_idle = 2'd1;
  localparam fsm_enumDef_1_head = 2'd2;
  localparam fsm_enumDef_1_main = 2'd3;

  wire       [0:0]    io_signalIn_fifo_io_push_payload_axis_user;
  wire                io_signalIn_fifo_io_push_ready;
  wire                io_signalIn_fifo_io_pop_valid;
  wire       [7:0]    io_signalIn_fifo_io_pop_payload_axis_data;
  wire                io_signalIn_fifo_io_pop_payload_axis_last;
  wire       [0:0]    io_signalIn_fifo_io_pop_payload_axis_user;
  wire                io_signalIn_fifo_io_pop_payload_lastPiece;
  wire       [4:0]    io_signalIn_fifo_io_occupancy;
  wire       [4:0]    io_signalIn_fifo_io_availability;
  wire                fifo_valid;
  reg                 fifo_ready;
  wire       [7:0]    fifo_payload_axis_data;
  wire                fifo_payload_axis_last;
  wire       [0:0]    fifo_payload_axis_user;
  wire                fifo_payload_lastPiece;
  wire       [10:0]   _zz_io_signalOut_payload_lastPiece;
  wire       [9:0]    _zz_io_signalOut_payload_axis_data;
  wire                fsm_wantExit;
  reg                 fsm_wantStart;
  wire                fsm_wantKill;
  reg        [1:0]    fsm_stateReg;
  reg        [1:0]    fsm_stateNext;
  wire                io_signalOut_fire;
  wire                when_HarMatch_l28;
  wire                fsm_onExit_BOOT;
  wire                fsm_onExit_idle;
  wire                fsm_onExit_head;
  wire                fsm_onExit_main;
  wire                fsm_onEntry_BOOT;
  wire                fsm_onEntry_idle;
  wire                fsm_onEntry_head;
  wire                fsm_onEntry_main;
  `ifndef SYNTHESIS
  reg [31:0] fsm_stateReg_string;
  reg [31:0] fsm_stateNext_string;
  `endif


  StreamFifo_2 io_signalIn_fifo (
    .io_push_valid             (io_signalIn_valid                             ), //i
    .io_push_ready             (io_signalIn_fifo_io_push_ready                ), //o
    .io_push_payload_axis_data (io_signalIn_payload_axis_data[7:0]            ), //i
    .io_push_payload_axis_last (io_signalIn_payload_axis_last                 ), //i
    .io_push_payload_axis_user (io_signalIn_fifo_io_push_payload_axis_user    ), //i
    .io_push_payload_lastPiece (io_signalIn_payload_lastPiece                 ), //i
    .io_pop_valid              (io_signalIn_fifo_io_pop_valid                 ), //o
    .io_pop_ready              (fifo_ready                                    ), //i
    .io_pop_payload_axis_data  (io_signalIn_fifo_io_pop_payload_axis_data[7:0]), //o
    .io_pop_payload_axis_last  (io_signalIn_fifo_io_pop_payload_axis_last     ), //o
    .io_pop_payload_axis_user  (io_signalIn_fifo_io_pop_payload_axis_user     ), //o
    .io_pop_payload_lastPiece  (io_signalIn_fifo_io_pop_payload_lastPiece     ), //o
    .io_flush                  (1'b0                                          ), //i
    .io_occupancy              (io_signalIn_fifo_io_occupancy[4:0]            ), //o
    .io_availability           (io_signalIn_fifo_io_availability[4:0]         ), //o
    .clk_out1                  (clk_out1                                      ), //i
    .rstN                      (rstN                                          )  //i
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(fsm_stateReg)
      fsm_enumDef_1_BOOT : fsm_stateReg_string = "BOOT";
      fsm_enumDef_1_idle : fsm_stateReg_string = "idle";
      fsm_enumDef_1_head : fsm_stateReg_string = "head";
      fsm_enumDef_1_main : fsm_stateReg_string = "main";
      default : fsm_stateReg_string = "????";
    endcase
  end
  always @(*) begin
    case(fsm_stateNext)
      fsm_enumDef_1_BOOT : fsm_stateNext_string = "BOOT";
      fsm_enumDef_1_idle : fsm_stateNext_string = "idle";
      fsm_enumDef_1_head : fsm_stateNext_string = "head";
      fsm_enumDef_1_main : fsm_stateNext_string = "main";
      default : fsm_stateNext_string = "????";
    endcase
  end
  `endif

  assign io_signalIn_ready = io_signalIn_fifo_io_push_ready;
  assign io_signalIn_fifo_io_push_payload_axis_user[0 : 0] = io_signalIn_payload_axis_user[0 : 0];
  assign fifo_valid = io_signalIn_fifo_io_pop_valid;
  assign fifo_payload_axis_data = io_signalIn_fifo_io_pop_payload_axis_data;
  assign fifo_payload_axis_last = io_signalIn_fifo_io_pop_payload_axis_last;
  assign fifo_payload_axis_user[0 : 0] = io_signalIn_fifo_io_pop_payload_axis_user[0 : 0];
  assign fifo_payload_lastPiece = io_signalIn_fifo_io_pop_payload_lastPiece;
  always @(*) begin
    io_hdr_valid = 1'b0;
    if(fsm_onExit_head) begin
      io_hdr_valid = 1'b1;
    end
  end

  always @(*) begin
    io_signalOut_valid = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_1_idle : begin
      end
      fsm_enumDef_1_head : begin
      end
      fsm_enumDef_1_main : begin
        io_signalOut_valid = fifo_valid;
      end
      default : begin
      end
    endcase
  end

  assign _zz_io_signalOut_payload_lastPiece = 11'h0;
  assign _zz_io_signalOut_payload_axis_data = _zz_io_signalOut_payload_lastPiece[9 : 0];
  always @(*) begin
    io_signalOut_payload_axis_data = _zz_io_signalOut_payload_axis_data[7 : 0];
    case(fsm_stateReg)
      fsm_enumDef_1_idle : begin
      end
      fsm_enumDef_1_head : begin
      end
      fsm_enumDef_1_main : begin
        io_signalOut_payload_axis_data = fifo_payload_axis_data;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_signalOut_payload_axis_last = _zz_io_signalOut_payload_axis_data[8];
    case(fsm_stateReg)
      fsm_enumDef_1_idle : begin
      end
      fsm_enumDef_1_head : begin
      end
      fsm_enumDef_1_main : begin
        io_signalOut_payload_axis_last = fifo_payload_axis_last;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_signalOut_payload_axis_user = _zz_io_signalOut_payload_axis_data[9 : 9];
    case(fsm_stateReg)
      fsm_enumDef_1_idle : begin
      end
      fsm_enumDef_1_head : begin
      end
      fsm_enumDef_1_main : begin
        io_signalOut_payload_axis_user[0 : 0] = fifo_payload_axis_user[0 : 0];
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_signalOut_payload_lastPiece = _zz_io_signalOut_payload_lastPiece[10];
    case(fsm_stateReg)
      fsm_enumDef_1_idle : begin
      end
      fsm_enumDef_1_head : begin
      end
      fsm_enumDef_1_main : begin
        io_signalOut_payload_lastPiece = fifo_payload_lastPiece;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fifo_ready = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_1_idle : begin
      end
      fsm_enumDef_1_head : begin
      end
      fsm_enumDef_1_main : begin
        fifo_ready = io_signalOut_ready;
      end
      default : begin
      end
    endcase
  end

  assign fsm_wantExit = 1'b0;
  always @(*) begin
    fsm_wantStart = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_1_idle : begin
      end
      fsm_enumDef_1_head : begin
      end
      fsm_enumDef_1_main : begin
      end
      default : begin
        fsm_wantStart = 1'b1;
      end
    endcase
  end

  assign fsm_wantKill = 1'b0;
  always @(*) begin
    fsm_stateNext = fsm_stateReg;
    case(fsm_stateReg)
      fsm_enumDef_1_idle : begin
        if(fifo_valid) begin
          fsm_stateNext = fsm_enumDef_1_head;
        end
      end
      fsm_enumDef_1_head : begin
        if(io_hdr_ready) begin
          fsm_stateNext = fsm_enumDef_1_main;
        end
      end
      fsm_enumDef_1_main : begin
        if(when_HarMatch_l28) begin
          fsm_stateNext = fsm_enumDef_1_idle;
        end
      end
      default : begin
      end
    endcase
    if(fsm_wantStart) begin
      fsm_stateNext = fsm_enumDef_1_idle;
    end
    if(fsm_wantKill) begin
      fsm_stateNext = fsm_enumDef_1_BOOT;
    end
  end

  assign io_signalOut_fire = (io_signalOut_valid && io_signalOut_ready);
  assign when_HarMatch_l28 = (io_signalOut_fire && io_signalOut_payload_axis_last);
  assign fsm_onExit_BOOT = ((fsm_stateNext != fsm_enumDef_1_BOOT) && (fsm_stateReg == fsm_enumDef_1_BOOT));
  assign fsm_onExit_idle = ((fsm_stateNext != fsm_enumDef_1_idle) && (fsm_stateReg == fsm_enumDef_1_idle));
  assign fsm_onExit_head = ((fsm_stateNext != fsm_enumDef_1_head) && (fsm_stateReg == fsm_enumDef_1_head));
  assign fsm_onExit_main = ((fsm_stateNext != fsm_enumDef_1_main) && (fsm_stateReg == fsm_enumDef_1_main));
  assign fsm_onEntry_BOOT = ((fsm_stateNext == fsm_enumDef_1_BOOT) && (fsm_stateReg != fsm_enumDef_1_BOOT));
  assign fsm_onEntry_idle = ((fsm_stateNext == fsm_enumDef_1_idle) && (fsm_stateReg != fsm_enumDef_1_idle));
  assign fsm_onEntry_head = ((fsm_stateNext == fsm_enumDef_1_head) && (fsm_stateReg != fsm_enumDef_1_head));
  assign fsm_onEntry_main = ((fsm_stateNext == fsm_enumDef_1_main) && (fsm_stateReg != fsm_enumDef_1_main));
  always @(posedge clk_out1 or negedge rstN) begin
    if(!rstN) begin
      fsm_stateReg <= fsm_enumDef_1_BOOT;
    end else begin
      fsm_stateReg <= fsm_stateNext;
    end
  end


endmodule
