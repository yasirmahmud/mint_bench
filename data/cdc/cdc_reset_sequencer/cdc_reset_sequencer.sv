// SPDX-License-Identifier: MIT
//
// Reset sequencer CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module cdc_reset_sequencer_top (
    input  logic        pmu_clk,
    input  logic        core_clk,
    input  logic        fabric_clk,
    input  logic        pmu_rst_n,
    input  logic        core_rst_n,
    input  logic        fabric_rst_n,
    input  logic        release_i,
    input  logic [31:0] reset_state_i,
    input  logic [3:0]  boot_mode_i,
    input  logic        fabric_sample_i,
    output logic [31:0] core_status_o,
    output logic        core_event_o,
    output logic [31:0] fabric_snapshot_o
);
    logic [31:0] reset_state_q;
    logic [3:0]  boot_mode_q;
    logic        release_pulse_q;
    logic        release_toggle_q;
    logic        release_seen_q;
    logic [3:0]  boot_mode_meta_q;
    logic [3:0]  boot_mode_sync_q;
    logic        pmu_reset_seen_q;
    logic [31:0] core_shadow_q;
    logic [31:0] fabric_snapshot_q;

    always_ff @(posedge pmu_clk or negedge pmu_rst_n) begin
        if (!pmu_rst_n) begin
            reset_state_q <= 32'd0;
            boot_mode_q <= 4'd0;
            release_pulse_q <= 1'b0;
            release_toggle_q <= 1'b0;
        end else begin
            reset_state_q <= reset_state_i + {24'd0, boot_mode_i, 4'd3};
            boot_mode_q <= boot_mode_i;
            release_pulse_q <= release_i;
            if (release_i) begin
                release_toggle_q <= ~release_toggle_q;
            end
        end
    end

    always_ff @(posedge core_clk or negedge core_rst_n) begin
        if (!core_rst_n) begin
            core_status_o <= 32'd0;
            core_event_o <= 1'b0;
            release_seen_q <= 1'b0;
            boot_mode_meta_q <= 4'd0;
            boot_mode_sync_q <= 4'd0;
            pmu_reset_seen_q <= 1'b0;
            core_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_RESET_SEQUENCER_001: multi-bit source payload is sampled without a coherency protocol.
            core_status_o <= reset_state_q;

            // CDC_CDC_RESET_SEQUENCER_002: one-cycle source pulse is consumed directly by the destination.
            if (release_pulse_q) begin
                core_shadow_q <= reset_state_q;
            end

            release_seen_q <= release_toggle_q;
            // CDC_CDC_RESET_SEQUENCER_003: raw toggle reconverges with a one-sample destination history.
            core_event_o <= release_toggle_q ^ release_seen_q;

            boot_mode_meta_q <= boot_mode_q;
            // CDC_CDC_RESET_SEQUENCER_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            boot_mode_sync_q <= boot_mode_meta_q;

            if (boot_mode_sync_q == 4'hA) begin
                core_status_o[7:0] <= core_shadow_q[7:0] ^ reset_state_q[7:0];
            end

            // CDC_CDC_RESET_SEQUENCER_005: source reset is used as destination-domain data.
            if (!pmu_rst_n) begin
                pmu_reset_seen_q <= 1'b0;
            end else begin
                pmu_reset_seen_q <= pmu_reset_seen_q | release_seen_q;
            end
        end
    end

    always_ff @(posedge fabric_clk or negedge fabric_rst_n) begin
        if (!fabric_rst_n) begin
            fabric_snapshot_q <= 32'd0;
            fabric_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_RESET_SEQUENCER_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            fabric_snapshot_q <= reset_state_q ^ core_status_o;
            if (fabric_sample_i) begin
                fabric_snapshot_o <= fabric_snapshot_q;
            end
        end
    end
endmodule
