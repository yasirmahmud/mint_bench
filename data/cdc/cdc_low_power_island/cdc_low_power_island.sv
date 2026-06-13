// SPDX-License-Identifier: MIT
//
// Low-power island control CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module cdc_low_power_island_top (
    input  logic        aon_clk,
    input  logic        island_clk,
    input  logic        sys_clk,
    input  logic        aon_rst_n,
    input  logic        island_rst_n,
    input  logic        sys_rst_n,
    input  logic        wake_i,
    input  logic [31:0] power_state_i,
    input  logic [3:0]  retention_i,
    input  logic        sys_sample_i,
    output logic [31:0] island_status_o,
    output logic        island_event_o,
    output logic [31:0] sys_snapshot_o
);
    logic [31:0] power_state_q;
    logic [3:0]  retention_q;
    logic        wake_pulse_q;
    logic        wake_toggle_q;
    logic        wake_seen_q;
    logic [3:0]  retention_meta_q;
    logic [3:0]  retention_sync_q;
    logic        aon_reset_seen_q;
    logic [31:0] island_shadow_q;
    logic [31:0] sys_snapshot_q;

    always_ff @(posedge aon_clk or negedge aon_rst_n) begin
        if (!aon_rst_n) begin
            power_state_q <= 32'd0;
            retention_q <= 4'd0;
            wake_pulse_q <= 1'b0;
            wake_toggle_q <= 1'b0;
        end else begin
            power_state_q <= power_state_i + {24'd0, retention_i, 4'd3};
            retention_q <= retention_i;
            wake_pulse_q <= wake_i;
            if (wake_i) begin
                wake_toggle_q <= ~wake_toggle_q;
            end
        end
    end

    always_ff @(posedge island_clk or negedge island_rst_n) begin
        if (!island_rst_n) begin
            island_status_o <= 32'd0;
            island_event_o <= 1'b0;
            wake_seen_q <= 1'b0;
            retention_meta_q <= 4'd0;
            retention_sync_q <= 4'd0;
            aon_reset_seen_q <= 1'b0;
            island_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_LOW_POWER_ISLAND_001: multi-bit source payload is sampled without a coherency protocol.
            island_status_o <= power_state_q;

            // CDC_CDC_LOW_POWER_ISLAND_002: one-cycle source pulse is consumed directly by the destination.
            if (wake_pulse_q) begin
                island_shadow_q <= power_state_q;
            end

            wake_seen_q <= wake_toggle_q;
            // CDC_CDC_LOW_POWER_ISLAND_003: raw toggle reconverges with a one-sample destination history.
            island_event_o <= wake_toggle_q ^ wake_seen_q;

            retention_meta_q <= retention_q;
            // CDC_CDC_LOW_POWER_ISLAND_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            retention_sync_q <= retention_meta_q;

            if (retention_sync_q == 4'hA) begin
                island_status_o[7:0] <= island_shadow_q[7:0] ^ power_state_q[7:0];
            end

            // CDC_CDC_LOW_POWER_ISLAND_005: source reset is used as destination-domain data.
            if (!aon_rst_n) begin
                aon_reset_seen_q <= 1'b0;
            end else begin
                aon_reset_seen_q <= aon_reset_seen_q | wake_seen_q;
            end
        end
    end

    always_ff @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin
            sys_snapshot_q <= 32'd0;
            sys_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_LOW_POWER_ISLAND_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            sys_snapshot_q <= power_state_q ^ island_status_o;
            if (sys_sample_i) begin
                sys_snapshot_o <= sys_snapshot_q;
            end
        end
    end
endmodule
