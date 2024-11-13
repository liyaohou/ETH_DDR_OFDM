module eth_mac_tx_t(
    input           rst_n,
    input           logic_clk,
    input           gtx_clk,
    input           gtx_clk90,
    input           port_udp_tx_hdr_valid,
    output          port_udp_tx_hdr_ready,
    input [31:0]    port_udp_tx_dest_ip,
    input [9:0]     port_udp_tx_length,
    input           port_udp_tx_axis_valid,
    output          port_udp_tx_axis_ready,
    input [7:0]     port_udp_tx_axis_payload_data,
    input           port_udp_tx_axis_payload_user,
    input           port_udp_tx_axis_payload_last,
    output          port_eth_tx_axis_valid,
    input           port_eth_tx_axis_ready,
    output [7:0]    port_eth_tx_axis_payload_data,
    output          port_eth_tx_axis_payload_user,
    output          port_eth_tx_axis_payload_last
);
// `include"src\Eth\udp\udp_complete_lite.v"

// target ("SIM", "GENERIC", "XILINX", "ALTERA")
parameter TARGET = "XILINX";
// IODDR style ("IODDR", "IODDR2")
// Use IODDR for Virtex-4, Virtex-5, Virtex-6, 7 Series, Ultrascale
// Use IODDR2 for Spartan-6
parameter IODDR_STYLE = "IODDR";
// Clock input style ("BUFG", "BUFR", "BUFIO", "BUFIO2")
// Use BUFR for Virtex-6, 7-series
// Use BUFG for Virtex-5, Spartan-6, Ultrascale
parameter CLOCK_INPUT_STYLE = "BUFR";
// Use 90 degree clock for RGMII transmit ("TRUE", "FALSE")
parameter USE_CLK90 = "TRUE";
parameter AXIS_DATA_WIDTH = 8;
parameter AXIS_KEEP_ENABLE = (AXIS_DATA_WIDTH>8);
parameter AXIS_KEEP_WIDTH = (AXIS_DATA_WIDTH/8);
parameter ENABLE_PADDING = 1;
parameter MIN_FRAME_LENGTH = 64;
parameter TX_FIFO_DEPTH = 4096;
parameter TX_FIFO_RAM_PIPELINE = 1;
parameter TX_FRAME_FIFO = 1;
parameter TX_DROP_OVERSIZE_FRAME = TX_FRAME_FIFO;
parameter TX_DROP_BAD_FRAME = TX_DROP_OVERSIZE_FRAME;
parameter TX_DROP_WHEN_FULL = 0;
parameter RX_FIFO_DEPTH = 4096;
parameter RX_FIFO_RAM_PIPELINE = 1;
parameter RX_FRAME_FIFO = 1;
parameter RX_DROP_OVERSIZE_FRAME = RX_FRAME_FIFO;
parameter RX_DROP_BAD_FRAME = RX_DROP_OVERSIZE_FRAME;
parameter RX_DROP_WHEN_FULL = RX_DROP_OVERSIZE_FRAME;

// AXI between MAC and Ethernet modules
// wire                       gtx_clk;
// wire                       gtx_clk90;
wire                       gtx_rst;
// wire                       logic_clk;
wire                       logic_rst;

// wire [AXIS_DATA_WIDTH-1:0] tx_axis_tdata;
// wire [AXIS_KEEP_WIDTH-1:0] tx_axis_tkeep;
// wire                       tx_axis_tvalid;
// wire                       tx_axis_tready;
// wire                       tx_axis_tlast;
// wire                       tx_axis_tuser;

// wire [AXIS_DATA_WIDTH-1:0] rx_axis_tdata;
// wire [AXIS_KEEP_WIDTH-1:0] rx_axis_tkeep;
// wire                       rx_axis_tvalid;
// wire                       rx_axis_tready;
// wire                       rx_axis_tlast;
// wire                       rx_axis_tuser;

// Ethernet frame between Ethernet modules and UDP stack
// wire rx_eth_hdr_ready;
// wire rx_eth_hdr_valid;
// wire [47:0] rx_eth_dest_mac;
// wire [47:0] rx_eth_src_mac;
// wire [15:0] rx_eth_type;
// wire [7:0] rx_eth_payload_axis_tdata;
// wire rx_eth_payload_axis_tvalid;
// wire rx_eth_payload_axis_tready;
// wire rx_eth_payload_axis_tlast;
// wire rx_eth_payload_axis_tuser;

