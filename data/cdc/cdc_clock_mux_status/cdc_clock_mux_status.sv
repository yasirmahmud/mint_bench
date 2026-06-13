// SPDX-License-Identifier: MIT
//
// Clock mux status monitor CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module cdc_clock_mux_status_top (
    input  logic        scan_clk,
    input  logic        func_clk,
    input  logic        cfg_clk,
    input  logic        scan_rst_n,
    input  logic        func_rst_n,
    input  logic        cfg_rst_n,
    input  logic        scan_done_i,
    input  logic [31:0] mux_status_i,
    input  logic [3:0]  select_i,
    input  logic        cfg_sample_i,
    output logic [31:0] func_status_o,
    output logic        func_event_o,
    output logic [31:0] cfg_snapshot_o
);
    logic [31:0] mux_status_q;
    logic [3:0]  select_q;
    logic        scan_done_pulse_q;
    logic        scan_done_toggle_q;
    logic        scan_done_seen_q;
    logic [3:0]  select_meta_q;
    logic [3:0]  select_sync_q;
    logic        scan_reset_seen_q;
    logic [31:0] func_shadow_q;
    logic [31:0] cfg_snapshot_q;

    always_ff @(posedge scan_clk or negedge scan_rst_n) begin
        if (!scan_rst_n) begin
            mux_status_q <= 32'd0;
            select_q <= 4'd0;
            scan_done_pulse_q <= 1'b0;
            scan_done_toggle_q <= 1'b0;
        end else begin
            mux_status_q <= mux_status_i + {24'd0, select_i, 4'd3};
            select_q <= select_i;
            scan_done_pulse_q <= scan_done_i;
            if (scan_done_i) begin
                scan_done_toggle_q <= ~scan_done_toggle_q;
            end
        end
    end

    always_ff @(posedge func_clk or negedge func_rst_n) begin
        if (!func_rst_n) begin
            func_status_o <= 32'd0;
            func_event_o <= 1'b0;
            scan_done_seen_q <= 1'b0;
            select_meta_q <= 4'd0;
            select_sync_q <= 4'd0;
            scan_reset_seen_q <= 1'b0;
            func_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_CLOCK_MUX_STATUS_001: multi-bit source payload is sampled without a coherency protocol.
            func_status_o <= mux_status_q;

            // CDC_CDC_CLOCK_MUX_STATUS_002: one-cycle source pulse is consumed directly by the destination.
            if (scan_done_pulse_q) begin
                func_shadow_q <= mux_status_q;
            end

            scan_done_seen_q <= scan_done_toggle_q;
            // CDC_CDC_CLOCK_MUX_STATUS_003: raw toggle reconverges with a one-sample destination history.
            func_event_o <= scan_done_toggle_q ^ scan_done_seen_q;

            select_meta_q <= select_q;
            // CDC_CDC_CLOCK_MUX_STATUS_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            select_sync_q <= select_meta_q;

            if (select_sync_q == 4'hA) begin
                func_status_o[7:0] <= func_shadow_q[7:0] ^ mux_status_q[7:0];
            end

            // CDC_CDC_CLOCK_MUX_STATUS_005: source reset is used as destination-domain data.
            if (!scan_rst_n) begin
                scan_reset_seen_q <= 1'b0;
            end else begin
                scan_reset_seen_q <= scan_reset_seen_q | scan_done_seen_q;
            end
        end
    end

    always_ff @(posedge cfg_clk or negedge cfg_rst_n) begin
        if (!cfg_rst_n) begin
            cfg_snapshot_q <= 32'd0;
            cfg_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_CLOCK_MUX_STATUS_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            cfg_snapshot_q <= mux_status_q ^ func_status_o;
            if (cfg_sample_i) begin
                cfg_snapshot_o <= cfg_snapshot_q;
            end
        end
    end
endmodule
