// SPDX-License-Identifier: MIT
//
// RISC-V debug hart bridge CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module riscv_debug_hart_top (
    input  logic        dm_clk,
    input  logic        hart_clk,
    input  logic        jtag_clk,
    input  logic        dm_rst_n,
    input  logic        hart_rst_n,
    input  logic        jtag_rst_n,
    input  logic        resume_i,
    input  logic [31:0] hart_cmd_i,
    input  logic [3:0]  debug_mode_i,
    input  logic        jtag_sample_i,
    output logic [31:0] hart_status_o,
    output logic        hart_event_o,
    output logic [31:0] jtag_snapshot_o
);
    logic [31:0] hart_cmd_q;
    logic [3:0]  debug_mode_q;
    logic        resume_pulse_q;
    logic        resume_toggle_q;
    logic        resume_seen_q;
    logic [3:0]  debug_mode_meta_q;
    logic [3:0]  debug_mode_sync_q;
    logic        dm_reset_seen_q;
    logic [31:0] hart_shadow_q;
    logic [31:0] jtag_snapshot_q;

    always_ff @(posedge dm_clk or negedge dm_rst_n) begin
        if (!dm_rst_n) begin
            hart_cmd_q <= 32'd0;
            debug_mode_q <= 4'd0;
            resume_pulse_q <= 1'b0;
            resume_toggle_q <= 1'b0;
        end else begin
            hart_cmd_q <= hart_cmd_i + {24'd0, debug_mode_i, 4'd3};
            debug_mode_q <= debug_mode_i;
            resume_pulse_q <= resume_i;
            if (resume_i) begin
                resume_toggle_q <= ~resume_toggle_q;
            end
        end
    end

    always_ff @(posedge hart_clk or negedge hart_rst_n) begin
        if (!hart_rst_n) begin
            hart_status_o <= 32'd0;
            hart_event_o <= 1'b0;
            resume_seen_q <= 1'b0;
            debug_mode_meta_q <= 4'd0;
            debug_mode_sync_q <= 4'd0;
            dm_reset_seen_q <= 1'b0;
            hart_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_RISCV_DEBUG_HART_001: multi-bit source payload is sampled without a coherency protocol.
            hart_status_o <= hart_cmd_q;

            // CDC_CDC_RISCV_DEBUG_HART_002: one-cycle source pulse is consumed directly by the destination.
            if (resume_pulse_q) begin
                hart_shadow_q <= hart_cmd_q;
            end

            resume_seen_q <= resume_toggle_q;
            // CDC_CDC_RISCV_DEBUG_HART_003: raw toggle reconverges with a one-sample destination history.
            hart_event_o <= resume_toggle_q ^ resume_seen_q;

            debug_mode_meta_q <= debug_mode_q;
            // CDC_CDC_RISCV_DEBUG_HART_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            debug_mode_sync_q <= debug_mode_meta_q;

            if (debug_mode_sync_q == 4'hA) begin
                hart_status_o[7:0] <= hart_shadow_q[7:0] ^ hart_cmd_q[7:0];
            end

            // CDC_CDC_RISCV_DEBUG_HART_005: source reset is used as destination-domain data.
            if (!dm_rst_n) begin
                dm_reset_seen_q <= 1'b0;
            end else begin
                dm_reset_seen_q <= dm_reset_seen_q | resume_seen_q;
            end
        end
    end

    always_ff @(posedge jtag_clk or negedge jtag_rst_n) begin
        if (!jtag_rst_n) begin
            jtag_snapshot_q <= 32'd0;
            jtag_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_RISCV_DEBUG_HART_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            jtag_snapshot_q <= hart_cmd_q ^ hart_status_o;
            if (jtag_sample_i) begin
                jtag_snapshot_o <= jtag_snapshot_q;
            end
        end
    end
endmodule
