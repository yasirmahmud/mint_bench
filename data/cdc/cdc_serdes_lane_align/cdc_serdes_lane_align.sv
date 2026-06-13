// SPDX-License-Identifier: MIT
//
// SERDES lane alignment CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module cdc_serdes_lane_align_top (
    input  logic        serdes_clk,
    input  logic        link_clk,
    input  logic        cfg_clk,
    input  logic        serdes_rst_n,
    input  logic        link_rst_n,
    input  logic        cfg_rst_n,
    input  logic        comma_i,
    input  logic [31:0] lane_marker_i,
    input  logic [3:0]  align_mode_i,
    input  logic        cfg_sample_i,
    output logic [31:0] link_status_o,
    output logic        link_event_o,
    output logic [31:0] cfg_snapshot_o
);
    logic [31:0] lane_marker_q;
    logic [3:0]  align_mode_q;
    logic        comma_pulse_q;
    logic        comma_toggle_q;
    logic        comma_seen_q;
    logic [3:0]  align_mode_meta_q;
    logic [3:0]  align_mode_sync_q;
    logic        serdes_reset_seen_q;
    logic [31:0] link_shadow_q;
    logic [31:0] cfg_snapshot_q;

    always_ff @(posedge serdes_clk or negedge serdes_rst_n) begin
        if (!serdes_rst_n) begin
            lane_marker_q <= 32'd0;
            align_mode_q <= 4'd0;
            comma_pulse_q <= 1'b0;
            comma_toggle_q <= 1'b0;
        end else begin
            lane_marker_q <= lane_marker_i + {24'd0, align_mode_i, 4'd3};
            align_mode_q <= align_mode_i;
            comma_pulse_q <= comma_i;
            if (comma_i) begin
                comma_toggle_q <= ~comma_toggle_q;
            end
        end
    end

    always_ff @(posedge link_clk or negedge link_rst_n) begin
        if (!link_rst_n) begin
            link_status_o <= 32'd0;
            link_event_o <= 1'b0;
            comma_seen_q <= 1'b0;
            align_mode_meta_q <= 4'd0;
            align_mode_sync_q <= 4'd0;
            serdes_reset_seen_q <= 1'b0;
            link_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_SERDES_LANE_ALIGN_001: multi-bit source payload is sampled without a coherency protocol.
            link_status_o <= lane_marker_q;

            // CDC_CDC_SERDES_LANE_ALIGN_002: one-cycle source pulse is consumed directly by the destination.
            if (comma_pulse_q) begin
                link_shadow_q <= lane_marker_q;
            end

            comma_seen_q <= comma_toggle_q;
            // CDC_CDC_SERDES_LANE_ALIGN_003: raw toggle reconverges with a one-sample destination history.
            link_event_o <= comma_toggle_q ^ comma_seen_q;

            align_mode_meta_q <= align_mode_q;
            // CDC_CDC_SERDES_LANE_ALIGN_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            align_mode_sync_q <= align_mode_meta_q;

            if (align_mode_sync_q == 4'hA) begin
                link_status_o[7:0] <= link_shadow_q[7:0] ^ lane_marker_q[7:0];
            end

            // CDC_CDC_SERDES_LANE_ALIGN_005: source reset is used as destination-domain data.
            if (!serdes_rst_n) begin
                serdes_reset_seen_q <= 1'b0;
            end else begin
                serdes_reset_seen_q <= serdes_reset_seen_q | comma_seen_q;
            end
        end
    end

    always_ff @(posedge cfg_clk or negedge cfg_rst_n) begin
        if (!cfg_rst_n) begin
            cfg_snapshot_q <= 32'd0;
            cfg_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_SERDES_LANE_ALIGN_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            cfg_snapshot_q <= lane_marker_q ^ link_status_o;
            if (cfg_sample_i) begin
                cfg_snapshot_o <= cfg_snapshot_q;
            end
        end
    end
endmodule