wire tx_eth_hdr_ready;
wire tx_eth_hdr_valid;
wire [47:0] tx_eth_dest_mac;
wire [47:0] tx_eth_src_mac;
wire [15:0] tx_eth_type;
wire [7:0] tx_eth_payload_axis_tdata;
wire tx_eth_payload_axis_tvalid;
wire tx_eth_payload_axis_tready;
wire tx_eth_payload_axis_tlast;
wire tx_eth_payload_axis_tuser;

// IP frame connections
wire rx_ip_hdr_valid;
wire rx_ip_hdr_ready;
wire [47:0] rx_ip_eth_dest_mac;
wire [47:0] rx_ip_eth_src_mac;
wire [15:0] rx_ip_eth_type;
wire [3:0] rx_ip_version;
wire [3:0] rx_ip_ihl;
wire [5:0] rx_ip_dscp;
wire [1:0] rx_ip_ecn;
wire [15:0] rx_ip_length;
wire [15:0] rx_ip_identification;
wire [2:0] rx_ip_flags;
wire [12:0] rx_ip_fragment_offset;
wire [7:0] rx_ip_ttl;
wire [7:0] rx_ip_protocol;
wire [15:0] rx_ip_header_checksum;
wire [31:0] rx_ip_source_ip;
wire [31:0] rx_ip_dest_ip;
wire [7:0] rx_ip_payload_axis_tdata;
wire rx_ip_payload_axis_tvalid;
wire rx_ip_payload_axis_tready;
wire rx_ip_payload_axis_tlast;
wire rx_ip_payload_axis_tuser;

wire tx_ip_hdr_valid;
wire tx_ip_hdr_ready;
wire [5:0] tx_ip_dscp;
wire [1:0] tx_ip_ecn;
wire [15:0] tx_ip_length;
wire [7:0] tx_ip_ttl;
wire [7:0] tx_ip_protocol;
wire [31:0] tx_ip_source_ip;
wire [31:0] tx_ip_dest_ip;
wire [7:0] tx_ip_payload_axis_tdata;
wire tx_ip_payload_axis_tvalid;
wire tx_ip_payload_axis_tready;
wire tx_ip_payload_axis_tlast;
wire tx_ip_payload_axis_tuser;

// UDP frame connections
wire rx_udp_hdr_valid;
wire rx_udp_hdr_ready;
wire [47:0] rx_udp_eth_dest_mac;
wire [47:0] rx_udp_eth_src_mac;
wire [15:0] rx_udp_eth_type;
wire [3:0] rx_udp_ip_version;
wire [3:0] rx_udp_ip_ihl;
wire [5:0] rx_udp_ip_dscp;
wire [1:0] rx_udp_ip_ecn;
wire [15:0] rx_udp_ip_length;
wire [15:0] rx_udp_ip_identification;
wire [2:0] rx_udp_ip_flags;
wire [12:0] rx_udp_ip_fragment_offset;
wire [7:0] rx_udp_ip_ttl;
wire [7:0] rx_udp_ip_protocol;
wire [15:0] rx_udp_ip_header_checksum;
wire [31:0] rx_udp_ip_source_ip;
wire [31:0] rx_udp_ip_dest_ip;
wire [15:0] rx_udp_source_port;
wire [15:0] rx_udp_dest_port;
wire [15:0] rx_udp_length;
wire [15:0] rx_udp_checksum;
wire [7:0] rx_udp_payload_axis_tdata;
wire rx_udp_payload_axis_tvalid;
wire rx_udp_payload_axis_tready;
wire rx_udp_payload_axis_tlast;
wire rx_udp_payload_axis_tuser;

wire tx_udp_hdr_valid;
wire tx_udp_hdr_ready;
wire [5:0] tx_udp_ip_dscp;
wire [1:0] tx_udp_ip_ecn;
wire [7:0] tx_udp_ip_ttl;
wire [31:0] tx_udp_ip_source_ip;
wire [31:0] tx_udp_ip_dest_ip;
wire [15:0] tx_udp_source_port;
wire [15:0] tx_udp_dest_port;
wire [15:0] tx_udp_length;
wire [15:0] tx_udp_checksum;
wire [7:0] tx_udp_payload_axis_tdata;
wire tx_udp_payload_axis_tvalid;
wire tx_udp_payload_axis_tready;
wire tx_udp_payload_axis_tlast;
wire tx_udp_payload_axis_tuser;


