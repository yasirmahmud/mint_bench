// SPDX-License-Identifier: MIT
//
// DDR refresh controller CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module ddr_refresh_ctrl_top (
    input  logic        ddr_clk,
    input  logic        ctrl_clk,
    input  logic        apb_clk,
    input  logic        ddr_rst_n,
    input  logic        ctrl_rst_n,
    input  logic        apb_rst_n,
    input  logic        refresh_i,
    input  logic [31:0] refresh_state_i,
    input  logic [3:0]  rank_mode_i,
    input  logic        apb_sample_i,
    output logic [31:0] ctrl_status_o,
    output logic        ctrl_event_o,
    output logic [31:0] apb_snapshot_o
);
    logic [31:0] refresh_state_q;
    logic [3:0]  rank_mode_q;
    logic        refresh_pulse_q;
    logic        refresh_toggle_q;
    logic        refresh_seen_q;
    logic [3:0]  rank_mode_meta_q;
    logic [3:0]  rank_mode_sync_q;
    logic        ddr_reset_seen_q;
    logic [31:0] ctrl_shadow_q;
    logic [31:0] apb_snapshot_q;

    always_ff @(posedge ddr_clk or negedge ddr_rst_n) begin
        if (!ddr_rst_n) begin
            refresh_state_q <= 32'd0;
            rank_mode_q <= 4'd0;
            refresh_pulse_q <= 1'b0;
            refresh_toggle_q <= 1'b0;
        end else begin
            refresh_state_q <= refresh_state_i + {24'd0, rank_mode_i, 4'd3};
            rank_mode_q <= rank_mode_i;
            refresh_pulse_q <= refresh_i;
            if (refresh_i) begin
                refresh_toggle_q <= ~refresh_toggle_q;
            end
        end
    end

    always_ff @(posedge ctrl_clk or negedge ctrl_rst_n) begin
        if (!ctrl_rst_n) begin
            ctrl_status_o <= 32'd0;
            ctrl_event_o <= 1'b0;
            refresh_seen_q <= 1'b0;
            rank_mode_meta_q <= 4'd0;
            rank_mode_sync_q <= 4'd0;
            ddr_reset_seen_q <= 1'b0;
            ctrl_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_DDR_REFRESH_CTRL_001: multi-bit source payload is sampled without a coherency protocol.
            ctrl_status_o <= refresh_state_q;

            // CDC_CDC_DDR_REFRESH_CTRL_002: one-cycle source pulse is consumed directly by the destination.
            if (refresh_pulse_q) begin
                ctrl_shadow_q <= refresh_state_q;
            end

            refresh_seen_q <= refresh_toggle_q;
            // CDC_CDC_DDR_REFRESH_CTRL_003: raw toggle reconverges with a one-sample destination history.
            ctrl_event_o <= refresh_toggle_q ^ refresh_seen_q;

            rank_mode_meta_q <= rank_mode_q;
            // CDC_CDC_DDR_REFRESH_CTRL_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            rank_mode_sync_q <= rank_mode_meta_q;

            if (rank_mode_sync_q == 4'hA) begin
                ctrl_status_o[7:0] <= ctrl_shadow_q[7:0] ^ refresh_state_q[7:0];
            end

            // CDC_CDC_DDR_REFRESH_CTRL_005: source reset is used as destination-domain data.
            if (!ddr_rst_n) begin
                ddr_reset_seen_q <= 1'b0;
            end else begin
                ddr_reset_seen_q <= ddr_reset_seen_q | refresh_seen_q;
            end
        end
    end

    always_ff @(posedge apb_clk or negedge apb_rst_n) begin
        if (!apb_rst_n) begin
            apb_snapshot_q <= 32'd0;
            apb_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_DDR_REFRESH_CTRL_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            apb_snapshot_q <= refresh_state_q ^ ctrl_status_o;
            if (apb_sample_i) begin
                apb_snapshot_o <= apb_snapshot_q;
            end
        end
    end
endmodule
