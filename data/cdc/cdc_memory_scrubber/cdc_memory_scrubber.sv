// SPDX-License-Identifier: MIT
//
// Memory scrubber CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module cdc_memory_scrubber_top (
    input  logic        mem_clk,
    input  logic        ctrl_clk,
    input  logic        diag_clk,
    input  logic        mem_rst_n,
    input  logic        ctrl_rst_n,
    input  logic        diag_rst_n,
    input  logic        done_i,
    input  logic [31:0] scrub_status_i,
    input  logic [3:0]  scrub_mode_i,
    input  logic        diag_sample_i,
    output logic [31:0] ctrl_status_o,
    output logic        ctrl_event_o,
    output logic [31:0] diag_snapshot_o
);
    logic [31:0] scrub_status_q;
    logic [3:0]  scrub_mode_q;
    logic        done_pulse_q;
    logic        done_toggle_q;
    logic        done_seen_q;
    logic [3:0]  scrub_mode_meta_q;
    logic [3:0]  scrub_mode_sync_q;
    logic        mem_reset_seen_q;
    logic [31:0] ctrl_shadow_q;
    logic [31:0] diag_snapshot_q;

    always_ff @(posedge mem_clk or negedge mem_rst_n) begin
        if (!mem_rst_n) begin
            scrub_status_q <= 32'd0;
            scrub_mode_q <= 4'd0;
            done_pulse_q <= 1'b0;
            done_toggle_q <= 1'b0;
        end else begin
            scrub_status_q <= scrub_status_i + {24'd0, scrub_mode_i, 4'd3};
            scrub_mode_q <= scrub_mode_i;
            done_pulse_q <= done_i;
            if (done_i) begin
                done_toggle_q <= ~done_toggle_q;
            end
        end
    end

    always_ff @(posedge ctrl_clk or negedge ctrl_rst_n) begin
        if (!ctrl_rst_n) begin
            ctrl_status_o <= 32'd0;
            ctrl_event_o <= 1'b0;
            done_seen_q <= 1'b0;
            scrub_mode_meta_q <= 4'd0;
            scrub_mode_sync_q <= 4'd0;
            mem_reset_seen_q <= 1'b0;
            ctrl_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_MEMORY_SCRUBBER_001: multi-bit source payload is sampled without a coherency protocol.
            ctrl_status_o <= scrub_status_q;

            // CDC_CDC_MEMORY_SCRUBBER_002: one-cycle source pulse is consumed directly by the destination.
            if (done_pulse_q) begin
                ctrl_shadow_q <= scrub_status_q;
            end

            done_seen_q <= done_toggle_q;
            // CDC_CDC_MEMORY_SCRUBBER_003: raw toggle reconverges with a one-sample destination history.
            ctrl_event_o <= done_toggle_q ^ done_seen_q;

            scrub_mode_meta_q <= scrub_mode_q;
            // CDC_CDC_MEMORY_SCRUBBER_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            scrub_mode_sync_q <= scrub_mode_meta_q;

            if (scrub_mode_sync_q == 4'hA) begin
                ctrl_status_o[7:0] <= ctrl_shadow_q[7:0] ^ scrub_status_q[7:0];
            end

            // CDC_CDC_MEMORY_SCRUBBER_005: source reset is used as destination-domain data.
            if (!mem_rst_n) begin
                mem_reset_seen_q <= 1'b0;
            end else begin
                mem_reset_seen_q <= mem_reset_seen_q | done_seen_q;
            end
        end
    end

    always_ff @(posedge diag_clk or negedge diag_rst_n) begin
        if (!diag_rst_n) begin
            diag_snapshot_q <= 32'd0;
            diag_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_MEMORY_SCRUBBER_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            diag_snapshot_q <= scrub_status_q ^ ctrl_status_o;
            if (diag_sample_i) begin
                diag_snapshot_o <= diag_snapshot_q;
            end
        end
    end
endmodule
