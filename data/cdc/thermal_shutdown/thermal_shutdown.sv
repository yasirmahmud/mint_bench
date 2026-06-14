// SPDX-License-Identifier: MIT
//
// Thermal shutdown bridge CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module thermal_shutdown_top (
    input  logic        thermal_clk,
    input  logic        pmu_clk,
    input  logic        aon_clk,
    input  logic        thermal_rst_n,
    input  logic        pmu_rst_n,
    input  logic        aon_rst_n,
    input  logic        overtemp_i,
    input  logic [31:0] thermal_code_i,
    input  logic [3:0]  trip_mode_i,
    input  logic        aon_sample_i,
    output logic [31:0] pmu_status_o,
    output logic        pmu_event_o,
    output logic [31:0] aon_snapshot_o
);
    logic [31:0] thermal_code_q;
    logic [3:0]  trip_mode_q;
    logic        overtemp_pulse_q;
    logic        overtemp_toggle_q;
    logic        overtemp_seen_q;
    logic [3:0]  trip_mode_meta_q;
    logic [3:0]  trip_mode_sync_q;
    logic        thermal_reset_seen_q;
    logic [31:0] pmu_shadow_q;
    logic [31:0] aon_snapshot_q;

    always_ff @(posedge thermal_clk or negedge thermal_rst_n) begin
        if (!thermal_rst_n) begin
            thermal_code_q <= 32'd0;
            trip_mode_q <= 4'd0;
            overtemp_pulse_q <= 1'b0;
            overtemp_toggle_q <= 1'b0;
        end else begin
            thermal_code_q <= thermal_code_i + {24'd0, trip_mode_i, 4'd3};
            trip_mode_q <= trip_mode_i;
            overtemp_pulse_q <= overtemp_i;
            if (overtemp_i) begin
                overtemp_toggle_q <= ~overtemp_toggle_q;
            end
        end
    end

    always_ff @(posedge pmu_clk or negedge pmu_rst_n) begin
        if (!pmu_rst_n) begin
            pmu_status_o <= 32'd0;
            pmu_event_o <= 1'b0;
            overtemp_seen_q <= 1'b0;
            trip_mode_meta_q <= 4'd0;
            trip_mode_sync_q <= 4'd0;
            thermal_reset_seen_q <= 1'b0;
            pmu_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_THERMAL_SHUTDOWN_001: multi-bit source payload is sampled without a coherency protocol.
            pmu_status_o <= thermal_code_q;

            // CDC_CDC_THERMAL_SHUTDOWN_002: one-cycle source pulse is consumed directly by the destination.
            if (overtemp_pulse_q) begin
                pmu_shadow_q <= thermal_code_q;
            end

            overtemp_seen_q <= overtemp_toggle_q;
            // CDC_CDC_THERMAL_SHUTDOWN_003: raw toggle reconverges with a one-sample destination history.
            pmu_event_o <= overtemp_toggle_q ^ overtemp_seen_q;

            trip_mode_meta_q <= trip_mode_q;
            // CDC_CDC_THERMAL_SHUTDOWN_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            trip_mode_sync_q <= trip_mode_meta_q;

            if (trip_mode_sync_q == 4'hA) begin
                pmu_status_o[7:0] <= pmu_shadow_q[7:0] ^ thermal_code_q[7:0];
            end

            // CDC_CDC_THERMAL_SHUTDOWN_005: source reset is used as destination-domain data.
            if (!thermal_rst_n) begin
                thermal_reset_seen_q <= 1'b0;
            end else begin
                thermal_reset_seen_q <= thermal_reset_seen_q | overtemp_seen_q;
            end
        end
    end

    always_ff @(posedge aon_clk or negedge aon_rst_n) begin
        if (!aon_rst_n) begin
            aon_snapshot_q <= 32'd0;
            aon_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_THERMAL_SHUTDOWN_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            aon_snapshot_q <= thermal_code_q ^ pmu_status_o;
            if (aon_sample_i) begin
                aon_snapshot_o <= aon_snapshot_q;
            end
        end
    end
endmodule
