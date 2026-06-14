// SPDX-License-Identifier: MIT
//
// Video frame synchronizer CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module video_frame_sync_top (
    input  logic        pixel_clk,
    input  logic        system_clk,
    input  logic        display_clk,
    input  logic        pixel_rst_n,
    input  logic        system_rst_n,
    input  logic        display_rst_n,
    input  logic        vsync_i,
    input  logic [31:0] frame_meta_i,
    input  logic [3:0]  color_mode_i,
    input  logic        display_sample_i,
    output logic [31:0] system_status_o,
    output logic        system_event_o,
    output logic [31:0] display_snapshot_o
);
    logic [31:0] frame_meta_q;
    logic [3:0]  color_mode_q;
    logic        vsync_pulse_q;
    logic        vsync_toggle_q;
    logic        vsync_seen_q;
    logic [3:0]  color_mode_meta_q;
    logic [3:0]  color_mode_sync_q;
    logic        pixel_reset_seen_q;
    logic [31:0] system_shadow_q;
    logic [31:0] display_snapshot_q;

    always_ff @(posedge pixel_clk or negedge pixel_rst_n) begin
        if (!pixel_rst_n) begin
            frame_meta_q <= 32'd0;
            color_mode_q <= 4'd0;
            vsync_pulse_q <= 1'b0;
            vsync_toggle_q <= 1'b0;
        end else begin
            frame_meta_q <= frame_meta_i + {24'd0, color_mode_i, 4'd3};
            color_mode_q <= color_mode_i;
            vsync_pulse_q <= vsync_i;
            if (vsync_i) begin
                vsync_toggle_q <= ~vsync_toggle_q;
            end
        end
    end

    always_ff @(posedge system_clk or negedge system_rst_n) begin
        if (!system_rst_n) begin
            system_status_o <= 32'd0;
            system_event_o <= 1'b0;
            vsync_seen_q <= 1'b0;
            color_mode_meta_q <= 4'd0;
            color_mode_sync_q <= 4'd0;
            pixel_reset_seen_q <= 1'b0;
            system_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_VIDEO_FRAME_SYNC_001: multi-bit source payload is sampled without a coherency protocol.
            system_status_o <= frame_meta_q;

            // CDC_CDC_VIDEO_FRAME_SYNC_002: one-cycle source pulse is consumed directly by the destination.
            if (vsync_pulse_q) begin
                system_shadow_q <= frame_meta_q;
            end

            vsync_seen_q <= vsync_toggle_q;
            // CDC_CDC_VIDEO_FRAME_SYNC_003: raw toggle reconverges with a one-sample destination history.
            system_event_o <= vsync_toggle_q ^ vsync_seen_q;

            color_mode_meta_q <= color_mode_q;
            // CDC_CDC_VIDEO_FRAME_SYNC_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            color_mode_sync_q <= color_mode_meta_q;

            if (color_mode_sync_q == 4'hA) begin
                system_status_o[7:0] <= system_shadow_q[7:0] ^ frame_meta_q[7:0];
            end

            // CDC_CDC_VIDEO_FRAME_SYNC_005: source reset is used as destination-domain data.
            if (!pixel_rst_n) begin
                pixel_reset_seen_q <= 1'b0;
            end else begin
                pixel_reset_seen_q <= pixel_reset_seen_q | vsync_seen_q;
            end
        end
    end

    always_ff @(posedge display_clk or negedge display_rst_n) begin
        if (!display_rst_n) begin
            display_snapshot_q <= 32'd0;
            display_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_VIDEO_FRAME_SYNC_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            display_snapshot_q <= frame_meta_q ^ system_status_o;
            if (display_sample_i) begin
                display_snapshot_o <= display_snapshot_q;
            end
        end
    end
endmodule
