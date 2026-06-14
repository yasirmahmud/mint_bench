// SPDX-License-Identifier: MIT
//
// HBM channel status bridge CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module hbm_channel_status_top (
    input  logic        hbm_clk,
    input  logic        noc_clk,
    input  logic        cfg_clk,
    input  logic        hbm_rst_n,
    input  logic        noc_rst_n,
    input  logic        cfg_rst_n,
    input  logic        alert_i,
    input  logic [31:0] channel_status_i,
    input  logic [3:0]  stack_mode_i,
    input  logic        cfg_sample_i,
    output logic [31:0] noc_status_o,
    output logic        noc_event_o,
    output logic [31:0] cfg_snapshot_o
);
    logic [31:0] channel_status_q;
    logic [3:0]  stack_mode_q;
    logic        alert_pulse_q;
    logic        alert_toggle_q;
    logic        alert_seen_q;
    logic [3:0]  stack_mode_meta_q;
    logic [3:0]  stack_mode_sync_q;
    logic        hbm_reset_seen_q;
    logic [31:0] noc_shadow_q;
    logic [31:0] cfg_snapshot_q;

    always_ff @(posedge hbm_clk or negedge hbm_rst_n) begin
        if (!hbm_rst_n) begin
            channel_status_q <= 32'd0;
            stack_mode_q <= 4'd0;
            alert_pulse_q <= 1'b0;
            alert_toggle_q <= 1'b0;
        end else begin
            channel_status_q <= channel_status_i + {24'd0, stack_mode_i, 4'd3};
            stack_mode_q <= stack_mode_i;
            alert_pulse_q <= alert_i;
            if (alert_i) begin
                alert_toggle_q <= ~alert_toggle_q;
            end
        end
    end

    always_ff @(posedge noc_clk or negedge noc_rst_n) begin
        if (!noc_rst_n) begin
            noc_status_o <= 32'd0;
            noc_event_o <= 1'b0;
            alert_seen_q <= 1'b0;
            stack_mode_meta_q <= 4'd0;
            stack_mode_sync_q <= 4'd0;
            hbm_reset_seen_q <= 1'b0;
            noc_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_HBM_CHANNEL_STATUS_001: multi-bit source payload is sampled without a coherency protocol.
            noc_status_o <= channel_status_q;

            // CDC_CDC_HBM_CHANNEL_STATUS_002: one-cycle source pulse is consumed directly by the destination.
            if (alert_pulse_q) begin
                noc_shadow_q <= channel_status_q;
            end

            alert_seen_q <= alert_toggle_q;
            // CDC_CDC_HBM_CHANNEL_STATUS_003: raw toggle reconverges with a one-sample destination history.
            noc_event_o <= alert_toggle_q ^ alert_seen_q;

            stack_mode_meta_q <= stack_mode_q;
            // CDC_CDC_HBM_CHANNEL_STATUS_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            stack_mode_sync_q <= stack_mode_meta_q;

            if (stack_mode_sync_q == 4'hA) begin
                noc_status_o[7:0] <= noc_shadow_q[7:0] ^ channel_status_q[7:0];
            end

            // CDC_CDC_HBM_CHANNEL_STATUS_005: source reset is used as destination-domain data.
            if (!hbm_rst_n) begin
                hbm_reset_seen_q <= 1'b0;
            end else begin
                hbm_reset_seen_q <= hbm_reset_seen_q | alert_seen_q;
            end
        end
    end

    always_ff @(posedge cfg_clk or negedge cfg_rst_n) begin
        if (!cfg_rst_n) begin
            cfg_snapshot_q <= 32'd0;
            cfg_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_HBM_CHANNEL_STATUS_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            cfg_snapshot_q <= channel_status_q ^ noc_status_o;
            if (cfg_sample_i) begin
                cfg_snapshot_o <= cfg_snapshot_q;
            end
        end
    end
endmodule