// Configuration
wire [47:0] local_mac   = 48'h11_22_33_44_55_66;
wire [47:0] dest_mac    = 48'h66_55_44_33_22_11;
wire [31:0] local_ip    = {8'd192, 8'd168, 8'd1, 8'd128};
wire [31:0] dest_ip     = {8'd192, 8'd168, 8'd1, 8'd120};
wire [31:0] gateway_ip  = {8'd192, 8'd168, 8'd1,   8'd1};
wire [31:0] subnet_mask = {8'd255, 8'd255, 8'd255, 8'd0};
wire [15:0] port_id = 16'd1234;

// IP ports not used
assign rx_ip_hdr_ready = 1;
assign rx_ip_payload_axis_tready = 1;

assign tx_ip_hdr_valid = 0;
assign tx_ip_dscp = 0;
assign tx_ip_ecn = 0;
assign tx_ip_length = 0;
assign tx_ip_ttl = 0;
assign tx_ip_protocol = 0;
assign tx_ip_source_ip = 0;
assign tx_ip_dest_ip = 0;
assign tx_ip_payload_axis_tdata = 0;
assign tx_ip_payload_axis_tvalid = 0;
assign tx_ip_payload_axis_tlast = 0;
assign tx_ip_payload_axis_tuser = 0;


// Loop back UDP
// wire match_cond = rx_udp_dest_port == 1234;
// wire no_match = !match_cond;

// reg match_cond_reg = 0;
// reg no_match_reg = 0;

assign rst = ~rst_n;

assign clk = logic_clk;

assign phy_reset_n = !rst;

// assign rgmii_rst_n = rst_n;

// always @(posedge clk) begin
//     if (rst) begin
//         match_cond_reg <= 0;
//         no_match_reg <= 0;
//     end else begin
//         if (rx_udp_payload_axis_tvalid) begin
//             if ((!match_cond_reg && !no_match_reg) ||
//                 (rx_udp_payload_axis_tvalid && rx_udp_payload_axis_tready && rx_udp_payload_axis_tlast)) begin
//                 match_cond_reg <= match_cond;
//                 no_match_reg <= no_match;
//             end
//         end else begin
//             match_cond_reg <= 0;
//             no_match_reg <= 0;
//         end
//     end
// end

assign tx_udp_hdr_valid = port_udp_tx_hdr_valid;
assign port_udp_tx_hdr_ready = tx_udp_hdr_ready;
assign rx_udp_hdr_ready = 1;

assign tx_udp_ip_dscp = 0;
assign tx_udp_ip_ecn = 0;
assign tx_udp_ip_ttl = 64;
assign tx_udp_ip_source_ip = local_ip;
assign tx_udp_ip_dest_ip = port_udp_tx_dest_ip;
assign tx_udp_source_port = rx_udp_dest_port;
assign tx_udp_dest_port = rx_udp_source_port;
assign tx_udp_length = port_udp_tx_length + 4'd9;
assign tx_udp_checksum = 0;

assign tx_udp_payload_axis_tdata = port_udp_tx_axis_payload_data;
assign tx_udp_payload_axis_tvalid = port_udp_tx_axis_valid;
assign port_udp_tx_axis_ready = tx_udp_payload_axis_tready;
assign tx_udp_payload_axis_tlast = port_udp_tx_axis_payload_last;
assign tx_udp_payload_axis_tuser = port_udp_tx_axis_payload_user;

assign rx_udp_payload_axis_tready =  1;

assign port_eth_tx_axis_valid = tx_eth_payload_axis_tvalid;
assign tx_eth_payload_axis_tready = port_eth_tx_axis_ready;
assign port_eth_tx_axis_payload_data = tx_eth_payload_axis_tdata;
assign port_eth_tx_axis_payload_user = tx_eth_payload_axis_tuser;
assign port_eth_tx_axis_payload_last = tx_eth_payload_axis_tlast;

