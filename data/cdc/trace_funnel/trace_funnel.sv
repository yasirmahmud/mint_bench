// SPDX-License-Identifier: MIT
//
// Trace funnel CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module trace_funnel_top (
    input  logic        trace_clk,
    input  logic        fabric_clk,
    input  logic        debug_clk,
    input  logic        trace_rst_n,
    input  logic        fabric_rst_n,
    input  logic        debug_rst_n,
    input  logic        trace_valid_i,
    input  logic [31:0] trace_word_i,
    input  logic [3:0]  funnel_mode_i,
    input  logic        debug_sample_i,
    output logic [31:0] fabric_status_o,
    output logic        fabric_event_o,
    output logic [31:0] debug_snapshot_o
);
    logic [31:0] trace_word_q;
    logic [3:0]  funnel_mode_q;
    logic        trace_valid_pulse_q;
    logic        trace_valid_toggle_q;
    logic        trace_valid_seen_q;
    logic [3:0]  funnel_mode_meta_q;
    logic [3:0]  funnel_mode_sync_q;
    logic        trace_reset_seen_q;
    logic [31:0] fabric_shadow_q;
    logic [31:0] debug_snapshot_q;

    always_ff @(posedge trace_clk or negedge trace_rst_n) begin
        if (!trace_rst_n) begin
            trace_word_q <= 32'd0;
            funnel_mode_q <= 4'd0;
            trace_valid_pulse_q <= 1'b0;
            trace_valid_toggle_q <= 1'b0;
        end else begin
            trace_word_q <= trace_word_i + {24'd0, funnel_mode_i, 4'd3};
            funnel_mode_q <= funnel_mode_i;
            trace_valid_pulse_q <= trace_valid_i;
            if (trace_valid_i) begin
                trace_valid_toggle_q <= ~trace_valid_toggle_q;
            end
        end
    end

    always_ff @(posedge fabric_clk or negedge fabric_rst_n) begin
        if (!fabric_rst_n) begin
            fabric_status_o <= 32'd0;
            fabric_event_o <= 1'b0;
            trace_valid_seen_q <= 1'b0;
            funnel_mode_meta_q <= 4'd0;
            funnel_mode_sync_q <= 4'd0;
            trace_reset_seen_q <= 1'b0;
            fabric_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_TRACE_FUNNEL_001: multi-bit source payload is sampled without a coherency protocol.
            fabric_status_o <= trace_word_q;

            // CDC_CDC_TRACE_FUNNEL_002: one-cycle source pulse is consumed directly by the destination.
            if (trace_valid_pulse_q) begin
                fabric_shadow_q <= trace_word_q;
            end

            trace_valid_seen_q <= trace_valid_toggle_q;
            // CDC_CDC_TRACE_FUNNEL_003: raw toggle reconverges with a one-sample destination history.
            fabric_event_o <= trace_valid_toggle_q ^ trace_valid_seen_q;

            funnel_mode_meta_q <= funnel_mode_q;
            // CDC_CDC_TRACE_FUNNEL_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            funnel_mode_sync_q <= funnel_mode_meta_q;

            if (funnel_mode_sync_q == 4'hA) begin
                fabric_status_o[7:0] <= fabric_shadow_q[7:0] ^ trace_word_q[7:0];
            end

            // CDC_CDC_TRACE_FUNNEL_005: source reset is used as destination-domain data.
            if (!trace_rst_n) begin
                trace_reset_seen_q <= 1'b0;
            end else begin
                trace_reset_seen_q <= trace_reset_seen_q | trace_valid_seen_q;
            end
        end
    end

    always_ff @(posedge debug_clk or negedge debug_rst_n) begin
        if (!debug_rst_n) begin
            debug_snapshot_q <= 32'd0;
            debug_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_TRACE_FUNNEL_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            debug_snapshot_q <= trace_word_q ^ fabric_status_o;
            if (debug_sample_i) begin
                debug_snapshot_o <= debug_snapshot_q;
            end
        end
    end
endmodule
