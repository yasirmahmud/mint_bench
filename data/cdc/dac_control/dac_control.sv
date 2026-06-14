// SPDX-License-Identifier: MIT
//
// DAC control bridge CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module dac_control_top (
    input  logic        bus_clk,
    input  logic        dac_clk,
    input  logic        analog_clk,
    input  logic        bus_rst_n,
    input  logic        dac_rst_n,
    input  logic        analog_rst_n,
    input  logic        load_i,
    input  logic [31:0] dac_code_i,
    input  logic [3:0]  slew_mode_i,
    input  logic        analog_sample_i,
    output logic [31:0] dac_status_o,
    output logic        dac_event_o,
    output logic [31:0] analog_snapshot_o
);
    logic [31:0] dac_code_q;
    logic [3:0]  slew_mode_q;
    logic        load_pulse_q;
    logic        load_toggle_q;
    logic        load_seen_q;
    logic [3:0]  slew_mode_meta_q;
    logic [3:0]  slew_mode_sync_q;
    logic        bus_reset_seen_q;
    logic [31:0] dac_shadow_q;
    logic [31:0] analog_snapshot_q;

    always_ff @(posedge bus_clk or negedge bus_rst_n) begin
        if (!bus_rst_n) begin
            dac_code_q <= 32'd0;
            slew_mode_q <= 4'd0;
            load_pulse_q <= 1'b0;
            load_toggle_q <= 1'b0;
        end else begin
            dac_code_q <= dac_code_i + {24'd0, slew_mode_i, 4'd3};
            slew_mode_q <= slew_mode_i;
            load_pulse_q <= load_i;
            if (load_i) begin
                load_toggle_q <= ~load_toggle_q;
            end
        end
    end

    always_ff @(posedge dac_clk or negedge dac_rst_n) begin
        if (!dac_rst_n) begin
            dac_status_o <= 32'd0;
            dac_event_o <= 1'b0;
            load_seen_q <= 1'b0;
            slew_mode_meta_q <= 4'd0;
            slew_mode_sync_q <= 4'd0;
            bus_reset_seen_q <= 1'b0;
            dac_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_DAC_CONTROL_001: multi-bit source payload is sampled without a coherency protocol.
            dac_status_o <= dac_code_q;

            // CDC_CDC_DAC_CONTROL_002: one-cycle source pulse is consumed directly by the destination.
            if (load_pulse_q) begin
                dac_shadow_q <= dac_code_q;
            end

            load_seen_q <= load_toggle_q;
            // CDC_CDC_DAC_CONTROL_003: raw toggle reconverges with a one-sample destination history.
            dac_event_o <= load_toggle_q ^ load_seen_q;

            slew_mode_meta_q <= slew_mode_q;
            // CDC_CDC_DAC_CONTROL_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            slew_mode_sync_q <= slew_mode_meta_q;

            if (slew_mode_sync_q == 4'hA) begin
                dac_status_o[7:0] <= dac_shadow_q[7:0] ^ dac_code_q[7:0];
            end

            // CDC_CDC_DAC_CONTROL_005: source reset is used as destination-domain data.
            if (!bus_rst_n) begin
                bus_reset_seen_q <= 1'b0;
            end else begin
                bus_reset_seen_q <= bus_reset_seen_q | load_seen_q;
            end
        end
    end

    always_ff @(posedge analog_clk or negedge analog_rst_n) begin
        if (!analog_rst_n) begin
            analog_snapshot_q <= 32'd0;
            analog_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_DAC_CONTROL_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            analog_snapshot_q <= dac_code_q ^ dac_status_o;
            if (analog_sample_i) begin
                analog_snapshot_o <= analog_snapshot_q;
            end
        end
    end
endmodule