// eth_mac_1g_rgmii_fifo #
// (
//     .TARGET(TARGET ),
//     .IODDR_STYLE (IODDR_STYLE ),
//     .CLOCK_INPUT_STYLE (CLOCK_INPUT_STYLE ),
//     .USE_CLK90 (USE_CLK90 ),
//     .AXIS_DATA_WIDTH (AXIS_DATA_WIDTH ),
//     .AXIS_KEEP_ENABLE (AXIS_KEEP_ENABLE ),
//     .AXIS_KEEP_WIDTH (AXIS_KEEP_WIDTH ),
//     .ENABLE_PADDING (ENABLE_PADDING ),
//     .MIN_FRAME_LENGTH (MIN_FRAME_LENGTH ),
//     .TX_FIFO_DEPTH (TX_FIFO_DEPTH ),
//     .TX_FIFO_RAM_PIPELINE(TX_FIFO_RAM_PIPELINE),
//     .TX_FRAME_FIFO (TX_FRAME_FIFO ),
//     .TX_DROP_OVERSIZE_FRAME (TX_DROP_OVERSIZE_FRAME),
//     .TX_DROP_BAD_FRAME (TX_DROP_BAD_FRAME ),
//     .TX_DROP_WHEN_FULL (TX_DROP_WHEN_FULL ),
//     .RX_FIFO_DEPTH (RX_FIFO_DEPTH ),
//     .RX_FIFO_RAM_PIPELINE (RX_FIFO_RAM_PIPELINE ),
//     .RX_FRAME_FIFO (RX_FRAME_FIFO ),
//     .RX_DROP_OVERSIZE_FRAME (RX_DROP_OVERSIZE_FRAME),
//     .RX_DROP_BAD_FRAME (RX_DROP_BAD_FRAME ),
//     .RX_DROP_WHEN_FULL (RX_DROP_WHEN_FULL )
// ) 
// eth_mac_1g_rgmii_fifo_inst(
//     .gtx_clk(gtx_clk),
//     .gtx_clk90(gtx_clk90),
//     .gtx_rst(rst),
//     .logic_clk(logic_clk),
//     .logic_rst(rst),

//     .tx_axis_tdata(tx_axis_tdata),
//     .tx_axis_tkeep(tx_axis_tkeep),
//     .tx_axis_tvalid(tx_axis_tvalid),
//     .tx_axis_tready(tx_axis_tready),
//     .tx_axis_tlast(tx_axis_tlast),
//     .tx_axis_tuser(tx_axis_tuser),

//     .rx_axis_tdata(rx_axis_tdata),
//     .rx_axis_tkeep(rx_axis_tkeep),
//     .rx_axis_tvalid(rx_axis_tvalid),
//     .rx_axis_tready(rx_axis_tready),
//     .rx_axis_tlast(rx_axis_tlast),
//     .rx_axis_tuser(rx_axis_tuser),

//     .rgmii_rx_clk(rgmii_rxc),
//     .rgmii_rxd(rgmii_rxd),
//     .rgmii_rx_ctl(rgmii_rx_ctl),
//     .rgmii_tx_clk(rgmii_txc),
//     .rgmii_txd(rgmii_txd),
//     .rgmii_tx_ctl (rgmii_tx_ctl ),

//     .tx_error_underflow(),
//     .tx_fifo_overflow(),
//     .tx_fifo_bad_frame(),
//     .tx_fifo_good_frame(),
//     .rx_error_bad_frame(),
//     .rx_error_bad_fcs(),
//     .rx_fifo_overflow(),
//     .rx_fifo_bad_frame(),
//     .rx_fifo_good_frame(),
//     .speed(speed),

//     .cfg_ifg(8'd12),
//     .cfg_tx_enable(1'd1),
//     .cfg_rx_enable(1'd1)
// );


// eth_axis_rx
// eth_axis_rx_inst (
//     .clk(clk),
//     .rst(rst),
//     // AXI input
//     .s_axis_tdata(rx_axis_tdata),
//     .s_axis_tvalid(rx_axis_tvalid),
//     .s_axis_tready(rx_axis_tready),
//     .s_axis_tlast(rx_axis_tlast),
//     .s_axis_tuser(rx_axis_tuser),
//     // Ethernet frame output
//     .m_eth_hdr_valid(rx_eth_hdr_valid),
//     .m_eth_hdr_ready(rx_eth_hdr_ready),
//     .m_eth_dest_mac(rx_eth_dest_mac),
//     .m_eth_src_mac(rx_eth_src_mac),
//     .m_eth_type(rx_eth_type),
//     .m_eth_payload_axis_tdata(rx_eth_payload_axis_tdata),
//     .m_eth_payload_axis_tvalid(rx_eth_payload_axis_tvalid),
//     .m_eth_payload_axis_tready(rx_eth_payload_axis_tready),
//     .m_eth_payload_axis_tlast(rx_eth_payload_axis_tlast),
//     .m_eth_payload_axis_tuser(rx_eth_payload_axis_tuser),
//     // Status signals
//     .busy(),
//     .error_header_early_termination()
// );


