// SPDX-License-Identifier: MIT
//
// Sensor fusion bridge CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module cdc_sensor_fusion_top (
    input  logic        imu_clk,
    input  logic        fusion_clk,
    input  logic        host_clk,
    input  logic        imu_rst_n,
    input  logic        fusion_rst_n,
    input  logic        host_rst_n,
    input  logic        imu_ready_i,
    input  logic [31:0] fusion_input_i,
    input  logic [3:0]  fusion_mode_i,
    input  logic        host_sample_i,
    output logic [31:0] fusion_status_o,
    output logic        fusion_event_o,
    output logic [31:0] host_snapshot_o
);
    logic [31:0] fusion_input_q;
    logic [3:0]  fusion_mode_q;
    logic        imu_ready_pulse_q;
    logic        imu_ready_toggle_q;
    logic        imu_ready_seen_q;
    logic [3:0]  fusion_mode_meta_q;
    logic [3:0]  fusion_mode_sync_q;
    logic        imu_reset_seen_q;
    logic [31:0] fusion_shadow_q;
    logic [31:0] host_snapshot_q;

    always_ff @(posedge imu_clk or negedge imu_rst_n) begin
        if (!imu_rst_n) begin
            fusion_input_q <= 32'd0;
            fusion_mode_q <= 4'd0;
            imu_ready_pulse_q <= 1'b0;
            imu_ready_toggle_q <= 1'b0;
        end else begin
            fusion_input_q <= fusion_input_i + {24'd0, fusion_mode_i, 4'd3};
            fusion_mode_q <= fusion_mode_i;
            imu_ready_pulse_q <= imu_ready_i;
            if (imu_ready_i) begin
                imu_ready_toggle_q <= ~imu_ready_toggle_q;
            end
        end
    end

    always_ff @(posedge fusion_clk or negedge fusion_rst_n) begin
        if (!fusion_rst_n) begin
            fusion_status_o <= 32'd0;
            fusion_event_o <= 1'b0;
            imu_ready_seen_q <= 1'b0;
            fusion_mode_meta_q <= 4'd0;
            fusion_mode_sync_q <= 4'd0;
            imu_reset_seen_q <= 1'b0;
            fusion_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_SENSOR_FUSION_001: multi-bit source payload is sampled without a coherency protocol.
            fusion_status_o <= fusion_input_q;

            // CDC_CDC_SENSOR_FUSION_002: one-cycle source pulse is consumed directly by the destination.
            if (imu_ready_pulse_q) begin
                fusion_shadow_q <= fusion_input_q;
            end

            imu_ready_seen_q <= imu_ready_toggle_q;
            // CDC_CDC_SENSOR_FUSION_003: raw toggle reconverges with a one-sample destination history.
            fusion_event_o <= imu_ready_toggle_q ^ imu_ready_seen_q;

            fusion_mode_meta_q <= fusion_mode_q;
            // CDC_CDC_SENSOR_FUSION_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            fusion_mode_sync_q <= fusion_mode_meta_q;

            if (fusion_mode_sync_q == 4'hA) begin
                fusion_status_o[7:0] <= fusion_shadow_q[7:0] ^ fusion_input_q[7:0];
            end

            // CDC_CDC_SENSOR_FUSION_005: source reset is used as destination-domain data.
            if (!imu_rst_n) begin
                imu_reset_seen_q <= 1'b0;
            end else begin
                imu_reset_seen_q <= imu_reset_seen_q | imu_ready_seen_q;
            end
        end
    end

    always_ff @(posedge host_clk or negedge host_rst_n) begin
        if (!host_rst_n) begin
            host_snapshot_q <= 32'd0;
            host_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_SENSOR_FUSION_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            host_snapshot_q <= fusion_input_q ^ fusion_status_o;
            if (host_sample_i) begin
                host_snapshot_o <= host_snapshot_q;
            end
        end
    end
endmodule
