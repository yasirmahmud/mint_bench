`default_nettype none

module mint_stream_fabric_top (
    input  logic        clk,
    input  logic        rst_n,

    input  logic        in0_valid,
    output logic        in0_ready,
    input  logic [31:0] in0_data,
    input  logic        in0_last,

    input  logic        in1_valid,
    output logic        in1_ready,
    input  logic [31:0] in1_data,
    input  logic        in1_last,

    output logic        out_valid,
    input  logic        out_ready,
    output logic [31:0] out_data,
    output logic        out_last,
    output logic        out_sel,
    output logic [15:0] out_checksum,

    output logic [3:0]  fifo_level,
    output logic [31:0] out_beat_count,
    output logic [31:0] out_packet_count,
    output logic [31:0] out_src0_beat_count,
    output logic [31:0] out_src1_beat_count,
    output logic [31:0] out_src0_packet_count,
    output logic [31:0] out_src1_packet_count
);
    localparam int unsigned DATA_W = 32;
    localparam int unsigned USER_W = 1;

    localparam int unsigned FIFO_DEPTH = 8;
    localparam int unsigned FIFO_LEVEL_W = 4;

    logic              merge_valid;
    logic              merge_ready;
    logic [DATA_W-1:0] merge_data;
    logic              merge_last;
    logic [USER_W-1:0] merge_user;

    logic              fifo_valid;
    logic              fifo_ready;
    logic [DATA_W-1:0] fifo_data;
    logic              fifo_last;
    logic [USER_W-1:0] fifo_user;
    logic [FIFO_LEVEL_W-1:0] fifo_level_int;

    logic              pipe_valid;
    logic              pipe_ready;
    logic [DATA_W-1:0] pipe_data;
    logic              pipe_last;
    logic [USER_W-1:0] pipe_user;

    logic              chk_valid;
    logic              chk_ready;
    logic [DATA_W-1:0] chk_data;
    logic              chk_last;
    logic [USER_W-1:0] chk_user;
    logic [15:0]       chk_checksum;

    logic [8:0] bad_latch_vec;
    logic       bad_latch_xor;

    mint_stream_merge2 #(
        .DATA_W(DATA_W)
    ) u_merge2 (
        .clk(clk),
        .rst_n(rst_n),

        .s0_valid(in0_valid),
        .s0_ready(in0_ready),
        .s0_data(in0_data),
        .s0_last(in0_last),

        .s1_valid(in1_valid),
        .s1_ready(in1_ready),
        .s1_data(in1_data),
        .s1_last(in1_last),

        .m_valid(merge_valid),
        .m_ready(merge_ready),
        .m_data(merge_data),
        .m_last(merge_last),
        .m_user(merge_user)
    );

    mint_stream_fifo #(
        .DATA_W(DATA_W),
        .USER_W(USER_W),
        .DEPTH(FIFO_DEPTH),
        .LEVEL_W(FIFO_LEVEL_W)
    ) u_fifo (
        .clk(clk),
        .rst_n(rst_n),

        .s_valid(merge_valid),
        .s_ready(merge_ready),
        .s_data(merge_data),
        .s_last(merge_last),
        .s_user(merge_user),

        .m_valid(fifo_valid),
        .m_ready(fifo_ready),
        .m_data(fifo_data),
        .m_last(fifo_last),
        .m_user(fifo_user),

        .level(fifo_level_int)
    );

    mint_stream_regslice #(
        .DATA_W(DATA_W),
        .USER_W(USER_W)
    ) u_pipe (
        .clk(clk),
        .rst_n(rst_n),

        .s_valid(fifo_valid),
        .s_ready(fifo_ready),
        .s_data(fifo_data),
        .s_last(fifo_last),
        .s_user(fifo_user),

        .m_valid(pipe_valid),
        .m_ready(pipe_ready),
        .m_data(pipe_data),
        .m_last(pipe_last),
        .m_user(pipe_user)
    );

    mint_stream_checksum16 #(
        .DATA_W(DATA_W),
        .USER_W(USER_W)
    ) u_checksum (
        .clk(clk),
        .rst_n(rst_n),

        .s_valid(pipe_valid),
        .s_ready(pipe_ready),
        .s_data(pipe_data),
        .s_last(pipe_last),
        .s_user(pipe_user),

        .m_valid(chk_valid),
        .m_ready(chk_ready),
        .m_data(chk_data),
        .m_last(chk_last),
        .m_user(chk_user),
        .m_checksum(chk_checksum)
    );

    mint_latch_bank9 u_latch_bank9 (
        .ctrl({in0_valid, in1_valid, out_ready, chk_last}),
        .data_in(chk_data),
        .latch_vec(bad_latch_vec)
    );

    assign bad_latch_xor = ^bad_latch_vec;

    assign out_valid = chk_valid;
    assign chk_ready = out_ready;
    assign out_data = chk_data;
    assign out_last = chk_last;
    assign out_sel = chk_user[0] ^ bad_latch_xor;
    assign out_checksum = chk_checksum;

    assign fifo_level = fifo_level_int;

    mint_stream_stats #(
        .USER_W(USER_W),
        .CNT_W(32)
    ) u_stats (
        .clk(clk),
        .rst_n(rst_n),
        .tvalid(chk_valid),
        .tready(out_ready),
        .tlast(chk_last),
        .tuser(chk_user),
        .beat_count(out_beat_count),
        .packet_count(out_packet_count),
        .src0_beat_count(out_src0_beat_count),
        .src1_beat_count(out_src1_beat_count),
        .src0_packet_count(out_src0_packet_count),
        .src1_packet_count(out_src1_packet_count)
    );
endmodule

`default_nettype wire