// eth_axis_tx
// eth_axis_tx_inst (
//     .clk(clk),
//     .rst(rst),
//     // Ethernet frame input
//     .s_eth_hdr_valid(tx_eth_hdr_valid),
//     .s_eth_hdr_ready(tx_eth_hdr_ready),
//     .s_eth_dest_mac(tx_eth_dest_mac),
//     .s_eth_src_mac(tx_eth_src_mac),
//     .s_eth_type(tx_eth_type),
//     .s_eth_payload_axis_tdata(0),
//     .s_eth_payload_axis_tvalid(0),
//     .s_eth_payload_axis_tready(),
//     .s_eth_payload_axis_tlast(0),
//     .s_eth_payload_axis_tuser(0),
//     // AXI output
//     .m_axis_tdata(tx_axis_tdata),
//     .m_axis_tvalid(tx_axis_tvalid),
//     .m_axis_tready(tx_axis_tready),
//     .m_axis_tlast(tx_axis_tlast),
//     .m_axis_tuser(tx_axis_tuser),
//     // Status signals
//     .busy()
// );

udp_complete_lite
udp_complete__lite_inst (
    .clk(clk),
    .rst(rst),
    // Ethernet frame input
    .s_eth_hdr_valid(rx_eth_hdr_valid),
    .s_eth_hdr_ready(rx_eth_hdr_ready),
    .s_eth_dest_mac(local_mac),
    .s_eth_src_mac(dest_mac),
    .s_eth_type(16'h0800),
    .s_eth_payload_axis_tdata(rx_eth_payload_axis_tdata),
    .s_eth_payload_axis_tvalid(rx_eth_payload_axis_tvalid),
    .s_eth_payload_axis_tready(rx_eth_payload_axis_tready),
    .s_eth_payload_axis_tlast(rx_eth_payload_axis_tlast),
    .s_eth_payload_axis_tuser(rx_eth_payload_axis_tuser),
    // Ethernet frame output
    .m_eth_hdr_valid(tx_eth_hdr_valid),
    .m_eth_hdr_ready(tx_eth_hdr_ready),
    .m_eth_dest_mac(tx_eth_dest_mac),
    .m_eth_src_mac(tx_eth_src_mac),
    .m_eth_type(tx_eth_type),
    .m_eth_payload_axis_tdata(tx_eth_payload_axis_tdata),
    .m_eth_payload_axis_tvalid(tx_eth_payload_axis_tvalid),
    .m_eth_payload_axis_tready(tx_eth_payload_axis_tready),
    .m_eth_payload_axis_tlast(tx_eth_payload_axis_tlast),
    .m_eth_payload_axis_tuser(tx_eth_payload_axis_tuser),
    // IP frame input
    .s_ip_hdr_valid(tx_ip_hdr_valid),
    .s_ip_hdr_ready(tx_ip_hdr_ready),
    .s_ip_dscp(tx_ip_dscp),
    .s_ip_ecn(tx_ip_ecn),
    .s_ip_length(tx_ip_length),
    .s_ip_ttl(tx_ip_ttl),
    .s_ip_protocol(tx_ip_protocol),
    .s_ip_source_ip(tx_ip_source_ip),
    .s_ip_dest_ip(tx_ip_dest_ip),
    .s_ip_payload_axis_tdata(tx_ip_payload_axis_tdata),
    .s_ip_payload_axis_tvalid(tx_ip_payload_axis_tvalid),
    .s_ip_payload_axis_tready(tx_ip_payload_axis_tready),
    .s_ip_payload_axis_tlast(tx_ip_payload_axis_tlast),
    .s_ip_payload_axis_tuser(tx_ip_payload_axis_tuser),
    // IP frame output
    .m_ip_hdr_valid(rx_ip_hdr_valid),
    .m_ip_hdr_ready(rx_ip_hdr_ready),
    .m_ip_eth_dest_mac(rx_ip_eth_dest_mac),
    .m_ip_eth_src_mac(rx_ip_eth_src_mac),
    .m_ip_eth_type(rx_ip_eth_type),
    .m_ip_version(rx_ip_version),
    .m_ip_ihl(rx_ip_ihl),
    .m_ip_dscp(rx_ip_dscp),
    .m_ip_ecn(rx_ip_ecn),
    .m_ip_length(rx_ip_length),
    .m_ip_identification(rx_ip_identification),
    .m_ip_flags(rx_ip_flags),
    .m_ip_fragment_offset(rx_ip_fragment_offset),
    .m_ip_ttl(rx_ip_ttl),
    .m_ip_protocol(rx_ip_protocol),
    .m_ip_header_checksum(rx_ip_header_checksum),
    .m_ip_source_ip(rx_ip_source_ip),
    .m_ip_dest_ip(rx_ip_dest_ip),
    .m_ip_payload_axis_tdata(rx_ip_payload_axis_tdata),
    .m_ip_payload_axis_tvalid(rx_ip_payload_axis_tvalid),
    .m_ip_payload_axis_tready(rx_ip_payload_axis_tready),
    .m_ip_payload_axis_tlast(rx_ip_payload_axis_tlast),
    .m_ip_payload_axis_tuser(rx_ip_payload_axis_tuser),
    // UDP frame input
    .s_udp_hdr_valid(tx_udp_hdr_valid),
    .s_udp_hdr_ready(tx_udp_hdr_ready),
    .s_udp_ip_dscp(tx_udp_ip_dscp),
    .s_udp_ip_ecn(tx_udp_ip_ecn),
    .s_udp_ip_ttl(tx_udp_ip_ttl),
    .s_udp_ip_source_ip(local_ip),
    .s_udp_ip_dest_ip(dest_ip),
    .s_udp_source_port(port_id),
    .s_udp_dest_port(port_id),
    .s_udp_length(tx_udp_length),
    .s_udp_checksum(tx_udp_checksum),
    .s_udp_payload_axis_tdata(tx_udp_payload_axis_tdata),
    .s_udp_payload_axis_tvalid(tx_udp_payload_axis_tvalid),
    .s_udp_payload_axis_tready(tx_udp_payload_axis_tready),
    .s_udp_payload_axis_tlast(tx_udp_payload_axis_tlast),
    .s_udp_payload_axis_tuser(tx_udp_payload_axis_tuser),
    // UDP frame output
    .m_udp_hdr_valid(rx_udp_hdr_valid),
    .m_udp_hdr_ready(rx_udp_hdr_ready),
    .m_udp_eth_dest_mac(rx_udp_eth_dest_mac),
    .m_udp_eth_src_mac(rx_udp_eth_src_mac),
    .m_udp_eth_type(rx_udp_eth_type),
    .m_udp_ip_version(rx_udp_ip_version),
    .m_udp_ip_ihl(rx_udp_ip_ihl),
    .m_udp_ip_dscp(rx_udp_ip_dscp),
    .m_udp_ip_ecn(rx_udp_ip_ecn),
    .m_udp_ip_length(rx_udp_ip_length),
    .m_udp_ip_identification(rx_udp_ip_identification),
    .m_udp_ip_flags(rx_udp_ip_flags),
    .m_udp_ip_fragment_offset(rx_udp_ip_fragment_offset),
    .m_udp_ip_ttl(rx_udp_ip_ttl),
    .m_udp_ip_protocol(rx_udp_ip_protocol),
    .m_udp_ip_header_checksum(rx_udp_ip_header_checksum),
    .m_udp_ip_source_ip(rx_udp_ip_source_ip),
    .m_udp_ip_dest_ip(rx_udp_ip_dest_ip),
    .m_udp_source_port(rx_udp_source_port),
    .m_udp_dest_port(rx_udp_dest_port),
    .m_udp_length(rx_udp_length),
    .m_udp_checksum(rx_udp_checksum),
    .m_udp_payload_axis_tdata(rx_udp_payload_axis_tdata),
    .m_udp_payload_axis_tvalid(rx_udp_payload_axis_tvalid),
    .m_udp_payload_axis_tready(rx_udp_payload_axis_tready),
    .m_udp_payload_axis_tlast(rx_udp_payload_axis_tlast),
    .m_udp_payload_axis_tuser(rx_udp_payload_axis_tuser),
    // Status signals
    .ip_rx_busy(),
    .ip_tx_busy(),
    .udp_rx_busy(),
    .udp_tx_busy(),
    .ip_rx_error_header_early_termination(),
    .ip_rx_error_payload_early_termination(),
    .ip_rx_error_invalid_header(),
    .ip_rx_error_invalid_checksum(),
    .ip_tx_error_payload_early_termination(),
    .ip_tx_error_arp_failed(),
    .udp_rx_error_header_early_termination(),
    .udp_rx_error_payload_early_termination(),
    .udp_tx_error_payload_early_termination(),
    // Configuration
    .local_mac(local_mac),
    .local_ip(local_ip),
    .gateway_ip(gateway_ip),
    .subnet_mask(subnet_mask),
    .clear_arp_cache(0)
);


endmodule