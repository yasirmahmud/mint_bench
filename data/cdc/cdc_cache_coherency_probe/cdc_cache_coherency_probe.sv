// SPDX-License-Identifier: MIT
//
// Cache coherency probe CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module cdc_cache_coherency_probe_top (
    input  logic        snoop_clk,
    input  logic        cache_clk,
    input  logic        core_clk,
    input  logic        snoop_rst_n,
    input  logic        cache_rst_n,
    input  logic        core_rst_n,
    input  logic        probe_i,
    input  logic [31:0] probe_bits_i,
    input  logic [3:0]  probe_mode_i,
    input  logic        core_sample_i,
    output logic [31:0] cache_status_o,
    output logic        cache_event_o,
    output logic [31:0] core_snapshot_o
);
    logic [31:0] probe_bits_q;
    logic [3:0]  probe_mode_q;
    logic        probe_pulse_q;
    logic        probe_toggle_q;
    logic        probe_seen_q;
    logic [3:0]  probe_mode_meta_q;
    logic [3:0]  probe_mode_sync_q;
    logic        snoop_reset_seen_q;
    logic [31:0] cache_shadow_q;
    logic [31:0] core_snapshot_q;

    always_ff @(posedge snoop_clk or negedge snoop_rst_n) begin
        if (!snoop_rst_n) begin
            probe_bits_q <= 32'd0;
            probe_mode_q <= 4'd0;
            probe_pulse_q <= 1'b0;
            probe_toggle_q <= 1'b0;
        end else begin
            probe_bits_q <= probe_bits_i + {24'd0, probe_mode_i, 4'd3};
            probe_mode_q <= probe_mode_i;
            probe_pulse_q <= probe_i;
            if (probe_i) begin
                probe_toggle_q <= ~probe_toggle_q;
            end
        end
    end

    always_ff @(posedge cache_clk or negedge cache_rst_n) begin
        if (!cache_rst_n) begin
            cache_status_o <= 32'd0;
            cache_event_o <= 1'b0;
            probe_seen_q <= 1'b0;
            probe_mode_meta_q <= 4'd0;
            probe_mode_sync_q <= 4'd0;
            snoop_reset_seen_q <= 1'b0;
            cache_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_CACHE_COHERENCY_PROBE_001: multi-bit source payload is sampled without a coherency protocol.
            cache_status_o <= probe_bits_q;

            // CDC_CDC_CACHE_COHERENCY_PROBE_002: one-cycle source pulse is consumed directly by the destination.
            if (probe_pulse_q) begin
                cache_shadow_q <= probe_bits_q;
            end

            probe_seen_q <= probe_toggle_q;
            // CDC_CDC_CACHE_COHERENCY_PROBE_003: raw toggle reconverges with a one-sample destination history.
            cache_event_o <= probe_toggle_q ^ probe_seen_q;

            probe_mode_meta_q <= probe_mode_q;
            // CDC_CDC_CACHE_COHERENCY_PROBE_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            probe_mode_sync_q <= probe_mode_meta_q;

            if (probe_mode_sync_q == 4'hA) begin
                cache_status_o[7:0] <= cache_shadow_q[7:0] ^ probe_bits_q[7:0];
            end

            // CDC_CDC_CACHE_COHERENCY_PROBE_005: source reset is used as destination-domain data.
            if (!snoop_rst_n) begin
                snoop_reset_seen_q <= 1'b0;
            end else begin
                snoop_reset_seen_q <= snoop_reset_seen_q | probe_seen_q;
            end
        end
    end

    always_ff @(posedge core_clk or negedge core_rst_n) begin
        if (!core_rst_n) begin
            core_snapshot_q <= 32'd0;
            core_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_CACHE_COHERENCY_PROBE_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            core_snapshot_q <= probe_bits_q ^ cache_status_o;
            if (core_sample_i) begin
                core_snapshot_o <= core_snapshot_q;
            end
        end
    end
endmodule
