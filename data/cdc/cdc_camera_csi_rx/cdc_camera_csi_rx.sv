// SPDX-License-Identifier: MIT
//
// Camera CSI receiver CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module cdc_camera_csi_rx_top (
    input  logic        csi_clk,
    input  logic        isp_clk,
    input  logic        cfg_clk,
    input  logic        csi_rst_n,
    input  logic        isp_rst_n,
    input  logic        cfg_rst_n,
    input  logic        sof_i,
    input  logic [31:0] frame_header_i,
    input  logic [3:0]  lane_mode_i,
    input  logic        cfg_sample_i,
    output logic [31:0] isp_status_o,
    output logic        isp_event_o,
    output logic [31:0] cfg_snapshot_o
);
    logic [31:0] frame_header_q;
    logic [3:0]  lane_mode_q;
    logic        sof_pulse_q;
    logic        sof_toggle_q;
    logic        sof_seen_q;
    logic [3:0]  lane_mode_meta_q;
    logic [3:0]  lane_mode_sync_q;
    logic        csi_reset_seen_q;
    logic [31:0] isp_shadow_q;
    logic [31:0] cfg_snapshot_q;

    always_ff @(posedge csi_clk or negedge csi_rst_n) begin
        if (!csi_rst_n) begin
            frame_header_q <= 32'd0;
            lane_mode_q <= 4'd0;
            sof_pulse_q <= 1'b0;
            sof_toggle_q <= 1'b0;
        end else begin
            frame_header_q <= frame_header_i + {24'd0, lane_mode_i, 4'd3};
            lane_mode_q <= lane_mode_i;
            sof_pulse_q <= sof_i;
            if (sof_i) begin
                sof_toggle_q <= ~sof_toggle_q;
            end
        end
    end

    always_ff @(posedge isp_clk or negedge isp_rst_n) begin
        if (!isp_rst_n) begin
            isp_status_o <= 32'd0;
            isp_event_o <= 1'b0;
            sof_seen_q <= 1'b0;
            lane_mode_meta_q <= 4'd0;
            lane_mode_sync_q <= 4'd0;
            csi_reset_seen_q <= 1'b0;
            isp_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_CAMERA_CSI_RX_001: multi-bit source payload is sampled without a coherency protocol.
            isp_status_o <= frame_header_q;

            // CDC_CDC_CAMERA_CSI_RX_002: one-cycle source pulse is consumed directly by the destination.
            if (sof_pulse_q) begin
                isp_shadow_q <= frame_header_q;
            end

            sof_seen_q <= sof_toggle_q;
            // CDC_CDC_CAMERA_CSI_RX_003: raw toggle reconverges with a one-sample destination history.
            isp_event_o <= sof_toggle_q ^ sof_seen_q;

            lane_mode_meta_q <= lane_mode_q;
            // CDC_CDC_CAMERA_CSI_RX_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            lane_mode_sync_q <= lane_mode_meta_q;

            if (lane_mode_sync_q == 4'hA) begin
                isp_status_o[7:0] <= isp_shadow_q[7:0] ^ frame_header_q[7:0];
            end

            // CDC_CDC_CAMERA_CSI_RX_005: source reset is used as destination-domain data.
            if (!csi_rst_n) begin
                csi_reset_seen_q <= 1'b0;
            end else begin
                csi_reset_seen_q <= csi_reset_seen_q | sof_seen_q;
            end
        end
    end

    always_ff @(posedge cfg_clk or negedge cfg_rst_n) begin
        if (!cfg_rst_n) begin
            cfg_snapshot_q <= 32'd0;
            cfg_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_CAMERA_CSI_RX_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            cfg_snapshot_q <= frame_header_q ^ isp_status_o;
            if (cfg_sample_i) begin
                cfg_snapshot_o <= cfg_snapshot_q;
            end
        end
    end
endmodule
