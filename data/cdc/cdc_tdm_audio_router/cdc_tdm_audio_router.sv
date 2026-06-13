// SPDX-License-Identifier: MIT
//
// TDM audio router CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module cdc_tdm_audio_router_top (
    input  logic        tdm_clk,
    input  logic        audio_clk,
    input  logic        bus_clk,
    input  logic        tdm_rst_n,
    input  logic        audio_rst_n,
    input  logic        bus_rst_n,
    input  logic        slot_valid_i,
    input  logic [31:0] slot_sample_i,
    input  logic [3:0]  slot_mode_i,
    input  logic        bus_sample_i,
    output logic [31:0] audio_status_o,
    output logic        audio_event_o,
    output logic [31:0] bus_snapshot_o
);
    logic [31:0] slot_sample_q;
    logic [3:0]  slot_mode_q;
    logic        slot_valid_pulse_q;
    logic        slot_valid_toggle_q;
    logic        slot_valid_seen_q;
    logic [3:0]  slot_mode_meta_q;
    logic [3:0]  slot_mode_sync_q;
    logic        tdm_reset_seen_q;
    logic [31:0] audio_shadow_q;
    logic [31:0] bus_snapshot_q;

    always_ff @(posedge tdm_clk or negedge tdm_rst_n) begin
        if (!tdm_rst_n) begin
            slot_sample_q <= 32'd0;
            slot_mode_q <= 4'd0;
            slot_valid_pulse_q <= 1'b0;
            slot_valid_toggle_q <= 1'b0;
        end else begin
            slot_sample_q <= slot_sample_i + {24'd0, slot_mode_i, 4'd3};
            slot_mode_q <= slot_mode_i;
            slot_valid_pulse_q <= slot_valid_i;
            if (slot_valid_i) begin
                slot_valid_toggle_q <= ~slot_valid_toggle_q;
            end
        end
    end

    always_ff @(posedge audio_clk or negedge audio_rst_n) begin
        if (!audio_rst_n) begin
            audio_status_o <= 32'd0;
            audio_event_o <= 1'b0;
            slot_valid_seen_q <= 1'b0;
            slot_mode_meta_q <= 4'd0;
            slot_mode_sync_q <= 4'd0;
            tdm_reset_seen_q <= 1'b0;
            audio_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_TDM_AUDIO_ROUTER_001: multi-bit source payload is sampled without a coherency protocol.
            audio_status_o <= slot_sample_q;

            // CDC_CDC_TDM_AUDIO_ROUTER_002: one-cycle source pulse is consumed directly by the destination.
            if (slot_valid_pulse_q) begin
                audio_shadow_q <= slot_sample_q;
            end

            slot_valid_seen_q <= slot_valid_toggle_q;
            // CDC_CDC_TDM_AUDIO_ROUTER_003: raw toggle reconverges with a one-sample destination history.
            audio_event_o <= slot_valid_toggle_q ^ slot_valid_seen_q;

            slot_mode_meta_q <= slot_mode_q;
            // CDC_CDC_TDM_AUDIO_ROUTER_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            slot_mode_sync_q <= slot_mode_meta_q;

            if (slot_mode_sync_q == 4'hA) begin
                audio_status_o[7:0] <= audio_shadow_q[7:0] ^ slot_sample_q[7:0];
            end

            // CDC_CDC_TDM_AUDIO_ROUTER_005: source reset is used as destination-domain data.
            if (!tdm_rst_n) begin
                tdm_reset_seen_q <= 1'b0;
            end else begin
                tdm_reset_seen_q <= tdm_reset_seen_q | slot_valid_seen_q;
            end
        end
    end

    always_ff @(posedge bus_clk or negedge bus_rst_n) begin
        if (!bus_rst_n) begin
            bus_snapshot_q <= 32'd0;
            bus_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_TDM_AUDIO_ROUTER_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            bus_snapshot_q <= slot_sample_q ^ audio_status_o;
            if (bus_sample_i) begin
                bus_snapshot_o <= bus_snapshot_q;
            end
        end
    end
endmodule
