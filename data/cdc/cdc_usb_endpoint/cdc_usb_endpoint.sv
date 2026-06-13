// SPDX-License-Identifier: MIT
//
// USB endpoint bridge CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module cdc_usb_endpoint_top (
    input  logic        usb_clk,
    input  logic        sys_clk,
    input  logic        debug_clk,
    input  logic        usb_rst_n,
    input  logic        sys_rst_n,
    input  logic        debug_rst_n,
    input  logic        token_i,
    input  logic [31:0] endpoint_data_i,
    input  logic [3:0]  ep_mode_i,
    input  logic        debug_sample_i,
    output logic [31:0] sys_status_o,
    output logic        sys_event_o,
    output logic [31:0] debug_snapshot_o
);
    logic [31:0] endpoint_data_q;
    logic [3:0]  ep_mode_q;
    logic        token_pulse_q;
    logic        token_toggle_q;
    logic        token_seen_q;
    logic [3:0]  ep_mode_meta_q;
    logic [3:0]  ep_mode_sync_q;
    logic        usb_reset_seen_q;
    logic [31:0] sys_shadow_q;
    logic [31:0] debug_snapshot_q;

    always_ff @(posedge usb_clk or negedge usb_rst_n) begin
        if (!usb_rst_n) begin
            endpoint_data_q <= 32'd0;
            ep_mode_q <= 4'd0;
            token_pulse_q <= 1'b0;
            token_toggle_q <= 1'b0;
        end else begin
            endpoint_data_q <= endpoint_data_i + {24'd0, ep_mode_i, 4'd3};
            ep_mode_q <= ep_mode_i;
            token_pulse_q <= token_i;
            if (token_i) begin
                token_toggle_q <= ~token_toggle_q;
            end
        end
    end

    always_ff @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin
            sys_status_o <= 32'd0;
            sys_event_o <= 1'b0;
            token_seen_q <= 1'b0;
            ep_mode_meta_q <= 4'd0;
            ep_mode_sync_q <= 4'd0;
            usb_reset_seen_q <= 1'b0;
            sys_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_USB_ENDPOINT_001: multi-bit source payload is sampled without a coherency protocol.
            sys_status_o <= endpoint_data_q;

            // CDC_CDC_USB_ENDPOINT_002: one-cycle source pulse is consumed directly by the destination.
            if (token_pulse_q) begin
                sys_shadow_q <= endpoint_data_q;
            end

            token_seen_q <= token_toggle_q;
            // CDC_CDC_USB_ENDPOINT_003: raw toggle reconverges with a one-sample destination history.
            sys_event_o <= token_toggle_q ^ token_seen_q;

            ep_mode_meta_q <= ep_mode_q;
            // CDC_CDC_USB_ENDPOINT_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            ep_mode_sync_q <= ep_mode_meta_q;

            if (ep_mode_sync_q == 4'hA) begin
                sys_status_o[7:0] <= sys_shadow_q[7:0] ^ endpoint_data_q[7:0];
            end

            // CDC_CDC_USB_ENDPOINT_005: source reset is used as destination-domain data.
            if (!usb_rst_n) begin
                usb_reset_seen_q <= 1'b0;
            end else begin
                usb_reset_seen_q <= usb_reset_seen_q | token_seen_q;
            end
        end
    end

    always_ff @(posedge debug_clk or negedge debug_rst_n) begin
        if (!debug_rst_n) begin
            debug_snapshot_q <= 32'd0;
            debug_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_USB_ENDPOINT_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            debug_snapshot_q <= endpoint_data_q ^ sys_status_o;
            if (debug_sample_i) begin
                debug_snapshot_o <= debug_snapshot_q;
            end
        end
    end
endmodule
