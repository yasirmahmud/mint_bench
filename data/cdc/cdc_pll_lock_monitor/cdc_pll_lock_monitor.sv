// SPDX-License-Identifier: MIT
//
// PLL lock monitor CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module cdc_pll_lock_monitor_top (
    input  logic        pll_clk,
    input  logic        sys_clk,
    input  logic        cfg_clk,
    input  logic        pll_rst_n,
    input  logic        sys_rst_n,
    input  logic        cfg_rst_n,
    input  logic        lock_i,
    input  logic [31:0] lock_vector_i,
    input  logic [3:0]  bypass_mode_i,
    input  logic        cfg_sample_i,
    output logic [31:0] sys_status_o,
    output logic        sys_event_o,
    output logic [31:0] cfg_snapshot_o
);
    logic [31:0] lock_vector_q;
    logic [3:0]  bypass_mode_q;
    logic        lock_pulse_q;
    logic        lock_toggle_q;
    logic        lock_seen_q;
    logic [3:0]  bypass_mode_meta_q;
    logic [3:0]  bypass_mode_sync_q;
    logic        pll_reset_seen_q;
    logic [31:0] sys_shadow_q;
    logic [31:0] cfg_snapshot_q;

    always_ff @(posedge pll_clk or negedge pll_rst_n) begin
        if (!pll_rst_n) begin
            lock_vector_q <= 32'd0;
            bypass_mode_q <= 4'd0;
            lock_pulse_q <= 1'b0;
            lock_toggle_q <= 1'b0;
        end else begin
            lock_vector_q <= lock_vector_i + {24'd0, bypass_mode_i, 4'd3};
            bypass_mode_q <= bypass_mode_i;
            lock_pulse_q <= lock_i;
            if (lock_i) begin
                lock_toggle_q <= ~lock_toggle_q;
            end
        end
    end

    always_ff @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin
            sys_status_o <= 32'd0;
            sys_event_o <= 1'b0;
            lock_seen_q <= 1'b0;
            bypass_mode_meta_q <= 4'd0;
            bypass_mode_sync_q <= 4'd0;
            pll_reset_seen_q <= 1'b0;
            sys_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_PLL_LOCK_MONITOR_001: multi-bit source payload is sampled without a coherency protocol.
            sys_status_o <= lock_vector_q;

            // CDC_CDC_PLL_LOCK_MONITOR_002: one-cycle source pulse is consumed directly by the destination.
            if (lock_pulse_q) begin
                sys_shadow_q <= lock_vector_q;
            end

            lock_seen_q <= lock_toggle_q;
            // CDC_CDC_PLL_LOCK_MONITOR_003: raw toggle reconverges with a one-sample destination history.
            sys_event_o <= lock_toggle_q ^ lock_seen_q;

            bypass_mode_meta_q <= bypass_mode_q;
            // CDC_CDC_PLL_LOCK_MONITOR_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            bypass_mode_sync_q <= bypass_mode_meta_q;

            if (bypass_mode_sync_q == 4'hA) begin
                sys_status_o[7:0] <= sys_shadow_q[7:0] ^ lock_vector_q[7:0];
            end

            // CDC_CDC_PLL_LOCK_MONITOR_005: source reset is used as destination-domain data.
            if (!pll_rst_n) begin
                pll_reset_seen_q <= 1'b0;
            end else begin
                pll_reset_seen_q <= pll_reset_seen_q | lock_seen_q;
            end
        end
    end

    always_ff @(posedge cfg_clk or negedge cfg_rst_n) begin
        if (!cfg_rst_n) begin
            cfg_snapshot_q <= 32'd0;
            cfg_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_PLL_LOCK_MONITOR_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            cfg_snapshot_q <= lock_vector_q ^ sys_status_o;
            if (cfg_sample_i) begin
                cfg_snapshot_o <= cfg_snapshot_q;
            end
        end
    end
endmodule
