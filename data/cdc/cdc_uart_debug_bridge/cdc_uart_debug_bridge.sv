// SPDX-License-Identifier: MIT
//
// UART debug bridge CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module cdc_uart_debug_bridge_top (
    input  logic        uart_clk,
    input  logic        sys_clk,
    input  logic        debug_clk,
    input  logic        uart_rst_n,
    input  logic        sys_rst_n,
    input  logic        debug_rst_n,
    input  logic        rx_ready_i,
    input  logic [31:0] rx_word_i,
    input  logic [3:0]  debug_mode_i,
    input  logic        debug_sample_i,
    output logic [31:0] sys_status_o,
    output logic        sys_event_o,
    output logic [31:0] debug_snapshot_o
);
    logic [31:0] rx_word_q;
    logic [3:0]  debug_mode_q;
    logic        rx_ready_pulse_q;
    logic        rx_ready_toggle_q;
    logic        rx_ready_seen_q;
    logic [3:0]  debug_mode_meta_q;
    logic [3:0]  debug_mode_sync_q;
    logic        uart_reset_seen_q;
    logic [31:0] sys_shadow_q;
    logic [31:0] debug_snapshot_q;

    always_ff @(posedge uart_clk or negedge uart_rst_n) begin
        if (!uart_rst_n) begin
            rx_word_q <= 32'd0;
            debug_mode_q <= 4'd0;
            rx_ready_pulse_q <= 1'b0;
            rx_ready_toggle_q <= 1'b0;
        end else begin
            rx_word_q <= rx_word_i + {24'd0, debug_mode_i, 4'd3};
            debug_mode_q <= debug_mode_i;
            rx_ready_pulse_q <= rx_ready_i;
            if (rx_ready_i) begin
                rx_ready_toggle_q <= ~rx_ready_toggle_q;
            end
        end
    end

    always_ff @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin
            sys_status_o <= 32'd0;
            sys_event_o <= 1'b0;
            rx_ready_seen_q <= 1'b0;
            debug_mode_meta_q <= 4'd0;
            debug_mode_sync_q <= 4'd0;
            uart_reset_seen_q <= 1'b0;
            sys_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_UART_DEBUG_BRIDGE_001: multi-bit source payload is sampled without a coherency protocol.
            sys_status_o <= rx_word_q;

            // CDC_CDC_UART_DEBUG_BRIDGE_002: one-cycle source pulse is consumed directly by the destination.
            if (rx_ready_pulse_q) begin
                sys_shadow_q <= rx_word_q;
            end

            rx_ready_seen_q <= rx_ready_toggle_q;
            // CDC_CDC_UART_DEBUG_BRIDGE_003: raw toggle reconverges with a one-sample destination history.
            sys_event_o <= rx_ready_toggle_q ^ rx_ready_seen_q;

            debug_mode_meta_q <= debug_mode_q;
            // CDC_CDC_UART_DEBUG_BRIDGE_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            debug_mode_sync_q <= debug_mode_meta_q;

            if (debug_mode_sync_q == 4'hA) begin
                sys_status_o[7:0] <= sys_shadow_q[7:0] ^ rx_word_q[7:0];
            end

            // CDC_CDC_UART_DEBUG_BRIDGE_005: source reset is used as destination-domain data.
            if (!uart_rst_n) begin
                uart_reset_seen_q <= 1'b0;
            end else begin
                uart_reset_seen_q <= uart_reset_seen_q | rx_ready_seen_q;
            end
        end
    end

    always_ff @(posedge debug_clk or negedge debug_rst_n) begin
        if (!debug_rst_n) begin
            debug_snapshot_q <= 32'd0;
            debug_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_UART_DEBUG_BRIDGE_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            debug_snapshot_q <= rx_word_q ^ sys_status_o;
            if (debug_sample_i) begin
                debug_snapshot_o <= debug_snapshot_q;
            end
        end
    end
endmodule
