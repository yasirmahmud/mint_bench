// SPDX-License-Identifier: MIT
//
// Packet timestamp bridge CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module packet_timestamp_top (
    input  logic        ptp_clk,
    input  logic        mac_clk,
    input  logic        csr_clk,
    input  logic        ptp_rst_n,
    input  logic        mac_rst_n,
    input  logic        csr_rst_n,
    input  logic        stamp_i,
    input  logic [31:0] timestamp_word_i,
    input  logic [3:0]  time_mode_i,
    input  logic        csr_sample_i,
    output logic [31:0] mac_status_o,
    output logic        mac_event_o,
    output logic [31:0] csr_snapshot_o
);
    logic [31:0] timestamp_word_q;
    logic [3:0]  time_mode_q;
    logic        stamp_pulse_q;
    logic        stamp_toggle_q;
    logic        stamp_seen_q;
    logic [3:0]  time_mode_meta_q;
    logic [3:0]  time_mode_sync_q;
    logic        ptp_reset_seen_q;
    logic [31:0] mac_shadow_q;
    logic [31:0] csr_snapshot_q;

    always_ff @(posedge ptp_clk or negedge ptp_rst_n) begin
        if (!ptp_rst_n) begin
            timestamp_word_q <= 32'd0;
            time_mode_q <= 4'd0;
            stamp_pulse_q <= 1'b0;
            stamp_toggle_q <= 1'b0;
        end else begin
            timestamp_word_q <= timestamp_word_i + {24'd0, time_mode_i, 4'd3};
            time_mode_q <= time_mode_i;
            stamp_pulse_q <= stamp_i;
            if (stamp_i) begin
                stamp_toggle_q <= ~stamp_toggle_q;
            end
        end
    end

    always_ff @(posedge mac_clk or negedge mac_rst_n) begin
        if (!mac_rst_n) begin
            mac_status_o <= 32'd0;
            mac_event_o <= 1'b0;
            stamp_seen_q <= 1'b0;
            time_mode_meta_q <= 4'd0;
            time_mode_sync_q <= 4'd0;
            ptp_reset_seen_q <= 1'b0;
            mac_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_PACKET_TIMESTAMP_001: multi-bit source payload is sampled without a coherency protocol.
            mac_status_o <= timestamp_word_q;

            // CDC_CDC_PACKET_TIMESTAMP_002: one-cycle source pulse is consumed directly by the destination.
            if (stamp_pulse_q) begin
                mac_shadow_q <= timestamp_word_q;
            end

            stamp_seen_q <= stamp_toggle_q;
            // CDC_CDC_PACKET_TIMESTAMP_003: raw toggle reconverges with a one-sample destination history.
            mac_event_o <= stamp_toggle_q ^ stamp_seen_q;

            time_mode_meta_q <= time_mode_q;
            // CDC_CDC_PACKET_TIMESTAMP_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            time_mode_sync_q <= time_mode_meta_q;

            if (time_mode_sync_q == 4'hA) begin
                mac_status_o[7:0] <= mac_shadow_q[7:0] ^ timestamp_word_q[7:0];
            end

            // CDC_CDC_PACKET_TIMESTAMP_005: source reset is used as destination-domain data.
            if (!ptp_rst_n) begin
                ptp_reset_seen_q <= 1'b0;
            end else begin
                ptp_reset_seen_q <= ptp_reset_seen_q | stamp_seen_q;
            end
        end
    end

    always_ff @(posedge csr_clk or negedge csr_rst_n) begin
        if (!csr_rst_n) begin
            csr_snapshot_q <= 32'd0;
            csr_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_PACKET_TIMESTAMP_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            csr_snapshot_q <= timestamp_word_q ^ mac_status_o;
            if (csr_sample_i) begin
                csr_snapshot_o <= csr_snapshot_q;
            end
        end
    end
endmodule
