// SPDX-License-Identifier: MIT
//
// JTAG access port CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module cdc_jtag_access_port_top (
    input  logic        jtag_clk,
    input  logic        system_clk,
    input  logic        trace_clk,
    input  logic        jtag_rst_n,
    input  logic        system_rst_n,
    input  logic        trace_rst_n,
    input  logic        update_i,
    input  logic [31:0] jtag_shift_i,
    input  logic [3:0]  tap_state_i,
    input  logic        trace_sample_i,
    output logic [31:0] system_status_o,
    output logic        system_event_o,
    output logic [31:0] trace_snapshot_o
);
    logic [31:0] jtag_shift_q;
    logic [3:0]  tap_state_q;
    logic        update_pulse_q;
    logic        update_toggle_q;
    logic        update_seen_q;
    logic [3:0]  tap_state_meta_q;
    logic [3:0]  tap_state_sync_q;
    logic        jtag_reset_seen_q;
    logic [31:0] system_shadow_q;
    logic [31:0] trace_snapshot_q;

    always_ff @(posedge jtag_clk or negedge jtag_rst_n) begin
        if (!jtag_rst_n) begin
            jtag_shift_q <= 32'd0;
            tap_state_q <= 4'd0;
            update_pulse_q <= 1'b0;
            update_toggle_q <= 1'b0;
        end else begin
            jtag_shift_q <= jtag_shift_i + {24'd0, tap_state_i, 4'd3};
            tap_state_q <= tap_state_i;
            update_pulse_q <= update_i;
            if (update_i) begin
                update_toggle_q <= ~update_toggle_q;
            end
        end
    end

    always_ff @(posedge system_clk or negedge system_rst_n) begin
        if (!system_rst_n) begin
            system_status_o <= 32'd0;
            system_event_o <= 1'b0;
            update_seen_q <= 1'b0;
            tap_state_meta_q <= 4'd0;
            tap_state_sync_q <= 4'd0;
            jtag_reset_seen_q <= 1'b0;
            system_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_JTAG_ACCESS_PORT_001: multi-bit source payload is sampled without a coherency protocol.
            system_status_o <= jtag_shift_q;

            // CDC_CDC_JTAG_ACCESS_PORT_002: one-cycle source pulse is consumed directly by the destination.
            if (update_pulse_q) begin
                system_shadow_q <= jtag_shift_q;
            end

            update_seen_q <= update_toggle_q;
            // CDC_CDC_JTAG_ACCESS_PORT_003: raw toggle reconverges with a one-sample destination history.
            system_event_o <= update_toggle_q ^ update_seen_q;

            tap_state_meta_q <= tap_state_q;
            // CDC_CDC_JTAG_ACCESS_PORT_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            tap_state_sync_q <= tap_state_meta_q;

            if (tap_state_sync_q == 4'hA) begin
                system_status_o[7:0] <= system_shadow_q[7:0] ^ jtag_shift_q[7:0];
            end

            // CDC_CDC_JTAG_ACCESS_PORT_005: source reset is used as destination-domain data.
            if (!jtag_rst_n) begin
                jtag_reset_seen_q <= 1'b0;
            end else begin
                jtag_reset_seen_q <= jtag_reset_seen_q | update_seen_q;
            end
        end
    end

    always_ff @(posedge trace_clk or negedge trace_rst_n) begin
        if (!trace_rst_n) begin
            trace_snapshot_q <= 32'd0;
            trace_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_JTAG_ACCESS_PORT_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            trace_snapshot_q <= jtag_shift_q ^ system_status_o;
            if (trace_sample_i) begin
                trace_snapshot_o <= trace_snapshot_q;
            end
        end
    end
endmodule
