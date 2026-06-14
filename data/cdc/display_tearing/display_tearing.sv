// SPDX-License-Identifier: MIT
//
// Display tearing-effect sync CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module display_tearing_top (
    input  logic        display_clk,
    input  logic        host_clk,
    input  logic        pixel_clk,
    input  logic        display_rst_n,
    input  logic        host_rst_n,
    input  logic        pixel_rst_n,
    input  logic        te_i,
    input  logic [31:0] te_state_i,
    input  logic [3:0]  panel_mode_i,
    input  logic        pixel_sample_i,
    output logic [31:0] host_status_o,
    output logic        host_event_o,
    output logic [31:0] pixel_snapshot_o
);
    logic [31:0] te_state_q;
    logic [3:0]  panel_mode_q;
    logic        te_pulse_q;
    logic        te_toggle_q;
    logic        te_seen_q;
    logic [3:0]  panel_mode_meta_q;
    logic [3:0]  panel_mode_sync_q;
    logic        display_reset_seen_q;
    logic [31:0] host_shadow_q;
    logic [31:0] pixel_snapshot_q;

    always_ff @(posedge display_clk or negedge display_rst_n) begin
        if (!display_rst_n) begin
            te_state_q <= 32'd0;
            panel_mode_q <= 4'd0;
            te_pulse_q <= 1'b0;
            te_toggle_q <= 1'b0;
        end else begin
            te_state_q <= te_state_i + {24'd0, panel_mode_i, 4'd3};
            panel_mode_q <= panel_mode_i;
            te_pulse_q <= te_i;
            if (te_i) begin
                te_toggle_q <= ~te_toggle_q;
            end
        end
    end

    always_ff @(posedge host_clk or negedge host_rst_n) begin
        if (!host_rst_n) begin
            host_status_o <= 32'd0;
            host_event_o <= 1'b0;
            te_seen_q <= 1'b0;
            panel_mode_meta_q <= 4'd0;
            panel_mode_sync_q <= 4'd0;
            display_reset_seen_q <= 1'b0;
            host_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_DISPLAY_TEARING_001: multi-bit source payload is sampled without a coherency protocol.
            host_status_o <= te_state_q;

            // CDC_CDC_DISPLAY_TEARING_002: one-cycle source pulse is consumed directly by the destination.
            if (te_pulse_q) begin
                host_shadow_q <= te_state_q;
            end

            te_seen_q <= te_toggle_q;
            // CDC_CDC_DISPLAY_TEARING_003: raw toggle reconverges with a one-sample destination history.
            host_event_o <= te_toggle_q ^ te_seen_q;

            panel_mode_meta_q <= panel_mode_q;
            // CDC_CDC_DISPLAY_TEARING_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            panel_mode_sync_q <= panel_mode_meta_q;

            if (panel_mode_sync_q == 4'hA) begin
                host_status_o[7:0] <= host_shadow_q[7:0] ^ te_state_q[7:0];
            end

            // CDC_CDC_DISPLAY_TEARING_005: source reset is used as destination-domain data.
            if (!display_rst_n) begin
                display_reset_seen_q <= 1'b0;
            end else begin
                display_reset_seen_q <= display_reset_seen_q | te_seen_q;
            end
        end
    end

    always_ff @(posedge pixel_clk or negedge pixel_rst_n) begin
        if (!pixel_rst_n) begin
            pixel_snapshot_q <= 32'd0;
            pixel_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_DISPLAY_TEARING_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            pixel_snapshot_q <= te_state_q ^ host_status_o;
            if (pixel_sample_i) begin
                pixel_snapshot_o <= pixel_snapshot_q;
            end
        end
    end
endmodule
