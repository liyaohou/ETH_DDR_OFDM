// Generator : SpinalHDL dev    git head : 102fc4034eb8f1ce3b4c7bcc2086e352bb227afd
// Component : MakeTask
// Git hash  : 53ca27853f395a62558e91c1f18cac97282d67b2

`timescale 1ns/1ps 
module MakeTask (
  input  wire          io_cmd_valid,
  output reg           io_cmd_ready,
  input  wire          io_cmd_payload_write,
  input  wire [28:0]   io_cmd_payload_address,
  input  wire [17:0]   io_cmd_payload_context,
  input  wire          io_cmd_payload_burstLast,
  input  wire [1:0]    io_cmd_payload_length,
  output wire          io_halt,
  input  wire          io_writeDataToken_valid,
  output reg           io_writeDataToken_ready,
  input  wire          io_writeDataToken_payload_valid,
  input  wire          io_writeDataToken_payload_ready,
  output wire          io_output_read,
  output wire          io_output_write,
  output wire          io_output_active,
  output wire          io_output_precharge,
  output wire          io_output_last,
  output wire [0:0]    io_output_address_byte,
  output wire [9:0]    io_output_address_column,
  output wire [2:0]    io_output_address_bank,
  output wire [14:0]   io_output_address_row,
  output wire [17:0]   io_output_context,
  output reg           io_output_prechargeAll,
  output reg           io_output_refresh,
  input  wire          clk_out4,
  input  wire          rstN
);
  localparam fsm_enumDef_2_BOOT = 3'd0;
  localparam fsm_enumDef_2_idle = 3'd1;
  localparam fsm_enumDef_2_prechargeAllCmd = 3'd2;
  localparam fsm_enumDef_2_refreshCmd = 3'd3;
  localparam fsm_enumDef_2_refreshReady = 3'd4;

  wire       [14:0]   banksRow_spinal_port0;
  wire                refresher_1_io_refresh_valid;
  wire       [1:0]    _zz_CCD_value;
  wire       [0:0]    _zz_CCD_value_1;
  wire       [7:0]    _zz_RFC_increment;
  wire       [3:0]    _zz_RFC_increment_1;
  wire       [7:0]    _zz_RFC_value;
  wire       [0:0]    _zz_RFC_value_1;
  wire       [4:0]    _zz_RRD_increment;
  wire       [2:0]    _zz_RRD_increment_1;
  wire       [4:0]    _zz_RRD_value;
  wire       [0:0]    _zz_RRD_value_1;
  wire       [4:0]    _zz_WTR_value;
  wire       [0:0]    _zz_WTR_value_1;
  wire       [4:0]    _zz_RTW_value;
  wire       [0:0]    _zz_RTW_value_1;
  wire       [4:0]    _zz_RP_increment;
  wire       [1:0]    _zz_RP_increment_1;
  wire       [4:0]    _zz_RP_value;
  wire       [0:0]    _zz_RP_value_1;
  wire       [4:0]    _zz_FAW_slots_0_increment;
  wire       [1:0]    _zz_FAW_slots_0_increment_1;
  wire       [4:0]    _zz_FAW_slots_0_value;
  wire       [0:0]    _zz_FAW_slots_0_value_1;
  wire       [4:0]    _zz_FAW_slots_1_increment;
  wire       [1:0]    _zz_FAW_slots_1_increment_1;
  wire       [4:0]    _zz_FAW_slots_1_value;
  wire       [0:0]    _zz_FAW_slots_1_value_1;
  wire       [4:0]    _zz_FAW_slots_2_increment;
  wire       [1:0]    _zz_FAW_slots_2_increment_1;
  wire       [4:0]    _zz_FAW_slots_2_value;
  wire       [0:0]    _zz_FAW_slots_2_value_1;
  wire       [4:0]    _zz_FAW_slots_3_increment;
  wire       [1:0]    _zz_FAW_slots_3_increment_1;
  wire       [4:0]    _zz_FAW_slots_3_value;
  wire       [0:0]    _zz_FAW_slots_3_value_1;
  reg                 _zz_FAW_busyNext;
  wire       [1:0]    _zz_FAW_busyNext_1;
  wire       [1:0]    _zz_FAW_ptr;
  wire       [0:0]    _zz_FAW_ptr_1;
  wire       [4:0]    _zz_banks_0_WR_increment;
  wire       [2:0]    _zz_banks_0_WR_increment_1;
  wire       [4:0]    _zz_banks_0_WR_value;
  wire       [0:0]    _zz_banks_0_WR_value_1;
  wire       [4:0]    _zz_banks_0_RAS_increment;
  wire       [1:0]    _zz_banks_0_RAS_increment_1;
  wire       [4:0]    _zz_banks_0_RAS_value;
  wire       [0:0]    _zz_banks_0_RAS_value_1;
  wire       [4:0]    _zz_banks_0_RP_increment;
  wire       [0:0]    _zz_banks_0_RP_increment_1;
  wire       [4:0]    _zz_banks_0_RP_value;
  wire       [0:0]    _zz_banks_0_RP_value_1;
  wire       [4:0]    _zz_banks_0_RCD_increment;
  wire       [0:0]    _zz_banks_0_RCD_increment_1;
  wire       [4:0]    _zz_banks_0_RCD_value;
  wire       [0:0]    _zz_banks_0_RCD_value_1;
  wire       [4:0]    _zz_banks_0_RTP_increment;
  wire       [2:0]    _zz_banks_0_RTP_increment_1;
  wire       [4:0]    _zz_banks_0_RTP_value;
  wire       [0:0]    _zz_banks_0_RTP_value_1;
  wire       [4:0]    _zz_banks_1_WR_increment;
  wire       [2:0]    _zz_banks_1_WR_increment_1;
  wire       [4:0]    _zz_banks_1_WR_value;
  wire       [0:0]    _zz_banks_1_WR_value_1;
  wire       [4:0]    _zz_banks_1_RAS_increment;
  wire       [1:0]    _zz_banks_1_RAS_increment_1;
  wire       [4:0]    _zz_banks_1_RAS_value;
  wire       [0:0]    _zz_banks_1_RAS_value_1;
  wire       [4:0]    _zz_banks_1_RP_increment;
  wire       [0:0]    _zz_banks_1_RP_increment_1;
  wire       [4:0]    _zz_banks_1_RP_value;
  wire       [0:0]    _zz_banks_1_RP_value_1;
  wire       [4:0]    _zz_banks_1_RCD_increment;
  wire       [0:0]    _zz_banks_1_RCD_increment_1;
  wire       [4:0]    _zz_banks_1_RCD_value;
  wire       [0:0]    _zz_banks_1_RCD_value_1;
  wire       [4:0]    _zz_banks_1_RTP_increment;
  wire       [2:0]    _zz_banks_1_RTP_increment_1;
  wire       [4:0]    _zz_banks_1_RTP_value;
  wire       [0:0]    _zz_banks_1_RTP_value_1;
  wire       [4:0]    _zz_banks_2_WR_increment;
  wire       [2:0]    _zz_banks_2_WR_increment_1;
  wire       [4:0]    _zz_banks_2_WR_value;
  wire       [0:0]    _zz_banks_2_WR_value_1;
  wire       [4:0]    _zz_banks_2_RAS_increment;
  wire       [1:0]    _zz_banks_2_RAS_increment_1;
  wire       [4:0]    _zz_banks_2_RAS_value;
  wire       [0:0]    _zz_banks_2_RAS_value_1;
  wire       [4:0]    _zz_banks_2_RP_increment;
  wire       [0:0]    _zz_banks_2_RP_increment_1;
  wire       [4:0]    _zz_banks_2_RP_value;
  wire       [0:0]    _zz_banks_2_RP_value_1;
  wire       [4:0]    _zz_banks_2_RCD_increment;
  wire       [0:0]    _zz_banks_2_RCD_increment_1;
  wire       [4:0]    _zz_banks_2_RCD_value;
  wire       [0:0]    _zz_banks_2_RCD_value_1;
  wire       [4:0]    _zz_banks_2_RTP_increment;
  wire       [2:0]    _zz_banks_2_RTP_increment_1;
  wire       [4:0]    _zz_banks_2_RTP_value;
  wire       [0:0]    _zz_banks_2_RTP_value_1;
  wire       [4:0]    _zz_banks_3_WR_increment;
  wire       [2:0]    _zz_banks_3_WR_increment_1;
  wire       [4:0]    _zz_banks_3_WR_value;
  wire       [0:0]    _zz_banks_3_WR_value_1;
  wire       [4:0]    _zz_banks_3_RAS_increment;
  wire       [1:0]    _zz_banks_3_RAS_increment_1;
  wire       [4:0]    _zz_banks_3_RAS_value;
  wire       [0:0]    _zz_banks_3_RAS_value_1;
  wire       [4:0]    _zz_banks_3_RP_increment;
  wire       [0:0]    _zz_banks_3_RP_increment_1;
  wire       [4:0]    _zz_banks_3_RP_value;
  wire       [0:0]    _zz_banks_3_RP_value_1;
  wire       [4:0]    _zz_banks_3_RCD_increment;
  wire       [0:0]    _zz_banks_3_RCD_increment_1;
  wire       [4:0]    _zz_banks_3_RCD_value;
  wire       [0:0]    _zz_banks_3_RCD_value_1;
  wire       [4:0]    _zz_banks_3_RTP_increment;
  wire       [2:0]    _zz_banks_3_RTP_increment_1;
  wire       [4:0]    _zz_banks_3_RTP_value;
  wire       [0:0]    _zz_banks_3_RTP_value_1;
  wire       [4:0]    _zz_banks_4_WR_increment;
  wire       [2:0]    _zz_banks_4_WR_increment_1;
  wire       [4:0]    _zz_banks_4_WR_value;
  wire       [0:0]    _zz_banks_4_WR_value_1;
  wire       [4:0]    _zz_banks_4_RAS_increment;
  wire       [1:0]    _zz_banks_4_RAS_increment_1;
  wire       [4:0]    _zz_banks_4_RAS_value;
  wire       [0:0]    _zz_banks_4_RAS_value_1;
  wire       [4:0]    _zz_banks_4_RP_increment;
  wire       [0:0]    _zz_banks_4_RP_increment_1;
  wire       [4:0]    _zz_banks_4_RP_value;
  wire       [0:0]    _zz_banks_4_RP_value_1;
  wire       [4:0]    _zz_banks_4_RCD_increment;
  wire       [0:0]    _zz_banks_4_RCD_increment_1;
  wire       [4:0]    _zz_banks_4_RCD_value;
  wire       [0:0]    _zz_banks_4_RCD_value_1;
  wire       [4:0]    _zz_banks_4_RTP_increment;
  wire       [2:0]    _zz_banks_4_RTP_increment_1;
  wire       [4:0]    _zz_banks_4_RTP_value;
  wire       [0:0]    _zz_banks_4_RTP_value_1;
  wire       [4:0]    _zz_banks_5_WR_increment;
  wire       [2:0]    _zz_banks_5_WR_increment_1;
  wire       [4:0]    _zz_banks_5_WR_value;
  wire       [0:0]    _zz_banks_5_WR_value_1;
  wire       [4:0]    _zz_banks_5_RAS_increment;
  wire       [1:0]    _zz_banks_5_RAS_increment_1;
  wire       [4:0]    _zz_banks_5_RAS_value;
  wire       [0:0]    _zz_banks_5_RAS_value_1;
  wire       [4:0]    _zz_banks_5_RP_increment;
  wire       [0:0]    _zz_banks_5_RP_increment_1;
  wire       [4:0]    _zz_banks_5_RP_value;
  wire       [0:0]    _zz_banks_5_RP_value_1;
  wire       [4:0]    _zz_banks_5_RCD_increment;
  wire       [0:0]    _zz_banks_5_RCD_increment_1;
  wire       [4:0]    _zz_banks_5_RCD_value;
  wire       [0:0]    _zz_banks_5_RCD_value_1;
  wire       [4:0]    _zz_banks_5_RTP_increment;
  wire       [2:0]    _zz_banks_5_RTP_increment_1;
  wire       [4:0]    _zz_banks_5_RTP_value;
  wire       [0:0]    _zz_banks_5_RTP_value_1;
  wire       [4:0]    _zz_banks_6_WR_increment;
  wire       [2:0]    _zz_banks_6_WR_increment_1;
  wire       [4:0]    _zz_banks_6_WR_value;
  wire       [0:0]    _zz_banks_6_WR_value_1;
  wire       [4:0]    _zz_banks_6_RAS_increment;
  wire       [1:0]    _zz_banks_6_RAS_increment_1;
  wire       [4:0]    _zz_banks_6_RAS_value;
  wire       [0:0]    _zz_banks_6_RAS_value_1;
  wire       [4:0]    _zz_banks_6_RP_increment;
  wire       [0:0]    _zz_banks_6_RP_increment_1;
  wire       [4:0]    _zz_banks_6_RP_value;
  wire       [0:0]    _zz_banks_6_RP_value_1;
  wire       [4:0]    _zz_banks_6_RCD_increment;
  wire       [0:0]    _zz_banks_6_RCD_increment_1;
  wire       [4:0]    _zz_banks_6_RCD_value;
  wire       [0:0]    _zz_banks_6_RCD_value_1;
  wire       [4:0]    _zz_banks_6_RTP_increment;
  wire       [2:0]    _zz_banks_6_RTP_increment_1;
  wire       [4:0]    _zz_banks_6_RTP_value;
  wire       [0:0]    _zz_banks_6_RTP_value_1;
  wire       [4:0]    _zz_banks_7_WR_increment;
  wire       [2:0]    _zz_banks_7_WR_increment_1;
  wire       [4:0]    _zz_banks_7_WR_value;
  wire       [0:0]    _zz_banks_7_WR_value_1;
  wire       [4:0]    _zz_banks_7_RAS_increment;
  wire       [1:0]    _zz_banks_7_RAS_increment_1;
  wire       [4:0]    _zz_banks_7_RAS_value;
  wire       [0:0]    _zz_banks_7_RAS_value_1;
  wire       [4:0]    _zz_banks_7_RP_increment;
  wire       [0:0]    _zz_banks_7_RP_increment_1;
  wire       [4:0]    _zz_banks_7_RP_value;
  wire       [0:0]    _zz_banks_7_RP_value_1;
  wire       [4:0]    _zz_banks_7_RCD_increment;
  wire       [0:0]    _zz_banks_7_RCD_increment_1;
  wire       [4:0]    _zz_banks_7_RCD_value;
  wire       [0:0]    _zz_banks_7_RCD_value_1;
  wire       [4:0]    _zz_banks_7_RTP_increment;
  wire       [2:0]    _zz_banks_7_RTP_increment_1;
  wire       [4:0]    _zz_banks_7_RTP_value;
  wire       [0:0]    _zz_banks_7_RTP_value_1;
  reg                 _zz_taskConstructor_status_bankActive;
  reg                 _zz_when_MakeTask_l227;
  reg                 _zz_when_MakeTask_l228;
  reg                 _zz_when_MakeTask_l229;
  reg                 _zz_when_MakeTask_l230;
  reg                 _zz_when_MakeTask_l227_1;
  reg                 _zz_when_MakeTask_l228_1;
  reg                 _zz_when_MakeTask_l229_1;
  reg                 _zz_when_MakeTask_l230_1;
  wire       [9:0]    _zz_io_output_address_column;
  wire       [4:0]    _zz_io_output_address_column_1;
  wire       [14:0]   _zz_banksRow_port;
  reg                 _zz_1;
  reg                 readyForRefresh;
  wire                when_MakeTask_l210;
  reg        [1:0]    CCD_value;
  wire                CCD_increment;
  wire                CCD_busy;
  reg        [7:0]    RFC_value;
  wire                RFC_increment;
  wire                RFC_busy;
  reg        [4:0]    RRD_value;
  wire                RRD_increment;
  wire                RRD_busy;
  reg        [4:0]    WTR_value;
  wire                WTR_increment;
  wire                WTR_busy;
  reg        [4:0]    RTW_value;
  wire                RTW_increment;
  wire                RTW_busy;
  reg        [4:0]    RP_value;
  wire                RP_increment;
  wire                RP_busy;
  reg        [1:0]    FAW_ptr;
  wire                when_MakeTask_l210_1;
  reg        [4:0]    FAW_slots_0_value;
  wire                FAW_slots_0_increment;
  wire                FAW_slots_0_busy;
  wire                when_MakeTask_l210_2;
  reg        [4:0]    FAW_slots_1_value;
  wire                FAW_slots_1_increment;
  wire                FAW_slots_1_busy;
  wire                when_MakeTask_l210_3;
  reg        [4:0]    FAW_slots_2_value;
  wire                FAW_slots_2_increment;
  wire                FAW_slots_2_busy;
  wire                when_MakeTask_l210_4;
  reg        [4:0]    FAW_slots_3_value;
  wire                FAW_slots_3_increment;
  wire                FAW_slots_3_busy;
  wire                FAW_busyNext;
  wire                banks_0_hits;
  reg                 banks_0_activeNext;
  reg                 banks_0_active;
  wire                when_MakeTask_l47;
  wire                when_MakeTask_l50;
  wire                when_MakeTask_l210_5;
  reg        [4:0]    banks_0_WR_value;
  wire                banks_0_WR_increment;
  wire                banks_0_WR_busy;
  wire                when_MakeTask_l210_6;
  reg        [4:0]    banks_0_RAS_value;
  wire                banks_0_RAS_increment;
  wire                banks_0_RAS_busy;
  wire                when_MakeTask_l210_7;
  reg        [4:0]    banks_0_RP_value;
  wire                banks_0_RP_increment;
  wire                banks_0_RP_busy;
  wire                when_MakeTask_l210_8;
  reg        [4:0]    banks_0_RCD_value;
  wire                banks_0_RCD_increment;
  wire                banks_0_RCD_busy;
  wire                when_MakeTask_l210_9;
  reg        [4:0]    banks_0_RTP_value;
  wire                banks_0_RTP_increment;
  wire                banks_0_RTP_busy;
  wire                banks_0_allowPrecharge;
  wire                banks_0_allowActive;
  wire                banks_0_allowWrite;
  wire                banks_0_allowRead;
  wire                banks_1_hits;
  reg                 banks_1_activeNext;
  reg                 banks_1_active;
  wire                when_MakeTask_l47_1;
  wire                when_MakeTask_l50_1;
  wire                when_MakeTask_l210_10;
  reg        [4:0]    banks_1_WR_value;
  wire                banks_1_WR_increment;
  wire                banks_1_WR_busy;
  wire                when_MakeTask_l210_11;
  reg        [4:0]    banks_1_RAS_value;
  wire                banks_1_RAS_increment;
  wire                banks_1_RAS_busy;
  wire                when_MakeTask_l210_12;
  reg        [4:0]    banks_1_RP_value;
  wire                banks_1_RP_increment;
  wire                banks_1_RP_busy;
  wire                when_MakeTask_l210_13;
  reg        [4:0]    banks_1_RCD_value;
  wire                banks_1_RCD_increment;
  wire                banks_1_RCD_busy;
  wire                when_MakeTask_l210_14;
  reg        [4:0]    banks_1_RTP_value;
  wire                banks_1_RTP_increment;
  wire                banks_1_RTP_busy;
  wire                banks_1_allowPrecharge;
  wire                banks_1_allowActive;
  wire                banks_1_allowWrite;
  wire                banks_1_allowRead;
  wire                banks_2_hits;
  reg                 banks_2_activeNext;
  reg                 banks_2_active;
  wire                when_MakeTask_l47_2;
  wire                when_MakeTask_l50_2;
  wire                when_MakeTask_l210_15;
  reg        [4:0]    banks_2_WR_value;
  wire                banks_2_WR_increment;
  wire                banks_2_WR_busy;
  wire                when_MakeTask_l210_16;
  reg        [4:0]    banks_2_RAS_value;
  wire                banks_2_RAS_increment;
  wire                banks_2_RAS_busy;
  wire                when_MakeTask_l210_17;
  reg        [4:0]    banks_2_RP_value;
  wire                banks_2_RP_increment;
  wire                banks_2_RP_busy;
  wire                when_MakeTask_l210_18;
  reg        [4:0]    banks_2_RCD_value;
  wire                banks_2_RCD_increment;
  wire                banks_2_RCD_busy;
  wire                when_MakeTask_l210_19;
  reg        [4:0]    banks_2_RTP_value;
  wire                banks_2_RTP_increment;
  wire                banks_2_RTP_busy;
  wire                banks_2_allowPrecharge;
  wire                banks_2_allowActive;
  wire                banks_2_allowWrite;
  wire                banks_2_allowRead;
  wire                banks_3_hits;
  reg                 banks_3_activeNext;
  reg                 banks_3_active;
  wire                when_MakeTask_l47_3;
  wire                when_MakeTask_l50_3;
  wire                when_MakeTask_l210_20;
  reg        [4:0]    banks_3_WR_value;
  wire                banks_3_WR_increment;
  wire                banks_3_WR_busy;
  wire                when_MakeTask_l210_21;
  reg        [4:0]    banks_3_RAS_value;
  wire                banks_3_RAS_increment;
  wire                banks_3_RAS_busy;
  wire                when_MakeTask_l210_22;
  reg        [4:0]    banks_3_RP_value;
  wire                banks_3_RP_increment;
  wire                banks_3_RP_busy;
  wire                when_MakeTask_l210_23;
  reg        [4:0]    banks_3_RCD_value;
  wire                banks_3_RCD_increment;
  wire                banks_3_RCD_busy;
  wire                when_MakeTask_l210_24;
  reg        [4:0]    banks_3_RTP_value;
  wire                banks_3_RTP_increment;
  wire                banks_3_RTP_busy;
  wire                banks_3_allowPrecharge;
  wire                banks_3_allowActive;
  wire                banks_3_allowWrite;
  wire                banks_3_allowRead;
  wire                banks_4_hits;
  reg                 banks_4_activeNext;
  reg                 banks_4_active;
  wire                when_MakeTask_l47_4;
  wire                when_MakeTask_l50_4;
  wire                when_MakeTask_l210_25;
  reg        [4:0]    banks_4_WR_value;
  wire                banks_4_WR_increment;
  wire                banks_4_WR_busy;
  wire                when_MakeTask_l210_26;
  reg        [4:0]    banks_4_RAS_value;
  wire                banks_4_RAS_increment;
  wire                banks_4_RAS_busy;
  wire                when_MakeTask_l210_27;
  reg        [4:0]    banks_4_RP_value;
  wire                banks_4_RP_increment;
  wire                banks_4_RP_busy;
  wire                when_MakeTask_l210_28;
  reg        [4:0]    banks_4_RCD_value;
  wire                banks_4_RCD_increment;
  wire                banks_4_RCD_busy;
  wire                when_MakeTask_l210_29;
  reg        [4:0]    banks_4_RTP_value;
  wire                banks_4_RTP_increment;
  wire                banks_4_RTP_busy;
  wire                banks_4_allowPrecharge;
  wire                banks_4_allowActive;
  wire                banks_4_allowWrite;
  wire                banks_4_allowRead;
  wire                banks_5_hits;
  reg                 banks_5_activeNext;
  reg                 banks_5_active;
  wire                when_MakeTask_l47_5;
  wire                when_MakeTask_l50_5;
  wire                when_MakeTask_l210_30;
  reg        [4:0]    banks_5_WR_value;
  wire                banks_5_WR_increment;
  wire                banks_5_WR_busy;
  wire                when_MakeTask_l210_31;
  reg        [4:0]    banks_5_RAS_value;
  wire                banks_5_RAS_increment;
  wire                banks_5_RAS_busy;
  wire                when_MakeTask_l210_32;
  reg        [4:0]    banks_5_RP_value;
  wire                banks_5_RP_increment;
  wire                banks_5_RP_busy;
  wire                when_MakeTask_l210_33;
  reg        [4:0]    banks_5_RCD_value;
  wire                banks_5_RCD_increment;
  wire                banks_5_RCD_busy;
  wire                when_MakeTask_l210_34;
  reg        [4:0]    banks_5_RTP_value;
  wire                banks_5_RTP_increment;
  wire                banks_5_RTP_busy;
  wire                banks_5_allowPrecharge;
  wire                banks_5_allowActive;
  wire                banks_5_allowWrite;
  wire                banks_5_allowRead;
  wire                banks_6_hits;
  reg                 banks_6_activeNext;
  reg                 banks_6_active;
  wire                when_MakeTask_l47_6;
  wire                when_MakeTask_l50_6;
  wire                when_MakeTask_l210_35;
  reg        [4:0]    banks_6_WR_value;
  wire                banks_6_WR_increment;
  wire                banks_6_WR_busy;
  wire                when_MakeTask_l210_36;
  reg        [4:0]    banks_6_RAS_value;
  wire                banks_6_RAS_increment;
  wire                banks_6_RAS_busy;
  wire                when_MakeTask_l210_37;
  reg        [4:0]    banks_6_RP_value;
  wire                banks_6_RP_increment;
  wire                banks_6_RP_busy;
  wire                when_MakeTask_l210_38;
  reg        [4:0]    banks_6_RCD_value;
  wire                banks_6_RCD_increment;
  wire                banks_6_RCD_busy;
  wire                when_MakeTask_l210_39;
  reg        [4:0]    banks_6_RTP_value;
  wire                banks_6_RTP_increment;
  wire                banks_6_RTP_busy;
  wire                banks_6_allowPrecharge;
  wire                banks_6_allowActive;
  wire                banks_6_allowWrite;
  wire                banks_6_allowRead;
  wire                banks_7_hits;
  reg                 banks_7_activeNext;
  reg                 banks_7_active;
  wire                when_MakeTask_l47_7;
  wire                when_MakeTask_l50_7;
  wire                when_MakeTask_l210_40;
  reg        [4:0]    banks_7_WR_value;
  wire                banks_7_WR_increment;
  wire                banks_7_WR_busy;
  wire                when_MakeTask_l210_41;
  reg        [4:0]    banks_7_RAS_value;
  wire                banks_7_RAS_increment;
  wire                banks_7_RAS_busy;
  wire                when_MakeTask_l210_42;
  reg        [4:0]    banks_7_RP_value;
  wire                banks_7_RP_increment;
  wire                banks_7_RP_busy;
  wire                when_MakeTask_l210_43;
  reg        [4:0]    banks_7_RCD_value;
  wire                banks_7_RCD_increment;
  wire                banks_7_RCD_busy;
  wire                when_MakeTask_l210_44;
  reg        [4:0]    banks_7_RTP_value;
  wire                banks_7_RTP_increment;
  wire                banks_7_RTP_busy;
  wire                banks_7_allowPrecharge;
  wire                banks_7_allowActive;
  wire                banks_7_allowWrite;
  wire                banks_7_allowRead;
  wire                allowPrechargeAll;
  wire                taskConstructor_input_valid;
  wire                taskConstructor_input_ready;
  wire                taskConstructor_input_payload_write;
  wire       [28:0]   taskConstructor_input_payload_address;
  wire       [17:0]   taskConstructor_input_payload_context;
  wire                taskConstructor_input_payload_burstLast;
  wire       [1:0]    taskConstructor_input_payload_length;
  reg                 io_cmd_rValid;
  reg                 io_cmd_rData_write;
  reg        [28:0]   io_cmd_rData_address;
  reg        [17:0]   io_cmd_rData_context;
  reg                 io_cmd_rData_burstLast;
  reg        [1:0]    io_cmd_rData_length;
  wire                when_Stream_l393;
  wire       [0:0]    taskConstructor_address_byte;
  wire       [9:0]    taskConstructor_address_column;
  wire       [2:0]    taskConstructor_address_bank;
  wire       [14:0]   taskConstructor_address_row;
  wire       [27:0]   taskConstructor_addrMapping_rbcAddress;
  reg                 taskConstructor_status_bankActive;
  reg                 taskConstructor_status_bankHit;
  reg                 taskConstructor_status_allowPrecharge;
  reg                 taskConstructor_status_allowActive;
  reg                 taskConstructor_status_allowWrite;
  reg                 taskConstructor_status_allowRead;
  wire                when_MakeTask_l227;
  wire                when_MakeTask_l228;
  wire                when_MakeTask_l229;
  wire                when_MakeTask_l230;
  wire                when_MakeTask_l232;
  wire                when_MakeTask_l243;
  reg                 station_valid;
  reg                 station_status_bankActive;
  reg                 station_status_bankHit;
  reg                 station_status_allowPrecharge;
  reg                 station_status_allowActive;
  reg                 station_status_allowWrite;
  reg                 station_status_allowRead;
  reg        [0:0]    station_address_byte;
  reg        [9:0]    station_address_column;
  reg        [2:0]    station_address_bank;
  reg        [14:0]   station_address_row;
  reg                 station_write;
  reg        [17:0]   station_context;
  reg        [1:0]    station_offset;
  reg        [1:0]    station_offsetLast;
  wire                when_MakeTask_l227_1;
  wire                when_MakeTask_l228_1;
  wire                when_MakeTask_l229_1;
  wire                when_MakeTask_l230_1;
  wire                when_MakeTask_l232_1;
  wire                when_MakeTask_l243_1;
  wire                when_MakeTask_l111;
  wire                station_inputActive;
  wire                station_inputPrecharge;
  wire                station_inputAccess;
  wire                station_inputWrite;
  wire                station_inputRead;
  wire                station_doActive;
  wire                station_doPrecharge;
  wire                station_doWrite;
  wire                station_doRead;
  wire                station_doAccess;
  wire                station_doSomething;
  wire                station_blockedByWriteToken;
  reg                 station_fire;
  wire                station_last;
  wire                when_MakeTask_l153;
  wire                refreshStream_valid;
  reg                 refreshStream_ready;
  wire       [1:0]    loader_offset;
  wire       [1:0]    loader_offsetLast;
  wire                loader_canSpawn;
  wire                when_MakeTask_l175;
  wire                askRefresh;
  wire                fsm_wantExit;
  reg                 fsm_wantStart;
  wire                fsm_wantKill;
  reg        [2:0]    fsm_stateReg;
  reg        [2:0]    fsm_stateNext;
  reg                 allowPrechargeAll_regNext;
  wire                when_MakeTask_l196;
  wire                when_MakeTask_l197;
  wire                when_MakeTask_l198;
  wire                fsm_onExit_BOOT;
  wire                fsm_onExit_idle;
  wire                fsm_onExit_prechargeAllCmd;
  wire                fsm_onExit_refreshCmd;
  wire                fsm_onExit_refreshReady;
  wire                fsm_onEntry_BOOT;
  wire                fsm_onEntry_idle;
  wire                fsm_onEntry_prechargeAllCmd;
  wire                fsm_onEntry_refreshCmd;
  wire                fsm_onEntry_refreshReady;
  `ifndef SYNTHESIS
  reg [119:0] fsm_stateReg_string;
  reg [119:0] fsm_stateNext_string;
  `endif

  (* ram_style = "distributed" *) reg [14:0] banksRow [0:7];

  assign _zz_CCD_value_1 = CCD_increment;
  assign _zz_CCD_value = {1'd0, _zz_CCD_value_1};
  assign _zz_RFC_increment_1 = 4'b1001;
  assign _zz_RFC_increment = {4'd0, _zz_RFC_increment_1};
  assign _zz_RFC_value_1 = RFC_increment;
  assign _zz_RFC_value = {7'd0, _zz_RFC_value_1};
  assign _zz_RRD_increment_1 = 3'b100;
  assign _zz_RRD_increment = {2'd0, _zz_RRD_increment_1};
  assign _zz_RRD_value_1 = RRD_increment;
  assign _zz_RRD_value = {4'd0, _zz_RRD_value_1};
  assign _zz_WTR_value_1 = WTR_increment;
  assign _zz_WTR_value = {4'd0, _zz_WTR_value_1};
  assign _zz_RTW_value_1 = RTW_increment;
  assign _zz_RTW_value = {4'd0, _zz_RTW_value_1};
  assign _zz_RP_increment_1 = 2'b10;
  assign _zz_RP_increment = {3'd0, _zz_RP_increment_1};
  assign _zz_RP_value_1 = RP_increment;
  assign _zz_RP_value = {4'd0, _zz_RP_value_1};
  assign _zz_FAW_slots_0_increment_1 = 2'b10;
  assign _zz_FAW_slots_0_increment = {3'd0, _zz_FAW_slots_0_increment_1};
  assign _zz_FAW_slots_0_value_1 = FAW_slots_0_increment;
  assign _zz_FAW_slots_0_value = {4'd0, _zz_FAW_slots_0_value_1};
  assign _zz_FAW_slots_1_increment_1 = 2'b10;
  assign _zz_FAW_slots_1_increment = {3'd0, _zz_FAW_slots_1_increment_1};
  assign _zz_FAW_slots_1_value_1 = FAW_slots_1_increment;
  assign _zz_FAW_slots_1_value = {4'd0, _zz_FAW_slots_1_value_1};
  assign _zz_FAW_slots_2_increment_1 = 2'b10;
  assign _zz_FAW_slots_2_increment = {3'd0, _zz_FAW_slots_2_increment_1};
  assign _zz_FAW_slots_2_value_1 = FAW_slots_2_increment;
  assign _zz_FAW_slots_2_value = {4'd0, _zz_FAW_slots_2_value_1};
  assign _zz_FAW_slots_3_increment_1 = 2'b10;
  assign _zz_FAW_slots_3_increment = {3'd0, _zz_FAW_slots_3_increment_1};
  assign _zz_FAW_slots_3_value_1 = FAW_slots_3_increment;
  assign _zz_FAW_slots_3_value = {4'd0, _zz_FAW_slots_3_value_1};
  assign _zz_FAW_busyNext_1 = (FAW_ptr + 2'b01);
  assign _zz_FAW_ptr_1 = io_output_active;
  assign _zz_FAW_ptr = {1'd0, _zz_FAW_ptr_1};
  assign _zz_banks_0_WR_increment_1 = 3'b110;
  assign _zz_banks_0_WR_increment = {2'd0, _zz_banks_0_WR_increment_1};
  assign _zz_banks_0_WR_value_1 = banks_0_WR_increment;
  assign _zz_banks_0_WR_value = {4'd0, _zz_banks_0_WR_value_1};
  assign _zz_banks_0_RAS_increment_1 = 2'b10;
  assign _zz_banks_0_RAS_increment = {3'd0, _zz_banks_0_RAS_increment_1};
  assign _zz_banks_0_RAS_value_1 = banks_0_RAS_increment;
  assign _zz_banks_0_RAS_value = {4'd0, _zz_banks_0_RAS_value_1};
  assign _zz_banks_0_RP_increment_1 = 1'b1;
  assign _zz_banks_0_RP_increment = {4'd0, _zz_banks_0_RP_increment_1};
  assign _zz_banks_0_RP_value_1 = banks_0_RP_increment;
  assign _zz_banks_0_RP_value = {4'd0, _zz_banks_0_RP_value_1};
  assign _zz_banks_0_RCD_increment_1 = 1'b1;
  assign _zz_banks_0_RCD_increment = {4'd0, _zz_banks_0_RCD_increment_1};
  assign _zz_banks_0_RCD_value_1 = banks_0_RCD_increment;
  assign _zz_banks_0_RCD_value = {4'd0, _zz_banks_0_RCD_value_1};
  assign _zz_banks_0_RTP_increment_1 = 3'b100;
  assign _zz_banks_0_RTP_increment = {2'd0, _zz_banks_0_RTP_increment_1};
  assign _zz_banks_0_RTP_value_1 = banks_0_RTP_increment;
  assign _zz_banks_0_RTP_value = {4'd0, _zz_banks_0_RTP_value_1};
  assign _zz_banks_1_WR_increment_1 = 3'b110;
  assign _zz_banks_1_WR_increment = {2'd0, _zz_banks_1_WR_increment_1};
  assign _zz_banks_1_WR_value_1 = banks_1_WR_increment;
  assign _zz_banks_1_WR_value = {4'd0, _zz_banks_1_WR_value_1};
  assign _zz_banks_1_RAS_increment_1 = 2'b10;
  assign _zz_banks_1_RAS_increment = {3'd0, _zz_banks_1_RAS_increment_1};
  assign _zz_banks_1_RAS_value_1 = banks_1_RAS_increment;
  assign _zz_banks_1_RAS_value = {4'd0, _zz_banks_1_RAS_value_1};
  assign _zz_banks_1_RP_increment_1 = 1'b1;
  assign _zz_banks_1_RP_increment = {4'd0, _zz_banks_1_RP_increment_1};
  assign _zz_banks_1_RP_value_1 = banks_1_RP_increment;
  assign _zz_banks_1_RP_value = {4'd0, _zz_banks_1_RP_value_1};
  assign _zz_banks_1_RCD_increment_1 = 1'b1;
  assign _zz_banks_1_RCD_increment = {4'd0, _zz_banks_1_RCD_increment_1};
  assign _zz_banks_1_RCD_value_1 = banks_1_RCD_increment;
  assign _zz_banks_1_RCD_value = {4'd0, _zz_banks_1_RCD_value_1};
  assign _zz_banks_1_RTP_increment_1 = 3'b100;
  assign _zz_banks_1_RTP_increment = {2'd0, _zz_banks_1_RTP_increment_1};
  assign _zz_banks_1_RTP_value_1 = banks_1_RTP_increment;
  assign _zz_banks_1_RTP_value = {4'd0, _zz_banks_1_RTP_value_1};
  assign _zz_banks_2_WR_increment_1 = 3'b110;
  assign _zz_banks_2_WR_increment = {2'd0, _zz_banks_2_WR_increment_1};
  assign _zz_banks_2_WR_value_1 = banks_2_WR_increment;
  assign _zz_banks_2_WR_value = {4'd0, _zz_banks_2_WR_value_1};
  assign _zz_banks_2_RAS_increment_1 = 2'b10;
  assign _zz_banks_2_RAS_increment = {3'd0, _zz_banks_2_RAS_increment_1};
  assign _zz_banks_2_RAS_value_1 = banks_2_RAS_increment;
  assign _zz_banks_2_RAS_value = {4'd0, _zz_banks_2_RAS_value_1};
  assign _zz_banks_2_RP_increment_1 = 1'b1;
  assign _zz_banks_2_RP_increment = {4'd0, _zz_banks_2_RP_increment_1};
  assign _zz_banks_2_RP_value_1 = banks_2_RP_increment;
  assign _zz_banks_2_RP_value = {4'd0, _zz_banks_2_RP_value_1};
  assign _zz_banks_2_RCD_increment_1 = 1'b1;
  assign _zz_banks_2_RCD_increment = {4'd0, _zz_banks_2_RCD_increment_1};
  assign _zz_banks_2_RCD_value_1 = banks_2_RCD_increment;
  assign _zz_banks_2_RCD_value = {4'd0, _zz_banks_2_RCD_value_1};
  assign _zz_banks_2_RTP_increment_1 = 3'b100;
  assign _zz_banks_2_RTP_increment = {2'd0, _zz_banks_2_RTP_increment_1};
  assign _zz_banks_2_RTP_value_1 = banks_2_RTP_increment;
  assign _zz_banks_2_RTP_value = {4'd0, _zz_banks_2_RTP_value_1};
  assign _zz_banks_3_WR_increment_1 = 3'b110;
  assign _zz_banks_3_WR_increment = {2'd0, _zz_banks_3_WR_increment_1};
  assign _zz_banks_3_WR_value_1 = banks_3_WR_increment;
  assign _zz_banks_3_WR_value = {4'd0, _zz_banks_3_WR_value_1};
  assign _zz_banks_3_RAS_increment_1 = 2'b10;
  assign _zz_banks_3_RAS_increment = {3'd0, _zz_banks_3_RAS_increment_1};
  assign _zz_banks_3_RAS_value_1 = banks_3_RAS_increment;
  assign _zz_banks_3_RAS_value = {4'd0, _zz_banks_3_RAS_value_1};
  assign _zz_banks_3_RP_increment_1 = 1'b1;
  assign _zz_banks_3_RP_increment = {4'd0, _zz_banks_3_RP_increment_1};
  assign _zz_banks_3_RP_value_1 = banks_3_RP_increment;
  assign _zz_banks_3_RP_value = {4'd0, _zz_banks_3_RP_value_1};
  assign _zz_banks_3_RCD_increment_1 = 1'b1;
  assign _zz_banks_3_RCD_increment = {4'd0, _zz_banks_3_RCD_increment_1};
  assign _zz_banks_3_RCD_value_1 = banks_3_RCD_increment;
  assign _zz_banks_3_RCD_value = {4'd0, _zz_banks_3_RCD_value_1};
  assign _zz_banks_3_RTP_increment_1 = 3'b100;
  assign _zz_banks_3_RTP_increment = {2'd0, _zz_banks_3_RTP_increment_1};
  assign _zz_banks_3_RTP_value_1 = banks_3_RTP_increment;
  assign _zz_banks_3_RTP_value = {4'd0, _zz_banks_3_RTP_value_1};
  assign _zz_banks_4_WR_increment_1 = 3'b110;
  assign _zz_banks_4_WR_increment = {2'd0, _zz_banks_4_WR_increment_1};
  assign _zz_banks_4_WR_value_1 = banks_4_WR_increment;
  assign _zz_banks_4_WR_value = {4'd0, _zz_banks_4_WR_value_1};
  assign _zz_banks_4_RAS_increment_1 = 2'b10;
  assign _zz_banks_4_RAS_increment = {3'd0, _zz_banks_4_RAS_increment_1};
  assign _zz_banks_4_RAS_value_1 = banks_4_RAS_increment;
  assign _zz_banks_4_RAS_value = {4'd0, _zz_banks_4_RAS_value_1};
  assign _zz_banks_4_RP_increment_1 = 1'b1;
  assign _zz_banks_4_RP_increment = {4'd0, _zz_banks_4_RP_increment_1};
  assign _zz_banks_4_RP_value_1 = banks_4_RP_increment;
  assign _zz_banks_4_RP_value = {4'd0, _zz_banks_4_RP_value_1};
  assign _zz_banks_4_RCD_increment_1 = 1'b1;
  assign _zz_banks_4_RCD_increment = {4'd0, _zz_banks_4_RCD_increment_1};
  assign _zz_banks_4_RCD_value_1 = banks_4_RCD_increment;
  assign _zz_banks_4_RCD_value = {4'd0, _zz_banks_4_RCD_value_1};
  assign _zz_banks_4_RTP_increment_1 = 3'b100;
  assign _zz_banks_4_RTP_increment = {2'd0, _zz_banks_4_RTP_increment_1};
  assign _zz_banks_4_RTP_value_1 = banks_4_RTP_increment;
  assign _zz_banks_4_RTP_value = {4'd0, _zz_banks_4_RTP_value_1};
  assign _zz_banks_5_WR_increment_1 = 3'b110;
  assign _zz_banks_5_WR_increment = {2'd0, _zz_banks_5_WR_increment_1};
  assign _zz_banks_5_WR_value_1 = banks_5_WR_increment;
  assign _zz_banks_5_WR_value = {4'd0, _zz_banks_5_WR_value_1};
  assign _zz_banks_5_RAS_increment_1 = 2'b10;
  assign _zz_banks_5_RAS_increment = {3'd0, _zz_banks_5_RAS_increment_1};
  assign _zz_banks_5_RAS_value_1 = banks_5_RAS_increment;
  assign _zz_banks_5_RAS_value = {4'd0, _zz_banks_5_RAS_value_1};
  assign _zz_banks_5_RP_increment_1 = 1'b1;
  assign _zz_banks_5_RP_increment = {4'd0, _zz_banks_5_RP_increment_1};
  assign _zz_banks_5_RP_value_1 = banks_5_RP_increment;
  assign _zz_banks_5_RP_value = {4'd0, _zz_banks_5_RP_value_1};
  assign _zz_banks_5_RCD_increment_1 = 1'b1;
  assign _zz_banks_5_RCD_increment = {4'd0, _zz_banks_5_RCD_increment_1};
  assign _zz_banks_5_RCD_value_1 = banks_5_RCD_increment;
  assign _zz_banks_5_RCD_value = {4'd0, _zz_banks_5_RCD_value_1};
  assign _zz_banks_5_RTP_increment_1 = 3'b100;
  assign _zz_banks_5_RTP_increment = {2'd0, _zz_banks_5_RTP_increment_1};
  assign _zz_banks_5_RTP_value_1 = banks_5_RTP_increment;
  assign _zz_banks_5_RTP_value = {4'd0, _zz_banks_5_RTP_value_1};
  assign _zz_banks_6_WR_increment_1 = 3'b110;
  assign _zz_banks_6_WR_increment = {2'd0, _zz_banks_6_WR_increment_1};
  assign _zz_banks_6_WR_value_1 = banks_6_WR_increment;
  assign _zz_banks_6_WR_value = {4'd0, _zz_banks_6_WR_value_1};
  assign _zz_banks_6_RAS_increment_1 = 2'b10;
  assign _zz_banks_6_RAS_increment = {3'd0, _zz_banks_6_RAS_increment_1};
  assign _zz_banks_6_RAS_value_1 = banks_6_RAS_increment;
  assign _zz_banks_6_RAS_value = {4'd0, _zz_banks_6_RAS_value_1};
  assign _zz_banks_6_RP_increment_1 = 1'b1;
  assign _zz_banks_6_RP_increment = {4'd0, _zz_banks_6_RP_increment_1};
  assign _zz_banks_6_RP_value_1 = banks_6_RP_increment;
  assign _zz_banks_6_RP_value = {4'd0, _zz_banks_6_RP_value_1};
  assign _zz_banks_6_RCD_increment_1 = 1'b1;
  assign _zz_banks_6_RCD_increment = {4'd0, _zz_banks_6_RCD_increment_1};
  assign _zz_banks_6_RCD_value_1 = banks_6_RCD_increment;
  assign _zz_banks_6_RCD_value = {4'd0, _zz_banks_6_RCD_value_1};
  assign _zz_banks_6_RTP_increment_1 = 3'b100;
  assign _zz_banks_6_RTP_increment = {2'd0, _zz_banks_6_RTP_increment_1};
  assign _zz_banks_6_RTP_value_1 = banks_6_RTP_increment;
  assign _zz_banks_6_RTP_value = {4'd0, _zz_banks_6_RTP_value_1};
  assign _zz_banks_7_WR_increment_1 = 3'b110;
  assign _zz_banks_7_WR_increment = {2'd0, _zz_banks_7_WR_increment_1};
  assign _zz_banks_7_WR_value_1 = banks_7_WR_increment;
  assign _zz_banks_7_WR_value = {4'd0, _zz_banks_7_WR_value_1};
  assign _zz_banks_7_RAS_increment_1 = 2'b10;
  assign _zz_banks_7_RAS_increment = {3'd0, _zz_banks_7_RAS_increment_1};
  assign _zz_banks_7_RAS_value_1 = banks_7_RAS_increment;
  assign _zz_banks_7_RAS_value = {4'd0, _zz_banks_7_RAS_value_1};
  assign _zz_banks_7_RP_increment_1 = 1'b1;
  assign _zz_banks_7_RP_increment = {4'd0, _zz_banks_7_RP_increment_1};
  assign _zz_banks_7_RP_value_1 = banks_7_RP_increment;
  assign _zz_banks_7_RP_value = {4'd0, _zz_banks_7_RP_value_1};
  assign _zz_banks_7_RCD_increment_1 = 1'b1;
  assign _zz_banks_7_RCD_increment = {4'd0, _zz_banks_7_RCD_increment_1};
  assign _zz_banks_7_RCD_value_1 = banks_7_RCD_increment;
  assign _zz_banks_7_RCD_value = {4'd0, _zz_banks_7_RCD_value_1};
  assign _zz_banks_7_RTP_increment_1 = 3'b100;
  assign _zz_banks_7_RTP_increment = {2'd0, _zz_banks_7_RTP_increment_1};
  assign _zz_banks_7_RTP_value_1 = banks_7_RTP_increment;
  assign _zz_banks_7_RTP_value = {4'd0, _zz_banks_7_RTP_value_1};
  assign _zz_io_output_address_column_1 = ({3'd0,station_offset} <<< 2'd3);
  assign _zz_io_output_address_column = {5'd0, _zz_io_output_address_column_1};
  assign _zz_banksRow_port = io_output_address_row;
  assign banksRow_spinal_port0 = banksRow[taskConstructor_address_bank];
  always @(posedge clk_out4) begin
    if(_zz_1) begin
      banksRow[io_output_address_bank] <= _zz_banksRow_port;
    end
  end

  Refresher refresher_1 (
    .io_refresh_valid (refresher_1_io_refresh_valid), //o
    .io_refresh_ready (refreshStream_ready         ), //i
    .clk_out4         (clk_out4                    ), //i
    .rstN             (rstN                        )  //i
  );
  initial begin
  `ifndef SYNTHESIS
    CCD_value = {$urandom};
    RFC_value = {$urandom};
    RRD_value = {$urandom};
    WTR_value = {$urandom};
    RTW_value = {$urandom};
    RP_value = {$urandom};
    FAW_slots_0_value = {$urandom};
    FAW_slots_1_value = {$urandom};
    FAW_slots_2_value = {$urandom};
    FAW_slots_3_value = {$urandom};
    banks_0_WR_value = {$urandom};
    banks_0_RAS_value = {$urandom};
    banks_0_RP_value = {$urandom};
    banks_0_RCD_value = {$urandom};
    banks_0_RTP_value = {$urandom};
    banks_1_WR_value = {$urandom};
    banks_1_RAS_value = {$urandom};
    banks_1_RP_value = {$urandom};
    banks_1_RCD_value = {$urandom};
    banks_1_RTP_value = {$urandom};
    banks_2_WR_value = {$urandom};
    banks_2_RAS_value = {$urandom};
    banks_2_RP_value = {$urandom};
    banks_2_RCD_value = {$urandom};
    banks_2_RTP_value = {$urandom};
    banks_3_WR_value = {$urandom};
    banks_3_RAS_value = {$urandom};
    banks_3_RP_value = {$urandom};
    banks_3_RCD_value = {$urandom};
    banks_3_RTP_value = {$urandom};
    banks_4_WR_value = {$urandom};
    banks_4_RAS_value = {$urandom};
    banks_4_RP_value = {$urandom};
    banks_4_RCD_value = {$urandom};
    banks_4_RTP_value = {$urandom};
    banks_5_WR_value = {$urandom};
    banks_5_RAS_value = {$urandom};
    banks_5_RP_value = {$urandom};
    banks_5_RCD_value = {$urandom};
    banks_5_RTP_value = {$urandom};
    banks_6_WR_value = {$urandom};
    banks_6_RAS_value = {$urandom};
    banks_6_RP_value = {$urandom};
    banks_6_RCD_value = {$urandom};
    banks_6_RTP_value = {$urandom};
    banks_7_WR_value = {$urandom};
    banks_7_RAS_value = {$urandom};
    banks_7_RP_value = {$urandom};
    banks_7_RCD_value = {$urandom};
    banks_7_RTP_value = {$urandom};
  `endif
  end

  always @(*) begin
    case(_zz_FAW_busyNext_1)
      2'b00 : _zz_FAW_busyNext = FAW_slots_0_busy;
      2'b01 : _zz_FAW_busyNext = FAW_slots_1_busy;
      2'b10 : _zz_FAW_busyNext = FAW_slots_2_busy;
      default : _zz_FAW_busyNext = FAW_slots_3_busy;
    endcase
  end

  always @(*) begin
    case(taskConstructor_address_bank)
      3'b000 : begin
        _zz_taskConstructor_status_bankActive = banks_0_active;
        _zz_when_MakeTask_l227 = banks_0_allowPrecharge;
        _zz_when_MakeTask_l228 = banks_0_allowActive;
        _zz_when_MakeTask_l229 = banks_0_allowWrite;
        _zz_when_MakeTask_l230 = banks_0_allowRead;
      end
      3'b001 : begin
        _zz_taskConstructor_status_bankActive = banks_1_active;
        _zz_when_MakeTask_l227 = banks_1_allowPrecharge;
        _zz_when_MakeTask_l228 = banks_1_allowActive;
        _zz_when_MakeTask_l229 = banks_1_allowWrite;
        _zz_when_MakeTask_l230 = banks_1_allowRead;
      end
      3'b010 : begin
        _zz_taskConstructor_status_bankActive = banks_2_active;
        _zz_when_MakeTask_l227 = banks_2_allowPrecharge;
        _zz_when_MakeTask_l228 = banks_2_allowActive;
        _zz_when_MakeTask_l229 = banks_2_allowWrite;
        _zz_when_MakeTask_l230 = banks_2_allowRead;
      end
      3'b011 : begin
        _zz_taskConstructor_status_bankActive = banks_3_active;
        _zz_when_MakeTask_l227 = banks_3_allowPrecharge;
        _zz_when_MakeTask_l228 = banks_3_allowActive;
        _zz_when_MakeTask_l229 = banks_3_allowWrite;
        _zz_when_MakeTask_l230 = banks_3_allowRead;
      end
      3'b100 : begin
        _zz_taskConstructor_status_bankActive = banks_4_active;
        _zz_when_MakeTask_l227 = banks_4_allowPrecharge;
        _zz_when_MakeTask_l228 = banks_4_allowActive;
        _zz_when_MakeTask_l229 = banks_4_allowWrite;
        _zz_when_MakeTask_l230 = banks_4_allowRead;
      end
      3'b101 : begin
        _zz_taskConstructor_status_bankActive = banks_5_active;
        _zz_when_MakeTask_l227 = banks_5_allowPrecharge;
        _zz_when_MakeTask_l228 = banks_5_allowActive;
        _zz_when_MakeTask_l229 = banks_5_allowWrite;
        _zz_when_MakeTask_l230 = banks_5_allowRead;
      end
      3'b110 : begin
        _zz_taskConstructor_status_bankActive = banks_6_active;
        _zz_when_MakeTask_l227 = banks_6_allowPrecharge;
        _zz_when_MakeTask_l228 = banks_6_allowActive;
        _zz_when_MakeTask_l229 = banks_6_allowWrite;
        _zz_when_MakeTask_l230 = banks_6_allowRead;
      end
      default : begin
        _zz_taskConstructor_status_bankActive = banks_7_active;
        _zz_when_MakeTask_l227 = banks_7_allowPrecharge;
        _zz_when_MakeTask_l228 = banks_7_allowActive;
        _zz_when_MakeTask_l229 = banks_7_allowWrite;
        _zz_when_MakeTask_l230 = banks_7_allowRead;
      end
    endcase
  end

  always @(*) begin
    case(station_address_bank)
      3'b000 : begin
        _zz_when_MakeTask_l227_1 = banks_0_allowPrecharge;
        _zz_when_MakeTask_l228_1 = banks_0_allowActive;
        _zz_when_MakeTask_l229_1 = banks_0_allowWrite;
        _zz_when_MakeTask_l230_1 = banks_0_allowRead;
      end
      3'b001 : begin
        _zz_when_MakeTask_l227_1 = banks_1_allowPrecharge;
        _zz_when_MakeTask_l228_1 = banks_1_allowActive;
        _zz_when_MakeTask_l229_1 = banks_1_allowWrite;
        _zz_when_MakeTask_l230_1 = banks_1_allowRead;
      end
      3'b010 : begin
        _zz_when_MakeTask_l227_1 = banks_2_allowPrecharge;
        _zz_when_MakeTask_l228_1 = banks_2_allowActive;
        _zz_when_MakeTask_l229_1 = banks_2_allowWrite;
        _zz_when_MakeTask_l230_1 = banks_2_allowRead;
      end
      3'b011 : begin
        _zz_when_MakeTask_l227_1 = banks_3_allowPrecharge;
        _zz_when_MakeTask_l228_1 = banks_3_allowActive;
        _zz_when_MakeTask_l229_1 = banks_3_allowWrite;
        _zz_when_MakeTask_l230_1 = banks_3_allowRead;
      end
      3'b100 : begin
        _zz_when_MakeTask_l227_1 = banks_4_allowPrecharge;
        _zz_when_MakeTask_l228_1 = banks_4_allowActive;
        _zz_when_MakeTask_l229_1 = banks_4_allowWrite;
        _zz_when_MakeTask_l230_1 = banks_4_allowRead;
      end
      3'b101 : begin
        _zz_when_MakeTask_l227_1 = banks_5_allowPrecharge;
        _zz_when_MakeTask_l228_1 = banks_5_allowActive;
        _zz_when_MakeTask_l229_1 = banks_5_allowWrite;
        _zz_when_MakeTask_l230_1 = banks_5_allowRead;
      end
      3'b110 : begin
        _zz_when_MakeTask_l227_1 = banks_6_allowPrecharge;
        _zz_when_MakeTask_l228_1 = banks_6_allowActive;
        _zz_when_MakeTask_l229_1 = banks_6_allowWrite;
        _zz_when_MakeTask_l230_1 = banks_6_allowRead;
      end
      default : begin
        _zz_when_MakeTask_l227_1 = banks_7_allowPrecharge;
        _zz_when_MakeTask_l228_1 = banks_7_allowActive;
        _zz_when_MakeTask_l229_1 = banks_7_allowWrite;
        _zz_when_MakeTask_l230_1 = banks_7_allowRead;
      end
    endcase
  end

  `ifndef SYNTHESIS
  always @(*) begin
    case(fsm_stateReg)
      fsm_enumDef_2_BOOT : fsm_stateReg_string = "BOOT           ";
      fsm_enumDef_2_idle : fsm_stateReg_string = "idle           ";
      fsm_enumDef_2_prechargeAllCmd : fsm_stateReg_string = "prechargeAllCmd";
      fsm_enumDef_2_refreshCmd : fsm_stateReg_string = "refreshCmd     ";
      fsm_enumDef_2_refreshReady : fsm_stateReg_string = "refreshReady   ";
      default : fsm_stateReg_string = "???????????????";
    endcase
  end
  always @(*) begin
    case(fsm_stateNext)
      fsm_enumDef_2_BOOT : fsm_stateNext_string = "BOOT           ";
      fsm_enumDef_2_idle : fsm_stateNext_string = "idle           ";
      fsm_enumDef_2_prechargeAllCmd : fsm_stateNext_string = "prechargeAllCmd";
      fsm_enumDef_2_refreshCmd : fsm_stateNext_string = "refreshCmd     ";
      fsm_enumDef_2_refreshReady : fsm_stateNext_string = "refreshReady   ";
      default : fsm_stateNext_string = "???????????????";
    endcase
  end
  `endif

  always @(*) begin
    _zz_1 = 1'b0;
    if(station_doSomething) begin
      _zz_1 = 1'b1;
    end
  end

  always @(*) begin
    readyForRefresh = 1'b1;
    if(taskConstructor_input_valid) begin
      readyForRefresh = 1'b0;
    end
    if(io_cmd_valid) begin
      readyForRefresh = 1'b0;
    end
    if(station_valid) begin
      readyForRefresh = 1'b0;
    end
  end

  assign when_MakeTask_l210 = (io_output_read || io_output_write);
  assign CCD_increment = (CCD_value != 2'b10);
  assign CCD_busy = CCD_increment;
  assign RFC_increment = (RFC_value != _zz_RFC_increment);
  assign RFC_busy = RFC_increment;
  assign RRD_increment = (RRD_value != _zz_RRD_increment);
  assign RRD_busy = RRD_increment;
  assign WTR_increment = (WTR_value != 5'h10);
  assign WTR_busy = WTR_increment;
  assign RTW_increment = (RTW_value != 5'h10);
  assign RTW_busy = RTW_increment;
  assign RP_increment = (RP_value != _zz_RP_increment);
  assign RP_busy = RP_increment;
  assign when_MakeTask_l210_1 = ((FAW_ptr == 2'b00) && io_output_active);
  assign FAW_slots_0_increment = (FAW_slots_0_value != _zz_FAW_slots_0_increment);
  assign FAW_slots_0_busy = FAW_slots_0_increment;
  assign when_MakeTask_l210_2 = ((FAW_ptr == 2'b01) && io_output_active);
  assign FAW_slots_1_increment = (FAW_slots_1_value != _zz_FAW_slots_1_increment);
  assign FAW_slots_1_busy = FAW_slots_1_increment;
  assign when_MakeTask_l210_3 = ((FAW_ptr == 2'b10) && io_output_active);
  assign FAW_slots_2_increment = (FAW_slots_2_value != _zz_FAW_slots_2_increment);
  assign FAW_slots_2_busy = FAW_slots_2_increment;
  assign when_MakeTask_l210_4 = ((FAW_ptr == 2'b11) && io_output_active);
  assign FAW_slots_3_increment = (FAW_slots_3_value != _zz_FAW_slots_3_increment);
  assign FAW_slots_3_busy = FAW_slots_3_increment;
  assign FAW_busyNext = _zz_FAW_busyNext;
  assign banks_0_hits = (io_output_address_bank == 3'b000);
  always @(*) begin
    banks_0_activeNext = banks_0_active;
    if(when_MakeTask_l47) begin
      banks_0_activeNext = 1'b0;
    end else begin
      if(when_MakeTask_l50) begin
        banks_0_activeNext = 1'b1;
      end
    end
  end

  assign when_MakeTask_l47 = ((banks_0_hits && io_output_precharge) || io_output_prechargeAll);
  assign when_MakeTask_l50 = (banks_0_hits && io_output_active);
  assign when_MakeTask_l210_5 = (banks_0_hits && io_output_write);
  assign banks_0_WR_increment = (banks_0_WR_value != _zz_banks_0_WR_increment);
  assign banks_0_WR_busy = banks_0_WR_increment;
  assign when_MakeTask_l210_6 = (banks_0_hits && io_output_active);
  assign banks_0_RAS_increment = (banks_0_RAS_value != _zz_banks_0_RAS_increment);
  assign banks_0_RAS_busy = banks_0_RAS_increment;
  assign when_MakeTask_l210_7 = (banks_0_hits && io_output_precharge);
  assign banks_0_RP_increment = (banks_0_RP_value != _zz_banks_0_RP_increment);
  assign banks_0_RP_busy = banks_0_RP_increment;
  assign when_MakeTask_l210_8 = (banks_0_hits && io_output_active);
  assign banks_0_RCD_increment = (banks_0_RCD_value != _zz_banks_0_RCD_increment);
  assign banks_0_RCD_busy = banks_0_RCD_increment;
  assign when_MakeTask_l210_9 = (banks_0_hits && io_output_read);
  assign banks_0_RTP_increment = (banks_0_RTP_value != _zz_banks_0_RTP_increment);
  assign banks_0_RTP_busy = banks_0_RTP_increment;
  assign banks_0_allowPrecharge = (((! banks_0_WR_busy) && (! banks_0_RAS_busy)) && (! banks_0_RTP_busy));
  assign banks_0_allowActive = (! banks_0_RP_busy);
  assign banks_0_allowWrite = (! banks_0_RCD_busy);
  assign banks_0_allowRead = (! banks_0_RCD_busy);
  assign banks_1_hits = (io_output_address_bank == 3'b001);
  always @(*) begin
    banks_1_activeNext = banks_1_active;
    if(when_MakeTask_l47_1) begin
      banks_1_activeNext = 1'b0;
    end else begin
      if(when_MakeTask_l50_1) begin
        banks_1_activeNext = 1'b1;
      end
    end
  end

  assign when_MakeTask_l47_1 = ((banks_1_hits && io_output_precharge) || io_output_prechargeAll);
  assign when_MakeTask_l50_1 = (banks_1_hits && io_output_active);
  assign when_MakeTask_l210_10 = (banks_1_hits && io_output_write);
  assign banks_1_WR_increment = (banks_1_WR_value != _zz_banks_1_WR_increment);
  assign banks_1_WR_busy = banks_1_WR_increment;
  assign when_MakeTask_l210_11 = (banks_1_hits && io_output_active);
  assign banks_1_RAS_increment = (banks_1_RAS_value != _zz_banks_1_RAS_increment);
  assign banks_1_RAS_busy = banks_1_RAS_increment;
  assign when_MakeTask_l210_12 = (banks_1_hits && io_output_precharge);
  assign banks_1_RP_increment = (banks_1_RP_value != _zz_banks_1_RP_increment);
  assign banks_1_RP_busy = banks_1_RP_increment;
  assign when_MakeTask_l210_13 = (banks_1_hits && io_output_active);
  assign banks_1_RCD_increment = (banks_1_RCD_value != _zz_banks_1_RCD_increment);
  assign banks_1_RCD_busy = banks_1_RCD_increment;
  assign when_MakeTask_l210_14 = (banks_1_hits && io_output_read);
  assign banks_1_RTP_increment = (banks_1_RTP_value != _zz_banks_1_RTP_increment);
  assign banks_1_RTP_busy = banks_1_RTP_increment;
  assign banks_1_allowPrecharge = (((! banks_1_WR_busy) && (! banks_1_RAS_busy)) && (! banks_1_RTP_busy));
  assign banks_1_allowActive = (! banks_1_RP_busy);
  assign banks_1_allowWrite = (! banks_1_RCD_busy);
  assign banks_1_allowRead = (! banks_1_RCD_busy);
  assign banks_2_hits = (io_output_address_bank == 3'b010);
  always @(*) begin
    banks_2_activeNext = banks_2_active;
    if(when_MakeTask_l47_2) begin
      banks_2_activeNext = 1'b0;
    end else begin
      if(when_MakeTask_l50_2) begin
        banks_2_activeNext = 1'b1;
      end
    end
  end

  assign when_MakeTask_l47_2 = ((banks_2_hits && io_output_precharge) || io_output_prechargeAll);
  assign when_MakeTask_l50_2 = (banks_2_hits && io_output_active);
  assign when_MakeTask_l210_15 = (banks_2_hits && io_output_write);
  assign banks_2_WR_increment = (banks_2_WR_value != _zz_banks_2_WR_increment);
  assign banks_2_WR_busy = banks_2_WR_increment;
  assign when_MakeTask_l210_16 = (banks_2_hits && io_output_active);
  assign banks_2_RAS_increment = (banks_2_RAS_value != _zz_banks_2_RAS_increment);
  assign banks_2_RAS_busy = banks_2_RAS_increment;
  assign when_MakeTask_l210_17 = (banks_2_hits && io_output_precharge);
  assign banks_2_RP_increment = (banks_2_RP_value != _zz_banks_2_RP_increment);
  assign banks_2_RP_busy = banks_2_RP_increment;
  assign when_MakeTask_l210_18 = (banks_2_hits && io_output_active);
  assign banks_2_RCD_increment = (banks_2_RCD_value != _zz_banks_2_RCD_increment);
  assign banks_2_RCD_busy = banks_2_RCD_increment;
  assign when_MakeTask_l210_19 = (banks_2_hits && io_output_read);
  assign banks_2_RTP_increment = (banks_2_RTP_value != _zz_banks_2_RTP_increment);
  assign banks_2_RTP_busy = banks_2_RTP_increment;
  assign banks_2_allowPrecharge = (((! banks_2_WR_busy) && (! banks_2_RAS_busy)) && (! banks_2_RTP_busy));
  assign banks_2_allowActive = (! banks_2_RP_busy);
  assign banks_2_allowWrite = (! banks_2_RCD_busy);
  assign banks_2_allowRead = (! banks_2_RCD_busy);
  assign banks_3_hits = (io_output_address_bank == 3'b011);
  always @(*) begin
    banks_3_activeNext = banks_3_active;
    if(when_MakeTask_l47_3) begin
      banks_3_activeNext = 1'b0;
    end else begin
      if(when_MakeTask_l50_3) begin
        banks_3_activeNext = 1'b1;
      end
    end
  end

  assign when_MakeTask_l47_3 = ((banks_3_hits && io_output_precharge) || io_output_prechargeAll);
  assign when_MakeTask_l50_3 = (banks_3_hits && io_output_active);
  assign when_MakeTask_l210_20 = (banks_3_hits && io_output_write);
  assign banks_3_WR_increment = (banks_3_WR_value != _zz_banks_3_WR_increment);
  assign banks_3_WR_busy = banks_3_WR_increment;
  assign when_MakeTask_l210_21 = (banks_3_hits && io_output_active);
  assign banks_3_RAS_increment = (banks_3_RAS_value != _zz_banks_3_RAS_increment);
  assign banks_3_RAS_busy = banks_3_RAS_increment;
  assign when_MakeTask_l210_22 = (banks_3_hits && io_output_precharge);
  assign banks_3_RP_increment = (banks_3_RP_value != _zz_banks_3_RP_increment);
  assign banks_3_RP_busy = banks_3_RP_increment;
  assign when_MakeTask_l210_23 = (banks_3_hits && io_output_active);
  assign banks_3_RCD_increment = (banks_3_RCD_value != _zz_banks_3_RCD_increment);
  assign banks_3_RCD_busy = banks_3_RCD_increment;
  assign when_MakeTask_l210_24 = (banks_3_hits && io_output_read);
  assign banks_3_RTP_increment = (banks_3_RTP_value != _zz_banks_3_RTP_increment);
  assign banks_3_RTP_busy = banks_3_RTP_increment;
  assign banks_3_allowPrecharge = (((! banks_3_WR_busy) && (! banks_3_RAS_busy)) && (! banks_3_RTP_busy));
  assign banks_3_allowActive = (! banks_3_RP_busy);
  assign banks_3_allowWrite = (! banks_3_RCD_busy);
  assign banks_3_allowRead = (! banks_3_RCD_busy);
  assign banks_4_hits = (io_output_address_bank == 3'b100);
  always @(*) begin
    banks_4_activeNext = banks_4_active;
    if(when_MakeTask_l47_4) begin
      banks_4_activeNext = 1'b0;
    end else begin
      if(when_MakeTask_l50_4) begin
        banks_4_activeNext = 1'b1;
      end
    end
  end

  assign when_MakeTask_l47_4 = ((banks_4_hits && io_output_precharge) || io_output_prechargeAll);
  assign when_MakeTask_l50_4 = (banks_4_hits && io_output_active);
  assign when_MakeTask_l210_25 = (banks_4_hits && io_output_write);
  assign banks_4_WR_increment = (banks_4_WR_value != _zz_banks_4_WR_increment);
  assign banks_4_WR_busy = banks_4_WR_increment;
  assign when_MakeTask_l210_26 = (banks_4_hits && io_output_active);
  assign banks_4_RAS_increment = (banks_4_RAS_value != _zz_banks_4_RAS_increment);
  assign banks_4_RAS_busy = banks_4_RAS_increment;
  assign when_MakeTask_l210_27 = (banks_4_hits && io_output_precharge);
  assign banks_4_RP_increment = (banks_4_RP_value != _zz_banks_4_RP_increment);
  assign banks_4_RP_busy = banks_4_RP_increment;
  assign when_MakeTask_l210_28 = (banks_4_hits && io_output_active);
  assign banks_4_RCD_increment = (banks_4_RCD_value != _zz_banks_4_RCD_increment);
  assign banks_4_RCD_busy = banks_4_RCD_increment;
  assign when_MakeTask_l210_29 = (banks_4_hits && io_output_read);
  assign banks_4_RTP_increment = (banks_4_RTP_value != _zz_banks_4_RTP_increment);
  assign banks_4_RTP_busy = banks_4_RTP_increment;
  assign banks_4_allowPrecharge = (((! banks_4_WR_busy) && (! banks_4_RAS_busy)) && (! banks_4_RTP_busy));
  assign banks_4_allowActive = (! banks_4_RP_busy);
  assign banks_4_allowWrite = (! banks_4_RCD_busy);
  assign banks_4_allowRead = (! banks_4_RCD_busy);
  assign banks_5_hits = (io_output_address_bank == 3'b101);
  always @(*) begin
    banks_5_activeNext = banks_5_active;
    if(when_MakeTask_l47_5) begin
      banks_5_activeNext = 1'b0;
    end else begin
      if(when_MakeTask_l50_5) begin
        banks_5_activeNext = 1'b1;
      end
    end
  end

  assign when_MakeTask_l47_5 = ((banks_5_hits && io_output_precharge) || io_output_prechargeAll);
  assign when_MakeTask_l50_5 = (banks_5_hits && io_output_active);
  assign when_MakeTask_l210_30 = (banks_5_hits && io_output_write);
  assign banks_5_WR_increment = (banks_5_WR_value != _zz_banks_5_WR_increment);
  assign banks_5_WR_busy = banks_5_WR_increment;
  assign when_MakeTask_l210_31 = (banks_5_hits && io_output_active);
  assign banks_5_RAS_increment = (banks_5_RAS_value != _zz_banks_5_RAS_increment);
  assign banks_5_RAS_busy = banks_5_RAS_increment;
  assign when_MakeTask_l210_32 = (banks_5_hits && io_output_precharge);
  assign banks_5_RP_increment = (banks_5_RP_value != _zz_banks_5_RP_increment);
  assign banks_5_RP_busy = banks_5_RP_increment;
  assign when_MakeTask_l210_33 = (banks_5_hits && io_output_active);
  assign banks_5_RCD_increment = (banks_5_RCD_value != _zz_banks_5_RCD_increment);
  assign banks_5_RCD_busy = banks_5_RCD_increment;
  assign when_MakeTask_l210_34 = (banks_5_hits && io_output_read);
  assign banks_5_RTP_increment = (banks_5_RTP_value != _zz_banks_5_RTP_increment);
  assign banks_5_RTP_busy = banks_5_RTP_increment;
  assign banks_5_allowPrecharge = (((! banks_5_WR_busy) && (! banks_5_RAS_busy)) && (! banks_5_RTP_busy));
  assign banks_5_allowActive = (! banks_5_RP_busy);
  assign banks_5_allowWrite = (! banks_5_RCD_busy);
  assign banks_5_allowRead = (! banks_5_RCD_busy);
  assign banks_6_hits = (io_output_address_bank == 3'b110);
  always @(*) begin
    banks_6_activeNext = banks_6_active;
    if(when_MakeTask_l47_6) begin
      banks_6_activeNext = 1'b0;
    end else begin
      if(when_MakeTask_l50_6) begin
        banks_6_activeNext = 1'b1;
      end
    end
  end

  assign when_MakeTask_l47_6 = ((banks_6_hits && io_output_precharge) || io_output_prechargeAll);
  assign when_MakeTask_l50_6 = (banks_6_hits && io_output_active);
  assign when_MakeTask_l210_35 = (banks_6_hits && io_output_write);
  assign banks_6_WR_increment = (banks_6_WR_value != _zz_banks_6_WR_increment);
  assign banks_6_WR_busy = banks_6_WR_increment;
  assign when_MakeTask_l210_36 = (banks_6_hits && io_output_active);
  assign banks_6_RAS_increment = (banks_6_RAS_value != _zz_banks_6_RAS_increment);
  assign banks_6_RAS_busy = banks_6_RAS_increment;
  assign when_MakeTask_l210_37 = (banks_6_hits && io_output_precharge);
  assign banks_6_RP_increment = (banks_6_RP_value != _zz_banks_6_RP_increment);
  assign banks_6_RP_busy = banks_6_RP_increment;
  assign when_MakeTask_l210_38 = (banks_6_hits && io_output_active);
  assign banks_6_RCD_increment = (banks_6_RCD_value != _zz_banks_6_RCD_increment);
  assign banks_6_RCD_busy = banks_6_RCD_increment;
  assign when_MakeTask_l210_39 = (banks_6_hits && io_output_read);
  assign banks_6_RTP_increment = (banks_6_RTP_value != _zz_banks_6_RTP_increment);
  assign banks_6_RTP_busy = banks_6_RTP_increment;
  assign banks_6_allowPrecharge = (((! banks_6_WR_busy) && (! banks_6_RAS_busy)) && (! banks_6_RTP_busy));
  assign banks_6_allowActive = (! banks_6_RP_busy);
  assign banks_6_allowWrite = (! banks_6_RCD_busy);
  assign banks_6_allowRead = (! banks_6_RCD_busy);
  assign banks_7_hits = (io_output_address_bank == 3'b111);
  always @(*) begin
    banks_7_activeNext = banks_7_active;
    if(when_MakeTask_l47_7) begin
      banks_7_activeNext = 1'b0;
    end else begin
      if(when_MakeTask_l50_7) begin
        banks_7_activeNext = 1'b1;
      end
    end
  end

  assign when_MakeTask_l47_7 = ((banks_7_hits && io_output_precharge) || io_output_prechargeAll);
  assign when_MakeTask_l50_7 = (banks_7_hits && io_output_active);
  assign when_MakeTask_l210_40 = (banks_7_hits && io_output_write);
  assign banks_7_WR_increment = (banks_7_WR_value != _zz_banks_7_WR_increment);
  assign banks_7_WR_busy = banks_7_WR_increment;
  assign when_MakeTask_l210_41 = (banks_7_hits && io_output_active);
  assign banks_7_RAS_increment = (banks_7_RAS_value != _zz_banks_7_RAS_increment);
  assign banks_7_RAS_busy = banks_7_RAS_increment;
  assign when_MakeTask_l210_42 = (banks_7_hits && io_output_precharge);
  assign banks_7_RP_increment = (banks_7_RP_value != _zz_banks_7_RP_increment);
  assign banks_7_RP_busy = banks_7_RP_increment;
  assign when_MakeTask_l210_43 = (banks_7_hits && io_output_active);
  assign banks_7_RCD_increment = (banks_7_RCD_value != _zz_banks_7_RCD_increment);
  assign banks_7_RCD_busy = banks_7_RCD_increment;
  assign when_MakeTask_l210_44 = (banks_7_hits && io_output_read);
  assign banks_7_RTP_increment = (banks_7_RTP_value != _zz_banks_7_RTP_increment);
  assign banks_7_RTP_busy = banks_7_RTP_increment;
  assign banks_7_allowPrecharge = (((! banks_7_WR_busy) && (! banks_7_RAS_busy)) && (! banks_7_RTP_busy));
  assign banks_7_allowActive = (! banks_7_RP_busy);
  assign banks_7_allowWrite = (! banks_7_RCD_busy);
  assign banks_7_allowRead = (! banks_7_RCD_busy);
  assign allowPrechargeAll = (&{banks_7_allowPrecharge,{banks_6_allowPrecharge,{banks_5_allowPrecharge,{banks_4_allowPrecharge,{banks_3_allowPrecharge,{banks_2_allowPrecharge,{banks_1_allowPrecharge,banks_0_allowPrecharge}}}}}}});
  always @(*) begin
    io_cmd_ready = taskConstructor_input_ready;
    if(when_Stream_l393) begin
      io_cmd_ready = 1'b1;
    end
  end

  assign when_Stream_l393 = (! taskConstructor_input_valid);
  assign taskConstructor_input_valid = io_cmd_rValid;
  assign taskConstructor_input_payload_write = io_cmd_rData_write;
  assign taskConstructor_input_payload_address = io_cmd_rData_address;
  assign taskConstructor_input_payload_context = io_cmd_rData_context;
  assign taskConstructor_input_payload_burstLast = io_cmd_rData_burstLast;
  assign taskConstructor_input_payload_length = io_cmd_rData_length;
  assign taskConstructor_addrMapping_rbcAddress = taskConstructor_input_payload_address[28 : 1];
  assign taskConstructor_address_byte = taskConstructor_input_payload_address[0 : 0];
  assign taskConstructor_address_column = taskConstructor_addrMapping_rbcAddress[9 : 0];
  assign taskConstructor_address_bank = taskConstructor_addrMapping_rbcAddress[12 : 10];
  assign taskConstructor_address_row = taskConstructor_addrMapping_rbcAddress[27 : 13];
  always @(*) begin
    taskConstructor_status_allowPrecharge = 1'b1;
    if(when_MakeTask_l227) begin
      taskConstructor_status_allowPrecharge = 1'b0;
    end
    if(when_MakeTask_l232) begin
      if(io_output_active) begin
        taskConstructor_status_allowPrecharge = 1'b0;
      end
      if(when_MakeTask_l243) begin
        taskConstructor_status_allowPrecharge = 1'b0;
      end
    end
  end

  always @(*) begin
    taskConstructor_status_allowActive = ((! RRD_busy) && (! FAW_busyNext));
    if(when_MakeTask_l228) begin
      taskConstructor_status_allowActive = 1'b0;
    end
    if(when_MakeTask_l232) begin
      if(io_output_precharge) begin
        taskConstructor_status_allowActive = 1'b0;
      end
    end
  end

  always @(*) begin
    taskConstructor_status_allowWrite = ((! RTW_busy) && (! CCD_busy));
    if(when_MakeTask_l229) begin
      taskConstructor_status_allowWrite = 1'b0;
    end
    if(when_MakeTask_l232) begin
      if(io_output_active) begin
        taskConstructor_status_allowWrite = 1'b0;
      end
    end
  end

  always @(*) begin
    taskConstructor_status_allowRead = ((! WTR_busy) && (! CCD_busy));
    if(when_MakeTask_l230) begin
      taskConstructor_status_allowRead = 1'b0;
    end
    if(when_MakeTask_l232) begin
      if(io_output_active) begin
        taskConstructor_status_allowRead = 1'b0;
      end
    end
  end

  always @(*) begin
    taskConstructor_status_bankHit = (banksRow_spinal_port0 == taskConstructor_address_row);
    if(when_MakeTask_l232) begin
      if(io_output_active) begin
        taskConstructor_status_bankHit = (io_output_address_row == taskConstructor_address_row);
      end
    end
  end

  always @(*) begin
    taskConstructor_status_bankActive = _zz_taskConstructor_status_bankActive;
    if(when_MakeTask_l232) begin
      if(io_output_precharge) begin
        taskConstructor_status_bankActive = 1'b0;
      end
      if(io_output_active) begin
        taskConstructor_status_bankActive = 1'b1;
      end
    end
  end

  assign when_MakeTask_l227 = (! _zz_when_MakeTask_l227);
  assign when_MakeTask_l228 = (! _zz_when_MakeTask_l228);
  assign when_MakeTask_l229 = (! _zz_when_MakeTask_l229);
  assign when_MakeTask_l230 = (! _zz_when_MakeTask_l230);
  assign when_MakeTask_l232 = (io_output_address_bank == taskConstructor_address_bank);
  assign when_MakeTask_l243 = (io_output_read || io_output_write);
  assign when_MakeTask_l227_1 = (! _zz_when_MakeTask_l227_1);
  assign when_MakeTask_l228_1 = (! _zz_when_MakeTask_l228_1);
  assign when_MakeTask_l229_1 = (! _zz_when_MakeTask_l229_1);
  assign when_MakeTask_l230_1 = (! _zz_when_MakeTask_l230_1);
  assign when_MakeTask_l232_1 = (io_output_address_bank == station_address_bank);
  assign when_MakeTask_l243_1 = (io_output_read || io_output_write);
  assign when_MakeTask_l111 = (io_output_read || io_output_write);
  assign station_inputActive = (! station_status_bankActive);
  assign station_inputPrecharge = (station_status_bankActive && (! station_status_bankHit));
  assign station_inputAccess = (station_status_bankActive && station_status_bankHit);
  assign station_inputWrite = ((station_status_bankActive && station_status_bankHit) && station_write);
  assign station_inputRead = ((station_status_bankActive && station_status_bankHit) && (! station_write));
  assign station_doActive = (station_inputActive && station_status_allowActive);
  assign station_doPrecharge = (station_inputPrecharge && station_status_allowPrecharge);
  assign station_doWrite = ((station_inputWrite && station_status_allowWrite) && io_writeDataToken_valid);
  assign station_doRead = (station_inputRead && station_status_allowRead);
  assign station_doAccess = (station_doWrite || station_doRead);
  assign station_doSomething = (station_valid && (((station_doActive || station_doPrecharge) || station_doWrite) || station_doRead));
  assign station_blockedByWriteToken = ((station_inputWrite && station_status_allowWrite) && (! io_writeDataToken_valid));
  always @(*) begin
    station_fire = 1'b0;
    if(when_MakeTask_l153) begin
      if(station_last) begin
        station_fire = 1'b1;
      end
    end
  end

  assign station_last = (station_offset == station_offsetLast);
  assign io_output_address_column = (station_address_column | _zz_io_output_address_column);
  assign io_output_address_byte = station_address_byte;
  assign io_output_address_bank = station_address_bank;
  assign io_output_address_row = station_address_row;
  assign io_output_context = station_context;
  assign io_output_active = station_inputActive;
  assign io_output_precharge = station_inputPrecharge;
  assign io_output_write = (station_doWrite && station_valid);
  assign io_output_read = (station_doRead && station_valid);
  assign io_output_last = station_last;
  always @(*) begin
    io_writeDataToken_ready = 1'b0;
    if(io_output_write) begin
      io_writeDataToken_ready = 1'b1;
    end
  end

  assign when_MakeTask_l153 = (station_doAccess && station_valid);
  assign io_halt = refresher_1_io_refresh_valid;
  assign refreshStream_valid = refresher_1_io_refresh_valid;
  assign taskConstructor_input_ready = (! station_valid);
  assign loader_offset = taskConstructor_address_column[4 : 3];
  assign loader_offsetLast = (loader_offset + taskConstructor_input_payload_length);
  assign loader_canSpawn = (! station_valid);
  assign when_MakeTask_l175 = (taskConstructor_input_valid && loader_canSpawn);
  assign askRefresh = (refreshStream_valid && readyForRefresh);
  assign fsm_wantExit = 1'b0;
  always @(*) begin
    fsm_wantStart = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_2_idle : begin
      end
      fsm_enumDef_2_prechargeAllCmd : begin
      end
      fsm_enumDef_2_refreshCmd : begin
      end
      fsm_enumDef_2_refreshReady : begin
      end
      default : begin
        fsm_wantStart = 1'b1;
      end
    endcase
  end

  assign fsm_wantKill = 1'b0;
  always @(*) begin
    refreshStream_ready = 1'b0;
    if(fsm_onExit_refreshReady) begin
      refreshStream_ready = 1'b1;
    end
  end

  always @(*) begin
    io_output_prechargeAll = 1'b0;
    if(fsm_onExit_prechargeAllCmd) begin
      io_output_prechargeAll = 1'b1;
    end
  end

  always @(*) begin
    io_output_refresh = 1'b0;
    if(fsm_onExit_refreshCmd) begin
      io_output_refresh = 1'b1;
    end
  end

  always @(*) begin
    fsm_stateNext = fsm_stateReg;
    case(fsm_stateReg)
      fsm_enumDef_2_idle : begin
        if(askRefresh) begin
          fsm_stateNext = fsm_enumDef_2_prechargeAllCmd;
        end
      end
      fsm_enumDef_2_prechargeAllCmd : begin
        if(when_MakeTask_l196) begin
          fsm_stateNext = fsm_enumDef_2_refreshCmd;
        end
      end
      fsm_enumDef_2_refreshCmd : begin
        if(when_MakeTask_l197) begin
          fsm_stateNext = fsm_enumDef_2_refreshReady;
        end
      end
      fsm_enumDef_2_refreshReady : begin
        if(when_MakeTask_l198) begin
          fsm_stateNext = fsm_enumDef_2_idle;
        end
      end
      default : begin
      end
    endcase
    if(fsm_wantStart) begin
      fsm_stateNext = fsm_enumDef_2_idle;
    end
    if(fsm_wantKill) begin
      fsm_stateNext = fsm_enumDef_2_BOOT;
    end
  end

  assign when_MakeTask_l196 = (allowPrechargeAll_regNext && askRefresh);
  assign when_MakeTask_l197 = ((! RP_busy) && askRefresh);
  assign when_MakeTask_l198 = ((! RFC_busy) && askRefresh);
  assign fsm_onExit_BOOT = ((fsm_stateNext != fsm_enumDef_2_BOOT) && (fsm_stateReg == fsm_enumDef_2_BOOT));
  assign fsm_onExit_idle = ((fsm_stateNext != fsm_enumDef_2_idle) && (fsm_stateReg == fsm_enumDef_2_idle));
  assign fsm_onExit_prechargeAllCmd = ((fsm_stateNext != fsm_enumDef_2_prechargeAllCmd) && (fsm_stateReg == fsm_enumDef_2_prechargeAllCmd));
  assign fsm_onExit_refreshCmd = ((fsm_stateNext != fsm_enumDef_2_refreshCmd) && (fsm_stateReg == fsm_enumDef_2_refreshCmd));
  assign fsm_onExit_refreshReady = ((fsm_stateNext != fsm_enumDef_2_refreshReady) && (fsm_stateReg == fsm_enumDef_2_refreshReady));
  assign fsm_onEntry_BOOT = ((fsm_stateNext == fsm_enumDef_2_BOOT) && (fsm_stateReg != fsm_enumDef_2_BOOT));
  assign fsm_onEntry_idle = ((fsm_stateNext == fsm_enumDef_2_idle) && (fsm_stateReg != fsm_enumDef_2_idle));
  assign fsm_onEntry_prechargeAllCmd = ((fsm_stateNext == fsm_enumDef_2_prechargeAllCmd) && (fsm_stateReg != fsm_enumDef_2_prechargeAllCmd));
  assign fsm_onEntry_refreshCmd = ((fsm_stateNext == fsm_enumDef_2_refreshCmd) && (fsm_stateReg != fsm_enumDef_2_refreshCmd));
  assign fsm_onEntry_refreshReady = ((fsm_stateNext == fsm_enumDef_2_refreshReady) && (fsm_stateReg != fsm_enumDef_2_refreshReady));
  always @(posedge clk_out4) begin
    CCD_value <= (CCD_value + _zz_CCD_value);
    if(when_MakeTask_l210) begin
      CCD_value <= 2'b00;
    end
    RFC_value <= (RFC_value + _zz_RFC_value);
    if(io_output_refresh) begin
      RFC_value <= 8'h0;
    end
    RRD_value <= (RRD_value + _zz_RRD_value);
    if(io_output_active) begin
      RRD_value <= 5'h0;
    end
    WTR_value <= (WTR_value + _zz_WTR_value);
    if(io_output_write) begin
      WTR_value <= 5'h0;
    end
    RTW_value <= (RTW_value + _zz_RTW_value);
    if(io_output_read) begin
      RTW_value <= 5'h0;
    end
    RP_value <= (RP_value + _zz_RP_value);
    if(io_output_prechargeAll) begin
      RP_value <= 5'h0;
    end
    FAW_slots_0_value <= (FAW_slots_0_value + _zz_FAW_slots_0_value);
    if(when_MakeTask_l210_1) begin
      FAW_slots_0_value <= 5'h0;
    end
    FAW_slots_1_value <= (FAW_slots_1_value + _zz_FAW_slots_1_value);
    if(when_MakeTask_l210_2) begin
      FAW_slots_1_value <= 5'h0;
    end
    FAW_slots_2_value <= (FAW_slots_2_value + _zz_FAW_slots_2_value);
    if(when_MakeTask_l210_3) begin
      FAW_slots_2_value <= 5'h0;
    end
    FAW_slots_3_value <= (FAW_slots_3_value + _zz_FAW_slots_3_value);
    if(when_MakeTask_l210_4) begin
      FAW_slots_3_value <= 5'h0;
    end
    banks_0_WR_value <= (banks_0_WR_value + _zz_banks_0_WR_value);
    if(when_MakeTask_l210_5) begin
      banks_0_WR_value <= 5'h0;
    end
    banks_0_RAS_value <= (banks_0_RAS_value + _zz_banks_0_RAS_value);
    if(when_MakeTask_l210_6) begin
      banks_0_RAS_value <= 5'h0;
    end
    banks_0_RP_value <= (banks_0_RP_value + _zz_banks_0_RP_value);
    if(when_MakeTask_l210_7) begin
      banks_0_RP_value <= 5'h0;
    end
    banks_0_RCD_value <= (banks_0_RCD_value + _zz_banks_0_RCD_value);
    if(when_MakeTask_l210_8) begin
      banks_0_RCD_value <= 5'h0;
    end
    banks_0_RTP_value <= (banks_0_RTP_value + _zz_banks_0_RTP_value);
    if(when_MakeTask_l210_9) begin
      banks_0_RTP_value <= 5'h0;
    end
    banks_1_WR_value <= (banks_1_WR_value + _zz_banks_1_WR_value);
    if(when_MakeTask_l210_10) begin
      banks_1_WR_value <= 5'h0;
    end
    banks_1_RAS_value <= (banks_1_RAS_value + _zz_banks_1_RAS_value);
    if(when_MakeTask_l210_11) begin
      banks_1_RAS_value <= 5'h0;
    end
    banks_1_RP_value <= (banks_1_RP_value + _zz_banks_1_RP_value);
    if(when_MakeTask_l210_12) begin
      banks_1_RP_value <= 5'h0;
    end
    banks_1_RCD_value <= (banks_1_RCD_value + _zz_banks_1_RCD_value);
    if(when_MakeTask_l210_13) begin
      banks_1_RCD_value <= 5'h0;
    end
    banks_1_RTP_value <= (banks_1_RTP_value + _zz_banks_1_RTP_value);
    if(when_MakeTask_l210_14) begin
      banks_1_RTP_value <= 5'h0;
    end
    banks_2_WR_value <= (banks_2_WR_value + _zz_banks_2_WR_value);
    if(when_MakeTask_l210_15) begin
      banks_2_WR_value <= 5'h0;
    end
    banks_2_RAS_value <= (banks_2_RAS_value + _zz_banks_2_RAS_value);
    if(when_MakeTask_l210_16) begin
      banks_2_RAS_value <= 5'h0;
    end
    banks_2_RP_value <= (banks_2_RP_value + _zz_banks_2_RP_value);
    if(when_MakeTask_l210_17) begin
      banks_2_RP_value <= 5'h0;
    end
    banks_2_RCD_value <= (banks_2_RCD_value + _zz_banks_2_RCD_value);
    if(when_MakeTask_l210_18) begin
      banks_2_RCD_value <= 5'h0;
    end
    banks_2_RTP_value <= (banks_2_RTP_value + _zz_banks_2_RTP_value);
    if(when_MakeTask_l210_19) begin
      banks_2_RTP_value <= 5'h0;
    end
    banks_3_WR_value <= (banks_3_WR_value + _zz_banks_3_WR_value);
    if(when_MakeTask_l210_20) begin
      banks_3_WR_value <= 5'h0;
    end
    banks_3_RAS_value <= (banks_3_RAS_value + _zz_banks_3_RAS_value);
    if(when_MakeTask_l210_21) begin
      banks_3_RAS_value <= 5'h0;
    end
    banks_3_RP_value <= (banks_3_RP_value + _zz_banks_3_RP_value);
    if(when_MakeTask_l210_22) begin
      banks_3_RP_value <= 5'h0;
    end
    banks_3_RCD_value <= (banks_3_RCD_value + _zz_banks_3_RCD_value);
    if(when_MakeTask_l210_23) begin
      banks_3_RCD_value <= 5'h0;
    end
    banks_3_RTP_value <= (banks_3_RTP_value + _zz_banks_3_RTP_value);
    if(when_MakeTask_l210_24) begin
      banks_3_RTP_value <= 5'h0;
    end
    banks_4_WR_value <= (banks_4_WR_value + _zz_banks_4_WR_value);
    if(when_MakeTask_l210_25) begin
      banks_4_WR_value <= 5'h0;
    end
    banks_4_RAS_value <= (banks_4_RAS_value + _zz_banks_4_RAS_value);
    if(when_MakeTask_l210_26) begin
      banks_4_RAS_value <= 5'h0;
    end
    banks_4_RP_value <= (banks_4_RP_value + _zz_banks_4_RP_value);
    if(when_MakeTask_l210_27) begin
      banks_4_RP_value <= 5'h0;
    end
    banks_4_RCD_value <= (banks_4_RCD_value + _zz_banks_4_RCD_value);
    if(when_MakeTask_l210_28) begin
      banks_4_RCD_value <= 5'h0;
    end
    banks_4_RTP_value <= (banks_4_RTP_value + _zz_banks_4_RTP_value);
    if(when_MakeTask_l210_29) begin
      banks_4_RTP_value <= 5'h0;
    end
    banks_5_WR_value <= (banks_5_WR_value + _zz_banks_5_WR_value);
    if(when_MakeTask_l210_30) begin
      banks_5_WR_value <= 5'h0;
    end
    banks_5_RAS_value <= (banks_5_RAS_value + _zz_banks_5_RAS_value);
    if(when_MakeTask_l210_31) begin
      banks_5_RAS_value <= 5'h0;
    end
    banks_5_RP_value <= (banks_5_RP_value + _zz_banks_5_RP_value);
    if(when_MakeTask_l210_32) begin
      banks_5_RP_value <= 5'h0;
    end
    banks_5_RCD_value <= (banks_5_RCD_value + _zz_banks_5_RCD_value);
    if(when_MakeTask_l210_33) begin
      banks_5_RCD_value <= 5'h0;
    end
    banks_5_RTP_value <= (banks_5_RTP_value + _zz_banks_5_RTP_value);
    if(when_MakeTask_l210_34) begin
      banks_5_RTP_value <= 5'h0;
    end
    banks_6_WR_value <= (banks_6_WR_value + _zz_banks_6_WR_value);
    if(when_MakeTask_l210_35) begin
      banks_6_WR_value <= 5'h0;
    end
    banks_6_RAS_value <= (banks_6_RAS_value + _zz_banks_6_RAS_value);
    if(when_MakeTask_l210_36) begin
      banks_6_RAS_value <= 5'h0;
    end
    banks_6_RP_value <= (banks_6_RP_value + _zz_banks_6_RP_value);
    if(when_MakeTask_l210_37) begin
      banks_6_RP_value <= 5'h0;
    end
    banks_6_RCD_value <= (banks_6_RCD_value + _zz_banks_6_RCD_value);
    if(when_MakeTask_l210_38) begin
      banks_6_RCD_value <= 5'h0;
    end
    banks_6_RTP_value <= (banks_6_RTP_value + _zz_banks_6_RTP_value);
    if(when_MakeTask_l210_39) begin
      banks_6_RTP_value <= 5'h0;
    end
    banks_7_WR_value <= (banks_7_WR_value + _zz_banks_7_WR_value);
    if(when_MakeTask_l210_40) begin
      banks_7_WR_value <= 5'h0;
    end
    banks_7_RAS_value <= (banks_7_RAS_value + _zz_banks_7_RAS_value);
    if(when_MakeTask_l210_41) begin
      banks_7_RAS_value <= 5'h0;
    end
    banks_7_RP_value <= (banks_7_RP_value + _zz_banks_7_RP_value);
    if(when_MakeTask_l210_42) begin
      banks_7_RP_value <= 5'h0;
    end
    banks_7_RCD_value <= (banks_7_RCD_value + _zz_banks_7_RCD_value);
    if(when_MakeTask_l210_43) begin
      banks_7_RCD_value <= 5'h0;
    end
    banks_7_RTP_value <= (banks_7_RTP_value + _zz_banks_7_RTP_value);
    if(when_MakeTask_l210_44) begin
      banks_7_RTP_value <= 5'h0;
    end
    if(io_cmd_ready) begin
      io_cmd_rData_write <= io_cmd_payload_write;
      io_cmd_rData_address <= io_cmd_payload_address;
      io_cmd_rData_context <= io_cmd_payload_context;
      io_cmd_rData_burstLast <= io_cmd_payload_burstLast;
      io_cmd_rData_length <= io_cmd_payload_length;
    end
    station_status_allowPrecharge <= 1'b1;
    station_status_allowActive <= ((! RRD_busy) && (! FAW_busyNext));
    station_status_allowWrite <= ((! RTW_busy) && (! CCD_busy));
    station_status_allowRead <= ((! WTR_busy) && (! CCD_busy));
    if(when_MakeTask_l227_1) begin
      station_status_allowPrecharge <= 1'b0;
    end
    if(when_MakeTask_l228_1) begin
      station_status_allowActive <= 1'b0;
    end
    if(when_MakeTask_l229_1) begin
      station_status_allowWrite <= 1'b0;
    end
    if(when_MakeTask_l230_1) begin
      station_status_allowRead <= 1'b0;
    end
    if(when_MakeTask_l232_1) begin
      if(io_output_active) begin
        station_status_allowRead <= 1'b0;
        station_status_allowWrite <= 1'b0;
        station_status_allowPrecharge <= 1'b0;
      end
      if(when_MakeTask_l243_1) begin
        station_status_allowPrecharge <= 1'b0;
      end
      if(io_output_precharge) begin
        station_status_allowActive <= 1'b0;
      end
    end
    if(io_output_active) begin
      station_status_allowActive <= 1'b0;
    end
    if(when_MakeTask_l111) begin
      station_status_allowRead <= 1'b0;
      station_status_allowWrite <= 1'b0;
    end
    if(when_MakeTask_l153) begin
      station_offset <= (station_offset + 2'b01);
    end
    if(when_MakeTask_l175) begin
      station_status_allowPrecharge <= taskConstructor_status_allowPrecharge;
      station_status_allowActive <= taskConstructor_status_allowActive;
      station_status_allowWrite <= taskConstructor_status_allowWrite;
      station_status_allowRead <= taskConstructor_status_allowRead;
      station_address_column <= (taskConstructor_address_column & 10'h3e7);
      station_address_byte <= taskConstructor_address_byte;
      station_address_bank <= taskConstructor_address_bank;
      station_address_row <= taskConstructor_address_row;
      station_write <= taskConstructor_input_payload_write;
      station_context <= taskConstructor_input_payload_context;
      station_offset <= loader_offset;
      station_offsetLast <= loader_offsetLast;
    end
  end

  always @(posedge clk_out4 or negedge rstN) begin
    if(!rstN) begin
      FAW_ptr <= 2'b00;
      banks_0_active <= 1'b0;
      banks_1_active <= 1'b0;
      banks_2_active <= 1'b0;
      banks_3_active <= 1'b0;
      banks_4_active <= 1'b0;
      banks_5_active <= 1'b0;
      banks_6_active <= 1'b0;
      banks_7_active <= 1'b0;
      io_cmd_rValid <= 1'b0;
      station_valid <= 1'b0;
      station_status_bankHit <= 1'b0;
      station_status_bankActive <= 1'b0;
      fsm_stateReg <= fsm_enumDef_2_BOOT;
    end else begin
      FAW_ptr <= (FAW_ptr + _zz_FAW_ptr);
      banks_0_active <= banks_0_activeNext;
      banks_1_active <= banks_1_activeNext;
      banks_2_active <= banks_2_activeNext;
      banks_3_active <= banks_3_activeNext;
      banks_4_active <= banks_4_activeNext;
      banks_5_active <= banks_5_activeNext;
      banks_6_active <= banks_6_activeNext;
      banks_7_active <= banks_7_activeNext;
      if(io_cmd_ready) begin
        io_cmd_rValid <= io_cmd_valid;
      end
      if(when_MakeTask_l232_1) begin
        if(io_output_precharge) begin
          station_status_bankActive <= 1'b0;
        end
        if(io_output_active) begin
          station_status_bankActive <= 1'b1;
          station_status_bankHit <= (io_output_address_row == station_address_row);
        end
      end
      if(when_MakeTask_l153) begin
        if(station_last) begin
          station_valid <= 1'b0;
        end
      end
      if(when_MakeTask_l175) begin
        station_valid <= 1'b1;
        station_status_bankActive <= taskConstructor_status_bankActive;
        station_status_bankHit <= taskConstructor_status_bankHit;
      end
      fsm_stateReg <= fsm_stateNext;
    end
  end

  always @(posedge clk_out4) begin
    allowPrechargeAll_regNext <= allowPrechargeAll;
  end


endmodule
