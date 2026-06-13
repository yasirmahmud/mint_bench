// SPDX-License-Identifier: MIT
//
// CAN bus gateway CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module cdc_can_bus_gateway_top (
    input  logic        can_clk,
    input  logic        sys_clk,
    input  logic        diag_clk,
    input  logic        can_rst_n,
    input  logic        sys_rst_n,
    input  logic        diag_rst_n,
    input  logic        frame_i,
    input  logic [31:0] can_frame_i,
    input  logic [3:0]  filter_mode_i,
    input  logic        diag_sample_i,
    output logic [31:0] sys_status_o,
    output logic        sys_event_o,
    output logic [31:0] diag_snapshot_o
);
    logic [31:0] can_frame_q;
    logic [3:0]  filter_mode_q;
    logic        frame_pulse_q;
    logic        frame_toggle_q;
    logic        frame_seen_q;
    logic [3:0]  filter_mode_meta_q;
    logic [3:0]  filter_mode_sync_q;
    logic        can_reset_seen_q;
    logic [31:0] sys_shadow_q;
    logic [31:0] diag_snapshot_q;

    always_ff @(posedge can_clk or negedge can_rst_n) begin
        if (!can_rst_n) begin
            can_frame_q <= 32'd0;
            filter_mode_q <= 4'd0;
            frame_pulse_q <= 1'b0;
            frame_toggle_q <= 1'b0;
        end else begin
            can_frame_q <= can_frame_i + {24'd0, filter_mode_i, 4'd3};
            filter_mode_q <= filter_mode_i;
            frame_pulse_q <= frame_i;
            if (frame_i) begin
                frame_toggle_q <= ~frame_toggle_q;
            end
        end
    end

    always_ff @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin
            sys_status_o <= 32'd0;
            sys_event_o <= 1'b0;
            frame_seen_q <= 1'b0;
            filter_mode_meta_q <= 4'd0;
            filter_mode_sync_q <= 4'd0;
            can_reset_seen_q <= 1'b0;
            sys_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_CAN_BUS_GATEWAY_001: multi-bit source payload is sampled without a coherency protocol.
            sys_status_o <= can_frame_q;

            // CDC_CDC_CAN_BUS_GATEWAY_002: one-cycle source pulse is consumed directly by the destination.
            if (frame_pulse_q) begin
                sys_shadow_q <= can_frame_q;
            end

            frame_seen_q <= frame_toggle_q;
            // CDC_CDC_CAN_BUS_GATEWAY_003: raw toggle reconverges with a one-sample destination history.
            sys_event_o <= frame_toggle_q ^ frame_seen_q;

            filter_mode_meta_q <= filter_mode_q;
            // CDC_CDC_CAN_BUS_GATEWAY_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            filter_mode_sync_q <= filter_mode_meta_q;

            if (filter_mode_sync_q == 4'hA) begin
                sys_status_o[7:0] <= sys_shadow_q[7:0] ^ can_frame_q[7:0];
            end

            // CDC_CDC_CAN_BUS_GATEWAY_005: source reset is used as destination-domain data.
            if (!can_rst_n) begin
                can_reset_seen_q <= 1'b0;
            end else begin
                can_reset_seen_q <= can_reset_seen_q | frame_seen_q;
            end
        end
    end

    always_ff @(posedge diag_clk or negedge diag_rst_n) begin
        if (!diag_rst_n) begin
            diag_snapshot_q <= 32'd0;
            diag_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_CAN_BUS_GATEWAY_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            diag_snapshot_q <= can_frame_q ^ sys_status_o;
            if (diag_sample_i) begin
                diag_snapshot_o <= diag_snapshot_q;
            end
        end
    end
endmodule
