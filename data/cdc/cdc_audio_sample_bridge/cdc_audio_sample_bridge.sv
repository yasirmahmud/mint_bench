// SPDX-License-Identifier: MIT
//
// Audio sample bridge CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module cdc_audio_sample_bridge_top (
    input  logic        audio_clk,
    input  logic        bus_clk,
    input  logic        dsp_clk,
    input  logic        audio_rst_n,
    input  logic        bus_rst_n,
    input  logic        dsp_rst_n,
    input  logic        sample_strobe_i,
    input  logic [31:0] sample_word_i,
    input  logic [3:0]  gain_mode_i,
    input  logic        dsp_sample_i,
    output logic [31:0] bus_status_o,
    output logic        bus_event_o,
    output logic [31:0] dsp_snapshot_o
);
    logic [31:0] sample_word_q;
    logic [3:0]  gain_mode_q;
    logic        sample_strobe_pulse_q;
    logic        sample_strobe_toggle_q;
    logic        sample_strobe_seen_q;
    logic [3:0]  gain_mode_meta_q;
    logic [3:0]  gain_mode_sync_q;
    logic        audio_reset_seen_q;
    logic [31:0] bus_shadow_q;
    logic [31:0] dsp_snapshot_q;

    always_ff @(posedge audio_clk or negedge audio_rst_n) begin
        if (!audio_rst_n) begin
            sample_word_q <= 32'd0;
            gain_mode_q <= 4'd0;
            sample_strobe_pulse_q <= 1'b0;
            sample_strobe_toggle_q <= 1'b0;
        end else begin
            sample_word_q <= sample_word_i + {24'd0, gain_mode_i, 4'd3};
            gain_mode_q <= gain_mode_i;
            sample_strobe_pulse_q <= sample_strobe_i;
            if (sample_strobe_i) begin
                sample_strobe_toggle_q <= ~sample_strobe_toggle_q;
            end
        end
    end

    always_ff @(posedge bus_clk or negedge bus_rst_n) begin
        if (!bus_rst_n) begin
            bus_status_o <= 32'd0;
            bus_event_o <= 1'b0;
            sample_strobe_seen_q <= 1'b0;
            gain_mode_meta_q <= 4'd0;
            gain_mode_sync_q <= 4'd0;
            audio_reset_seen_q <= 1'b0;
            bus_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_AUDIO_SAMPLE_BRIDGE_001: multi-bit source payload is sampled without a coherency protocol.
            bus_status_o <= sample_word_q;

            // CDC_CDC_AUDIO_SAMPLE_BRIDGE_002: one-cycle source pulse is consumed directly by the destination.
            if (sample_strobe_pulse_q) begin
                bus_shadow_q <= sample_word_q;
            end

            sample_strobe_seen_q <= sample_strobe_toggle_q;
            // CDC_CDC_AUDIO_SAMPLE_BRIDGE_003: raw toggle reconverges with a one-sample destination history.
            bus_event_o <= sample_strobe_toggle_q ^ sample_strobe_seen_q;

            gain_mode_meta_q <= gain_mode_q;
            // CDC_CDC_AUDIO_SAMPLE_BRIDGE_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            gain_mode_sync_q <= gain_mode_meta_q;

            if (gain_mode_sync_q == 4'hA) begin
                bus_status_o[7:0] <= bus_shadow_q[7:0] ^ sample_word_q[7:0];
            end

            // CDC_CDC_AUDIO_SAMPLE_BRIDGE_005: source reset is used as destination-domain data.
            if (!audio_rst_n) begin
                audio_reset_seen_q <= 1'b0;
            end else begin
                audio_reset_seen_q <= audio_reset_seen_q | sample_strobe_seen_q;
            end
        end
    end

    always_ff @(posedge dsp_clk or negedge dsp_rst_n) begin
        if (!dsp_rst_n) begin
            dsp_snapshot_q <= 32'd0;
            dsp_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_AUDIO_SAMPLE_BRIDGE_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            dsp_snapshot_q <= sample_word_q ^ bus_status_o;
            if (dsp_sample_i) begin
                dsp_snapshot_o <= dsp_snapshot_q;
            end
        end
    end
endmodule
