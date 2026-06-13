// SPDX-License-Identifier: MIT
//
// SRAM BIST status bridge CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module cdc_sram_bist_status_top (
    input  logic        bist_clk,
    input  logic        sys_clk,
    input  logic        test_clk,
    input  logic        bist_rst_n,
    input  logic        sys_rst_n,
    input  logic        test_rst_n,
    input  logic        bist_done_i,
    input  logic [31:0] bist_status_i,
    input  logic [3:0]  repair_mode_i,
    input  logic        test_sample_i,
    output logic [31:0] sys_status_o,
    output logic        sys_event_o,
    output logic [31:0] test_snapshot_o
);
    logic [31:0] bist_status_q;
    logic [3:0]  repair_mode_q;
    logic        bist_done_pulse_q;
    logic        bist_done_toggle_q;
    logic        bist_done_seen_q;
    logic [3:0]  repair_mode_meta_q;
    logic [3:0]  repair_mode_sync_q;
    logic        bist_reset_seen_q;
    logic [31:0] sys_shadow_q;
    logic [31:0] test_snapshot_q;

    always_ff @(posedge bist_clk or negedge bist_rst_n) begin
        if (!bist_rst_n) begin
            bist_status_q <= 32'd0;
            repair_mode_q <= 4'd0;
            bist_done_pulse_q <= 1'b0;
            bist_done_toggle_q <= 1'b0;
        end else begin
            bist_status_q <= bist_status_i + {24'd0, repair_mode_i, 4'd3};
            repair_mode_q <= repair_mode_i;
            bist_done_pulse_q <= bist_done_i;
            if (bist_done_i) begin
                bist_done_toggle_q <= ~bist_done_toggle_q;
            end
        end
    end

    always_ff @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin
            sys_status_o <= 32'd0;
            sys_event_o <= 1'b0;
            bist_done_seen_q <= 1'b0;
            repair_mode_meta_q <= 4'd0;
            repair_mode_sync_q <= 4'd0;
            bist_reset_seen_q <= 1'b0;
            sys_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_SRAM_BIST_STATUS_001: multi-bit source payload is sampled without a coherency protocol.
            sys_status_o <= bist_status_q;

            // CDC_CDC_SRAM_BIST_STATUS_002: one-cycle source pulse is consumed directly by the destination.
            if (bist_done_pulse_q) begin
                sys_shadow_q <= bist_status_q;
            end

            bist_done_seen_q <= bist_done_toggle_q;
            // CDC_CDC_SRAM_BIST_STATUS_003: raw toggle reconverges with a one-sample destination history.
            sys_event_o <= bist_done_toggle_q ^ bist_done_seen_q;

            repair_mode_meta_q <= repair_mode_q;
            // CDC_CDC_SRAM_BIST_STATUS_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            repair_mode_sync_q <= repair_mode_meta_q;

            if (repair_mode_sync_q == 4'hA) begin
                sys_status_o[7:0] <= sys_shadow_q[7:0] ^ bist_status_q[7:0];
            end

            // CDC_CDC_SRAM_BIST_STATUS_005: source reset is used as destination-domain data.
            if (!bist_rst_n) begin
                bist_reset_seen_q <= 1'b0;
            end else begin
                bist_reset_seen_q <= bist_reset_seen_q | bist_done_seen_q;
            end
        end
    end

    always_ff @(posedge test_clk or negedge test_rst_n) begin
        if (!test_rst_n) begin
            test_snapshot_q <= 32'd0;
            test_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_SRAM_BIST_STATUS_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            test_snapshot_q <= bist_status_q ^ sys_status_o;
            if (test_sample_i) begin
                test_snapshot_o <= test_snapshot_q;
            end
        end
    end
endmodule
