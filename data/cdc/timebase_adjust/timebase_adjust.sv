// SPDX-License-Identifier: MIT
//
// Timebase adjustment bridge CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module timebase_adjust_top (
    input  logic        rtc_clk,
    input  logic        cpu_clk,
    input  logic        aon_clk,
    input  logic        rtc_rst_n,
    input  logic        cpu_rst_n,
    input  logic        aon_rst_n,
    input  logic        adjust_i,
    input  logic [31:0] time_adjust_i,
    input  logic [3:0]  slew_mode_i,
    input  logic        aon_sample_i,
    output logic [31:0] cpu_status_o,
    output logic        cpu_event_o,
    output logic [31:0] aon_snapshot_o
);
    logic [31:0] time_adjust_q;
    logic [3:0]  slew_mode_q;
    logic        adjust_pulse_q;
    logic        adjust_toggle_q;
    logic        adjust_seen_q;
    logic [3:0]  slew_mode_meta_q;
    logic [3:0]  slew_mode_sync_q;
    logic        rtc_reset_seen_q;
    logic [31:0] cpu_shadow_q;
    logic [31:0] aon_snapshot_q;

    always_ff @(posedge rtc_clk or negedge rtc_rst_n) begin
        if (!rtc_rst_n) begin
            time_adjust_q <= 32'd0;
            slew_mode_q <= 4'd0;
            adjust_pulse_q <= 1'b0;
            adjust_toggle_q <= 1'b0;
        end else begin
            time_adjust_q <= time_adjust_i + {24'd0, slew_mode_i, 4'd3};
            slew_mode_q <= slew_mode_i;
            adjust_pulse_q <= adjust_i;
            if (adjust_i) begin
                adjust_toggle_q <= ~adjust_toggle_q;
            end
        end
    end

    always_ff @(posedge cpu_clk or negedge cpu_rst_n) begin
        if (!cpu_rst_n) begin
            cpu_status_o <= 32'd0;
            cpu_event_o <= 1'b0;
            adjust_seen_q <= 1'b0;
            slew_mode_meta_q <= 4'd0;
            slew_mode_sync_q <= 4'd0;
            rtc_reset_seen_q <= 1'b0;
            cpu_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_TIMEBASE_ADJUST_001: multi-bit source payload is sampled without a coherency protocol.
            cpu_status_o <= time_adjust_q;

            // CDC_CDC_TIMEBASE_ADJUST_002: one-cycle source pulse is consumed directly by the destination.
            if (adjust_pulse_q) begin
                cpu_shadow_q <= time_adjust_q;
            end

            adjust_seen_q <= adjust_toggle_q;
            // CDC_CDC_TIMEBASE_ADJUST_003: raw toggle reconverges with a one-sample destination history.
            cpu_event_o <= adjust_toggle_q ^ adjust_seen_q;

            slew_mode_meta_q <= slew_mode_q;
            // CDC_CDC_TIMEBASE_ADJUST_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            slew_mode_sync_q <= slew_mode_meta_q;

            if (slew_mode_sync_q == 4'hA) begin
                cpu_status_o[7:0] <= cpu_shadow_q[7:0] ^ time_adjust_q[7:0];
            end

            // CDC_CDC_TIMEBASE_ADJUST_005: source reset is used as destination-domain data.
            if (!rtc_rst_n) begin
                rtc_reset_seen_q <= 1'b0;
            end else begin
                rtc_reset_seen_q <= rtc_reset_seen_q | adjust_seen_q;
            end
        end
    end

    always_ff @(posedge aon_clk or negedge aon_rst_n) begin
        if (!aon_rst_n) begin
            aon_snapshot_q <= 32'd0;
            aon_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_TIMEBASE_ADJUST_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            aon_snapshot_q <= time_adjust_q ^ cpu_status_o;
            if (aon_sample_i) begin
                aon_snapshot_o <= aon_snapshot_q;
            end
        end
    end
endmodule
