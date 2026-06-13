// SPDX-License-Identifier: MIT
//
// Ethernet MAC statistics bridge CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module cdc_ethernet_mac_stats_top (
    input  logic        rxmac_clk,
    input  logic        csr_clk,
    input  logic        txmac_clk,
    input  logic        rxmac_rst_n,
    input  logic        csr_rst_n,
    input  logic        txmac_rst_n,
    input  logic        rx_good_i,
    input  logic [31:0] mac_stats_i,
    input  logic [3:0]  stat_sel_i,
    input  logic        txmac_sample_i,
    output logic [31:0] csr_status_o,
    output logic        csr_event_o,
    output logic [31:0] txmac_snapshot_o
);
    logic [31:0] mac_stats_q;
    logic [3:0]  stat_sel_q;
    logic        rx_good_pulse_q;
    logic        rx_good_toggle_q;
    logic        rx_good_seen_q;
    logic [3:0]  stat_sel_meta_q;
    logic [3:0]  stat_sel_sync_q;
    logic        rxmac_reset_seen_q;
    logic [31:0] csr_shadow_q;
    logic [31:0] txmac_snapshot_q;

    always_ff @(posedge rxmac_clk or negedge rxmac_rst_n) begin
        if (!rxmac_rst_n) begin
            mac_stats_q <= 32'd0;
            stat_sel_q <= 4'd0;
            rx_good_pulse_q <= 1'b0;
            rx_good_toggle_q <= 1'b0;
        end else begin
            mac_stats_q <= mac_stats_i + {24'd0, stat_sel_i, 4'd3};
            stat_sel_q <= stat_sel_i;
            rx_good_pulse_q <= rx_good_i;
            if (rx_good_i) begin
                rx_good_toggle_q <= ~rx_good_toggle_q;
            end
        end
    end

    always_ff @(posedge csr_clk or negedge csr_rst_n) begin
        if (!csr_rst_n) begin
            csr_status_o <= 32'd0;
            csr_event_o <= 1'b0;
            rx_good_seen_q <= 1'b0;
            stat_sel_meta_q <= 4'd0;
            stat_sel_sync_q <= 4'd0;
            rxmac_reset_seen_q <= 1'b0;
            csr_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_ETHERNET_MAC_STATS_001: multi-bit source payload is sampled without a coherency protocol.
            csr_status_o <= mac_stats_q;

            // CDC_CDC_ETHERNET_MAC_STATS_002: one-cycle source pulse is consumed directly by the destination.
            if (rx_good_pulse_q) begin
                csr_shadow_q <= mac_stats_q;
            end

            rx_good_seen_q <= rx_good_toggle_q;
            // CDC_CDC_ETHERNET_MAC_STATS_003: raw toggle reconverges with a one-sample destination history.
            csr_event_o <= rx_good_toggle_q ^ rx_good_seen_q;

            stat_sel_meta_q <= stat_sel_q;
            // CDC_CDC_ETHERNET_MAC_STATS_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            stat_sel_sync_q <= stat_sel_meta_q;

            if (stat_sel_sync_q == 4'hA) begin
                csr_status_o[7:0] <= csr_shadow_q[7:0] ^ mac_stats_q[7:0];
            end

            // CDC_CDC_ETHERNET_MAC_STATS_005: source reset is used as destination-domain data.
            if (!rxmac_rst_n) begin
                rxmac_reset_seen_q <= 1'b0;
            end else begin
                rxmac_reset_seen_q <= rxmac_reset_seen_q | rx_good_seen_q;
            end
        end
    end

    always_ff @(posedge txmac_clk or negedge txmac_rst_n) begin
        if (!txmac_rst_n) begin
            txmac_snapshot_q <= 32'd0;
            txmac_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_ETHERNET_MAC_STATS_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            txmac_snapshot_q <= mac_stats_q ^ csr_status_o;
            if (txmac_sample_i) begin
                txmac_snapshot_o <= txmac_snapshot_q;
            end
        end
    end
endmodule
