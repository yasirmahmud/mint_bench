// SPDX-License-Identifier: MIT
//
// Timer capture block CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module timer_capture_top (
    input  logic        timer_clk,
    input  logic        apb_clk,
    input  logic        trace_clk,
    input  logic        timer_rst_n,
    input  logic        apb_rst_n,
    input  logic        trace_rst_n,
    input  logic        tick_i,
    input  logic [31:0] timer_count_i,
    input  logic [3:0]  capture_mode_i,
    input  logic        trace_sample_i,
    output logic [31:0] apb_status_o,
    output logic        apb_event_o,
    output logic [31:0] trace_snapshot_o
);
    logic [31:0] timer_count_q;
    logic [3:0]  capture_mode_q;
    logic        tick_pulse_q;
    logic        tick_toggle_q;
    logic        tick_seen_q;
    logic [3:0]  capture_mode_meta_q;
    logic [3:0]  capture_mode_sync_q;
    logic        timer_reset_seen_q;
    logic [31:0] apb_shadow_q;
    logic [31:0] trace_snapshot_q;

    always_ff @(posedge timer_clk or negedge timer_rst_n) begin
        if (!timer_rst_n) begin
            timer_count_q <= 32'd0;
            capture_mode_q <= 4'd0;
            tick_pulse_q <= 1'b0;
            tick_toggle_q <= 1'b0;
        end else begin
            timer_count_q <= timer_count_i + {24'd0, capture_mode_i, 4'd3};
            capture_mode_q <= capture_mode_i;
            tick_pulse_q <= tick_i;
            if (tick_i) begin
                tick_toggle_q <= ~tick_toggle_q;
            end
        end
    end

    always_ff @(posedge apb_clk or negedge apb_rst_n) begin
        if (!apb_rst_n) begin
            apb_status_o <= 32'd0;
            apb_event_o <= 1'b0;
            tick_seen_q <= 1'b0;
            capture_mode_meta_q <= 4'd0;
            capture_mode_sync_q <= 4'd0;
            timer_reset_seen_q <= 1'b0;
            apb_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_TIMER_CAPTURE_001: multi-bit source payload is sampled without a coherency protocol.
            apb_status_o <= timer_count_q;

            // CDC_CDC_TIMER_CAPTURE_002: one-cycle source pulse is consumed directly by the destination.
            if (tick_pulse_q) begin
                apb_shadow_q <= timer_count_q;
            end

            tick_seen_q <= tick_toggle_q;
            // CDC_CDC_TIMER_CAPTURE_003: raw toggle reconverges with a one-sample destination history.
            apb_event_o <= tick_toggle_q ^ tick_seen_q;

            capture_mode_meta_q <= capture_mode_q;
            // CDC_CDC_TIMER_CAPTURE_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            capture_mode_sync_q <= capture_mode_meta_q;

            if (capture_mode_sync_q == 4'hA) begin
                apb_status_o[7:0] <= apb_shadow_q[7:0] ^ timer_count_q[7:0];
            end

            // CDC_CDC_TIMER_CAPTURE_005: source reset is used as destination-domain data.
            if (!timer_rst_n) begin
                timer_reset_seen_q <= 1'b0;
            end else begin
                timer_reset_seen_q <= timer_reset_seen_q | tick_seen_q;
            end
        end
    end

    always_ff @(posedge trace_clk or negedge trace_rst_n) begin
        if (!trace_rst_n) begin
            trace_snapshot_q <= 32'd0;
            trace_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_TIMER_CAPTURE_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            trace_snapshot_q <= timer_count_q ^ apb_status_o;
            if (trace_sample_i) begin
                trace_snapshot_o <= trace_snapshot_q;
            end
        end
    end
endmodule
