// SPDX-License-Identifier: MIT
//
// Debug breakpoint bridge CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module cdc_debug_breakpoint_top (
    input  logic        debug_clk,
    input  logic        core_clk,
    input  logic        trace_clk,
    input  logic        debug_rst_n,
    input  logic        core_rst_n,
    input  logic        trace_rst_n,
    input  logic        break_hit_i,
    input  logic [31:0] break_state_i,
    input  logic [3:0]  halt_mode_i,
    input  logic        trace_sample_i,
    output logic [31:0] core_status_o,
    output logic        core_event_o,
    output logic [31:0] trace_snapshot_o
);
    logic [31:0] break_state_q;
    logic [3:0]  halt_mode_q;
    logic        break_hit_pulse_q;
    logic        break_hit_toggle_q;
    logic        break_hit_seen_q;
    logic [3:0]  halt_mode_meta_q;
    logic [3:0]  halt_mode_sync_q;
    logic        debug_reset_seen_q;
    logic [31:0] core_shadow_q;
    logic [31:0] trace_snapshot_q;

    always_ff @(posedge debug_clk or negedge debug_rst_n) begin
        if (!debug_rst_n) begin
            break_state_q <= 32'd0;
            halt_mode_q <= 4'd0;
            break_hit_pulse_q <= 1'b0;
            break_hit_toggle_q <= 1'b0;
        end else begin
            break_state_q <= break_state_i + {24'd0, halt_mode_i, 4'd3};
            halt_mode_q <= halt_mode_i;
            break_hit_pulse_q <= break_hit_i;
            if (break_hit_i) begin
                break_hit_toggle_q <= ~break_hit_toggle_q;
            end
        end
    end

    always_ff @(posedge core_clk or negedge core_rst_n) begin
        if (!core_rst_n) begin
            core_status_o <= 32'd0;
            core_event_o <= 1'b0;
            break_hit_seen_q <= 1'b0;
            halt_mode_meta_q <= 4'd0;
            halt_mode_sync_q <= 4'd0;
            debug_reset_seen_q <= 1'b0;
            core_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_DEBUG_BREAKPOINT_001: multi-bit source payload is sampled without a coherency protocol.
            core_status_o <= break_state_q;

            // CDC_CDC_DEBUG_BREAKPOINT_002: one-cycle source pulse is consumed directly by the destination.
            if (break_hit_pulse_q) begin
                core_shadow_q <= break_state_q;
            end

            break_hit_seen_q <= break_hit_toggle_q;
            // CDC_CDC_DEBUG_BREAKPOINT_003: raw toggle reconverges with a one-sample destination history.
            core_event_o <= break_hit_toggle_q ^ break_hit_seen_q;

            halt_mode_meta_q <= halt_mode_q;
            // CDC_CDC_DEBUG_BREAKPOINT_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            halt_mode_sync_q <= halt_mode_meta_q;

            if (halt_mode_sync_q == 4'hA) begin
                core_status_o[7:0] <= core_shadow_q[7:0] ^ break_state_q[7:0];
            end

            // CDC_CDC_DEBUG_BREAKPOINT_005: source reset is used as destination-domain data.
            if (!debug_rst_n) begin
                debug_reset_seen_q <= 1'b0;
            end else begin
                debug_reset_seen_q <= debug_reset_seen_q | break_hit_seen_q;
            end
        end
    end

    always_ff @(posedge trace_clk or negedge trace_rst_n) begin
        if (!trace_rst_n) begin
            trace_snapshot_q <= 32'd0;
            trace_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_DEBUG_BREAKPOINT_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            trace_snapshot_q <= break_state_q ^ core_status_o;
            if (trace_sample_i) begin
                trace_snapshot_o <= trace_snapshot_q;
            end
        end
    end
endmodule
