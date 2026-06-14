// SPDX-License-Identifier: MIT
//
// Fuse shadow loader CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module fuse_shadow_top (
    input  logic        fuse_clk,
    input  logic        core_clk,
    input  logic        otp_clk,
    input  logic        fuse_rst_n,
    input  logic        core_rst_n,
    input  logic        otp_rst_n,
    input  logic        fuse_done_i,
    input  logic [31:0] fuse_word_i,
    input  logic [3:0]  shadow_mode_i,
    input  logic        otp_sample_i,
    output logic [31:0] core_status_o,
    output logic        core_event_o,
    output logic [31:0] otp_snapshot_o
);
    logic [31:0] fuse_word_q;
    logic [3:0]  shadow_mode_q;
    logic        fuse_done_pulse_q;
    logic        fuse_done_toggle_q;
    logic        fuse_done_seen_q;
    logic [3:0]  shadow_mode_meta_q;
    logic [3:0]  shadow_mode_sync_q;
    logic        fuse_reset_seen_q;
    logic [31:0] core_shadow_q;
    logic [31:0] otp_snapshot_q;

    always_ff @(posedge fuse_clk or negedge fuse_rst_n) begin
        if (!fuse_rst_n) begin
            fuse_word_q <= 32'd0;
            shadow_mode_q <= 4'd0;
            fuse_done_pulse_q <= 1'b0;
            fuse_done_toggle_q <= 1'b0;
        end else begin
            fuse_word_q <= fuse_word_i + {24'd0, shadow_mode_i, 4'd3};
            shadow_mode_q <= shadow_mode_i;
            fuse_done_pulse_q <= fuse_done_i;
            if (fuse_done_i) begin
                fuse_done_toggle_q <= ~fuse_done_toggle_q;
            end
        end
    end

    always_ff @(posedge core_clk or negedge core_rst_n) begin
        if (!core_rst_n) begin
            core_status_o <= 32'd0;
            core_event_o <= 1'b0;
            fuse_done_seen_q <= 1'b0;
            shadow_mode_meta_q <= 4'd0;
            shadow_mode_sync_q <= 4'd0;
            fuse_reset_seen_q <= 1'b0;
            core_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_FUSE_SHADOW_001: multi-bit source payload is sampled without a coherency protocol.
            core_status_o <= fuse_word_q;

            // CDC_CDC_FUSE_SHADOW_002: one-cycle source pulse is consumed directly by the destination.
            if (fuse_done_pulse_q) begin
                core_shadow_q <= fuse_word_q;
            end

            fuse_done_seen_q <= fuse_done_toggle_q;
            // CDC_CDC_FUSE_SHADOW_003: raw toggle reconverges with a one-sample destination history.
            core_event_o <= fuse_done_toggle_q ^ fuse_done_seen_q;

            shadow_mode_meta_q <= shadow_mode_q;
            // CDC_CDC_FUSE_SHADOW_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            shadow_mode_sync_q <= shadow_mode_meta_q;

            if (shadow_mode_sync_q == 4'hA) begin
                core_status_o[7:0] <= core_shadow_q[7:0] ^ fuse_word_q[7:0];
            end

            // CDC_CDC_FUSE_SHADOW_005: source reset is used as destination-domain data.
            if (!fuse_rst_n) begin
                fuse_reset_seen_q <= 1'b0;
            end else begin
                fuse_reset_seen_q <= fuse_reset_seen_q | fuse_done_seen_q;
            end
        end
    end

    always_ff @(posedge otp_clk or negedge otp_rst_n) begin
        if (!otp_rst_n) begin
            otp_snapshot_q <= 32'd0;
            otp_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_FUSE_SHADOW_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            otp_snapshot_q <= fuse_word_q ^ core_status_o;
            if (otp_sample_i) begin
                otp_snapshot_o <= otp_snapshot_q;
            end
        end
    end
endmodule
