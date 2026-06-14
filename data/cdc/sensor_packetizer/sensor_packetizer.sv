// SPDX-License-Identifier: MIT
//
// Sensor packetizer CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module sensor_packetizer_top (
    input  logic        sensor_clk,
    input  logic        fabric_clk,
    input  logic        cfg_clk,
    input  logic        sensor_rst_n,
    input  logic        fabric_rst_n,
    input  logic        cfg_rst_n,
    input  logic        sample_i,
    input  logic [31:0] sample_packet_i,
    input  logic [3:0]  format_i,
    input  logic        cfg_sample_i,
    output logic [31:0] fabric_status_o,
    output logic        fabric_event_o,
    output logic [31:0] cfg_snapshot_o
);
    logic [31:0] sample_packet_q;
    logic [3:0]  format_q;
    logic        sample_pulse_q;
    logic        sample_toggle_q;
    logic        sample_seen_q;
    logic [3:0]  format_meta_q;
    logic [3:0]  format_sync_q;
    logic        sensor_reset_seen_q;
    logic [31:0] fabric_shadow_q;
    logic [31:0] cfg_snapshot_q;

    always_ff @(posedge sensor_clk or negedge sensor_rst_n) begin
        if (!sensor_rst_n) begin
            sample_packet_q <= 32'd0;
            format_q <= 4'd0;
            sample_pulse_q <= 1'b0;
            sample_toggle_q <= 1'b0;
        end else begin
            sample_packet_q <= sample_packet_i + {24'd0, format_i, 4'd3};
            format_q <= format_i;
            sample_pulse_q <= sample_i;
            if (sample_i) begin
                sample_toggle_q <= ~sample_toggle_q;
            end
        end
    end

    always_ff @(posedge fabric_clk or negedge fabric_rst_n) begin
        if (!fabric_rst_n) begin
            fabric_status_o <= 32'd0;
            fabric_event_o <= 1'b0;
            sample_seen_q <= 1'b0;
            format_meta_q <= 4'd0;
            format_sync_q <= 4'd0;
            sensor_reset_seen_q <= 1'b0;
            fabric_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_SENSOR_PACKETIZER_001: multi-bit source payload is sampled without a coherency protocol.
            fabric_status_o <= sample_packet_q;

            // CDC_CDC_SENSOR_PACKETIZER_002: one-cycle source pulse is consumed directly by the destination.
            if (sample_pulse_q) begin
                fabric_shadow_q <= sample_packet_q;
            end

            sample_seen_q <= sample_toggle_q;
            // CDC_CDC_SENSOR_PACKETIZER_003: raw toggle reconverges with a one-sample destination history.
            fabric_event_o <= sample_toggle_q ^ sample_seen_q;

            format_meta_q <= format_q;
            // CDC_CDC_SENSOR_PACKETIZER_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            format_sync_q <= format_meta_q;

            if (format_sync_q == 4'hA) begin
                fabric_status_o[7:0] <= fabric_shadow_q[7:0] ^ sample_packet_q[7:0];
            end

            // CDC_CDC_SENSOR_PACKETIZER_005: source reset is used as destination-domain data.
            if (!sensor_rst_n) begin
                sensor_reset_seen_q <= 1'b0;
            end else begin
                sensor_reset_seen_q <= sensor_reset_seen_q | sample_seen_q;
            end
        end
    end

    always_ff @(posedge cfg_clk or negedge cfg_rst_n) begin
        if (!cfg_rst_n) begin
            cfg_snapshot_q <= 32'd0;
            cfg_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_SENSOR_PACKETIZER_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            cfg_snapshot_q <= sample_packet_q ^ fabric_status_o;
            if (cfg_sample_i) begin
                cfg_snapshot_o <= cfg_snapshot_q;
            end
        end
    end
endmodule
