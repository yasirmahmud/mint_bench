// SPDX-License-Identifier: MIT
//
// Voltage monitor bridge CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module voltage_monitor_top (
    input  logic        volt_clk,
    input  logic        pmu_clk,
    input  logic        sys_clk,
    input  logic        volt_rst_n,
    input  logic        pmu_rst_n,
    input  logic        sys_rst_n,
    input  logic        droop_i,
    input  logic [31:0] voltage_code_i,
    input  logic [3:0]  alarm_mode_i,
    input  logic        sys_sample_i,
    output logic [31:0] pmu_status_o,
    output logic        pmu_event_o,
    output logic [31:0] sys_snapshot_o
);
    logic [31:0] voltage_code_q;
    logic [3:0]  alarm_mode_q;
    logic        droop_pulse_q;
    logic        droop_toggle_q;
    logic        droop_seen_q;
    logic [3:0]  alarm_mode_meta_q;
    logic [3:0]  alarm_mode_sync_q;
    logic        volt_reset_seen_q;
    logic [31:0] pmu_shadow_q;
    logic [31:0] sys_snapshot_q;

    always_ff @(posedge volt_clk or negedge volt_rst_n) begin
        if (!volt_rst_n) begin
            voltage_code_q <= 32'd0;
            alarm_mode_q <= 4'd0;
            droop_pulse_q <= 1'b0;
            droop_toggle_q <= 1'b0;
        end else begin
            voltage_code_q <= voltage_code_i + {24'd0, alarm_mode_i, 4'd3};
            alarm_mode_q <= alarm_mode_i;
            droop_pulse_q <= droop_i;
            if (droop_i) begin
                droop_toggle_q <= ~droop_toggle_q;
            end
        end
    end

    always_ff @(posedge pmu_clk or negedge pmu_rst_n) begin
        if (!pmu_rst_n) begin
            pmu_status_o <= 32'd0;
            pmu_event_o <= 1'b0;
            droop_seen_q <= 1'b0;
            alarm_mode_meta_q <= 4'd0;
            alarm_mode_sync_q <= 4'd0;
            volt_reset_seen_q <= 1'b0;
            pmu_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_VOLTAGE_MONITOR_001: multi-bit source payload is sampled without a coherency protocol.
            pmu_status_o <= voltage_code_q;

            // CDC_CDC_VOLTAGE_MONITOR_002: one-cycle source pulse is consumed directly by the destination.
            if (droop_pulse_q) begin
                pmu_shadow_q <= voltage_code_q;
            end

            droop_seen_q <= droop_toggle_q;
            // CDC_CDC_VOLTAGE_MONITOR_003: raw toggle reconverges with a one-sample destination history.
            pmu_event_o <= droop_toggle_q ^ droop_seen_q;

            alarm_mode_meta_q <= alarm_mode_q;
            // CDC_CDC_VOLTAGE_MONITOR_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            alarm_mode_sync_q <= alarm_mode_meta_q;

            if (alarm_mode_sync_q == 4'hA) begin
                pmu_status_o[7:0] <= pmu_shadow_q[7:0] ^ voltage_code_q[7:0];
            end

            // CDC_CDC_VOLTAGE_MONITOR_005: source reset is used as destination-domain data.
            if (!volt_rst_n) begin
                volt_reset_seen_q <= 1'b0;
            end else begin
                volt_reset_seen_q <= volt_reset_seen_q | droop_seen_q;
            end
        end
    end

    always_ff @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin
            sys_snapshot_q <= 32'd0;
            sys_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_VOLTAGE_MONITOR_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            sys_snapshot_q <= voltage_code_q ^ pmu_status_o;
            if (sys_sample_i) begin
                sys_snapshot_o <= sys_snapshot_q;
            end
        end
    end
endmodule
