// SPDX-License-Identifier: MIT
//
// Satellite modem bridge CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module cdc_satellite_modem_top (
    input  logic        modem_clk,
    input  logic        host_clk,
    input  logic        rf_clk,
    input  logic        modem_rst_n,
    input  logic        host_rst_n,
    input  logic        rf_rst_n,
    input  logic        syncword_i,
    input  logic [31:0] modem_packet_i,
    input  logic [3:0]  link_mode_i,
    input  logic        rf_sample_i,
    output logic [31:0] host_status_o,
    output logic        host_event_o,
    output logic [31:0] rf_snapshot_o
);
    logic [31:0] modem_packet_q;
    logic [3:0]  link_mode_q;
    logic        syncword_pulse_q;
    logic        syncword_toggle_q;
    logic        syncword_seen_q;
    logic [3:0]  link_mode_meta_q;
    logic [3:0]  link_mode_sync_q;
    logic        modem_reset_seen_q;
    logic [31:0] host_shadow_q;
    logic [31:0] rf_snapshot_q;

    always_ff @(posedge modem_clk or negedge modem_rst_n) begin
        if (!modem_rst_n) begin
            modem_packet_q <= 32'd0;
            link_mode_q <= 4'd0;
            syncword_pulse_q <= 1'b0;
            syncword_toggle_q <= 1'b0;
        end else begin
            modem_packet_q <= modem_packet_i + {24'd0, link_mode_i, 4'd3};
            link_mode_q <= link_mode_i;
            syncword_pulse_q <= syncword_i;
            if (syncword_i) begin
                syncword_toggle_q <= ~syncword_toggle_q;
            end
        end
    end

    always_ff @(posedge host_clk or negedge host_rst_n) begin
        if (!host_rst_n) begin
            host_status_o <= 32'd0;
            host_event_o <= 1'b0;
            syncword_seen_q <= 1'b0;
            link_mode_meta_q <= 4'd0;
            link_mode_sync_q <= 4'd0;
            modem_reset_seen_q <= 1'b0;
            host_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_SATELLITE_MODEM_001: multi-bit source payload is sampled without a coherency protocol.
            host_status_o <= modem_packet_q;

            // CDC_CDC_SATELLITE_MODEM_002: one-cycle source pulse is consumed directly by the destination.
            if (syncword_pulse_q) begin
                host_shadow_q <= modem_packet_q;
            end

            syncword_seen_q <= syncword_toggle_q;
            // CDC_CDC_SATELLITE_MODEM_003: raw toggle reconverges with a one-sample destination history.
            host_event_o <= syncword_toggle_q ^ syncword_seen_q;

            link_mode_meta_q <= link_mode_q;
            // CDC_CDC_SATELLITE_MODEM_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            link_mode_sync_q <= link_mode_meta_q;

            if (link_mode_sync_q == 4'hA) begin
                host_status_o[7:0] <= host_shadow_q[7:0] ^ modem_packet_q[7:0];
            end

            // CDC_CDC_SATELLITE_MODEM_005: source reset is used as destination-domain data.
            if (!modem_rst_n) begin
                modem_reset_seen_q <= 1'b0;
            end else begin
                modem_reset_seen_q <= modem_reset_seen_q | syncword_seen_q;
            end
        end
    end

    always_ff @(posedge rf_clk or negedge rf_rst_n) begin
        if (!rf_rst_n) begin
            rf_snapshot_q <= 32'd0;
            rf_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_SATELLITE_MODEM_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            rf_snapshot_q <= modem_packet_q ^ host_status_o;
            if (rf_sample_i) begin
                rf_snapshot_o <= rf_snapshot_q;
            end
        end
    end
endmodule
