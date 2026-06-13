// SPDX-License-Identifier: MIT
//
// Performance monitor CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module cdc_perf_monitor_top (
    input  logic        core_clk,
    input  logic        trace_clk,
    input  logic        bus_clk,
    input  logic        core_rst_n,
    input  logic        trace_rst_n,
    input  logic        bus_rst_n,
    input  logic        sample_i,
    input  logic [31:0] counter_snapshot_i,
    input  logic [3:0]  trace_mode_i,
    input  logic        bus_sample_i,
    output logic [31:0] trace_status_o,
    output logic        trace_event_o,
    output logic [31:0] bus_snapshot_o
);
    logic [31:0] counter_snapshot_q;
    logic [3:0]  trace_mode_q;
    logic        sample_pulse_q;
    logic        sample_toggle_q;
    logic        sample_seen_q;
    logic [3:0]  trace_mode_meta_q;
    logic [3:0]  trace_mode_sync_q;
    logic        core_reset_seen_q;
    logic [31:0] trace_shadow_q;
    logic [31:0] bus_snapshot_q;

    always_ff @(posedge core_clk or negedge core_rst_n) begin
        if (!core_rst_n) begin
            counter_snapshot_q <= 32'd0;
            trace_mode_q <= 4'd0;
            sample_pulse_q <= 1'b0;
            sample_toggle_q <= 1'b0;
        end else begin
            counter_snapshot_q <= counter_snapshot_i + {24'd0, trace_mode_i, 4'd3};
            trace_mode_q <= trace_mode_i;
            sample_pulse_q <= sample_i;
            if (sample_i) begin
                sample_toggle_q <= ~sample_toggle_q;
            end
        end
    end

    always_ff @(posedge trace_clk or negedge trace_rst_n) begin
        if (!trace_rst_n) begin
            trace_status_o <= 32'd0;
            trace_event_o <= 1'b0;
            sample_seen_q <= 1'b0;
            trace_mode_meta_q <= 4'd0;
            trace_mode_sync_q <= 4'd0;
            core_reset_seen_q <= 1'b0;
            trace_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_PERF_MONITOR_001: multi-bit source payload is sampled without a coherency protocol.
            trace_status_o <= counter_snapshot_q;

            // CDC_CDC_PERF_MONITOR_002: one-cycle source pulse is consumed directly by the destination.
            if (sample_pulse_q) begin
                trace_shadow_q <= counter_snapshot_q;
            end

            sample_seen_q <= sample_toggle_q;
            // CDC_CDC_PERF_MONITOR_003: raw toggle reconverges with a one-sample destination history.
            trace_event_o <= sample_toggle_q ^ sample_seen_q;

            trace_mode_meta_q <= trace_mode_q;
            // CDC_CDC_PERF_MONITOR_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            trace_mode_sync_q <= trace_mode_meta_q;

            if (trace_mode_sync_q == 4'hA) begin
                trace_status_o[7:0] <= trace_shadow_q[7:0] ^ counter_snapshot_q[7:0];
            end

            // CDC_CDC_PERF_MONITOR_005: source reset is used as destination-domain data.
            if (!core_rst_n) begin
                core_reset_seen_q <= 1'b0;
            end else begin
                core_reset_seen_q <= core_reset_seen_q | sample_seen_q;
            end
        end
    end

    always_ff @(posedge bus_clk or negedge bus_rst_n) begin
        if (!bus_rst_n) begin
            bus_snapshot_q <= 32'd0;
            bus_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_PERF_MONITOR_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            bus_snapshot_q <= counter_snapshot_q ^ trace_status_o;
            if (bus_sample_i) begin
                bus_snapshot_o <= bus_snapshot_q;
            end
        end
    end
endmodule
