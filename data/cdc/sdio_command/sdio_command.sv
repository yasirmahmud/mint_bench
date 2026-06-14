// SPDX-License-Identifier: MIT
//
// SDIO command bridge CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module sdio_command_top (
    input  logic        sdio_clk,
    input  logic        sys_clk,
    input  logic        dma_clk,
    input  logic        sdio_rst_n,
    input  logic        sys_rst_n,
    input  logic        dma_rst_n,
    input  logic        cmd_done_i,
    input  logic [31:0] cmd_response_i,
    input  logic [3:0]  cmd_mode_i,
    input  logic        dma_sample_i,
    output logic [31:0] sys_status_o,
    output logic        sys_event_o,
    output logic [31:0] dma_snapshot_o
);
    logic [31:0] cmd_response_q;
    logic [3:0]  cmd_mode_q;
    logic        cmd_done_pulse_q;
    logic        cmd_done_toggle_q;
    logic        cmd_done_seen_q;
    logic [3:0]  cmd_mode_meta_q;
    logic [3:0]  cmd_mode_sync_q;
    logic        sdio_reset_seen_q;
    logic [31:0] sys_shadow_q;
    logic [31:0] dma_snapshot_q;

    always_ff @(posedge sdio_clk or negedge sdio_rst_n) begin
        if (!sdio_rst_n) begin
            cmd_response_q <= 32'd0;
            cmd_mode_q <= 4'd0;
            cmd_done_pulse_q <= 1'b0;
            cmd_done_toggle_q <= 1'b0;
        end else begin
            cmd_response_q <= cmd_response_i + {24'd0, cmd_mode_i, 4'd3};
            cmd_mode_q <= cmd_mode_i;
            cmd_done_pulse_q <= cmd_done_i;
            if (cmd_done_i) begin
                cmd_done_toggle_q <= ~cmd_done_toggle_q;
            end
        end
    end

    always_ff @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin
            sys_status_o <= 32'd0;
            sys_event_o <= 1'b0;
            cmd_done_seen_q <= 1'b0;
            cmd_mode_meta_q <= 4'd0;
            cmd_mode_sync_q <= 4'd0;
            sdio_reset_seen_q <= 1'b0;
            sys_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_SDIO_COMMAND_001: multi-bit source payload is sampled without a coherency protocol.
            sys_status_o <= cmd_response_q;

            // CDC_CDC_SDIO_COMMAND_002: one-cycle source pulse is consumed directly by the destination.
            if (cmd_done_pulse_q) begin
                sys_shadow_q <= cmd_response_q;
            end

            cmd_done_seen_q <= cmd_done_toggle_q;
            // CDC_CDC_SDIO_COMMAND_003: raw toggle reconverges with a one-sample destination history.
            sys_event_o <= cmd_done_toggle_q ^ cmd_done_seen_q;

            cmd_mode_meta_q <= cmd_mode_q;
            // CDC_CDC_SDIO_COMMAND_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            cmd_mode_sync_q <= cmd_mode_meta_q;

            if (cmd_mode_sync_q == 4'hA) begin
                sys_status_o[7:0] <= sys_shadow_q[7:0] ^ cmd_response_q[7:0];
            end

            // CDC_CDC_SDIO_COMMAND_005: source reset is used as destination-domain data.
            if (!sdio_rst_n) begin
                sdio_reset_seen_q <= 1'b0;
            end else begin
                sdio_reset_seen_q <= sdio_reset_seen_q | cmd_done_seen_q;
            end
        end
    end

    always_ff @(posedge dma_clk or negedge dma_rst_n) begin
        if (!dma_rst_n) begin
            dma_snapshot_q <= 32'd0;
            dma_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_SDIO_COMMAND_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            dma_snapshot_q <= cmd_response_q ^ sys_status_o;
            if (dma_sample_i) begin
                dma_snapshot_o <= dma_snapshot_q;
            end
        end
    end
endmodule
