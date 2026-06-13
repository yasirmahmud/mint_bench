// SPDX-License-Identifier: MIT
//
// Error aggregator CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module cdc_error_aggregator_top (
    input  logic        block_clk,
    input  logic        service_clk,
    input  logic        trace_clk,
    input  logic        block_rst_n,
    input  logic        service_rst_n,
    input  logic        trace_rst_n,
    input  logic        fault_i,
    input  logic [31:0] error_bundle_i,
    input  logic [3:0]  mask_mode_i,
    input  logic        trace_sample_i,
    output logic [31:0] service_status_o,
    output logic        service_event_o,
    output logic [31:0] trace_snapshot_o
);
    logic [31:0] error_bundle_q;
    logic [3:0]  mask_mode_q;
    logic        fault_pulse_q;
    logic        fault_toggle_q;
    logic        fault_seen_q;
    logic [3:0]  mask_mode_meta_q;
    logic [3:0]  mask_mode_sync_q;
    logic        block_reset_seen_q;
    logic [31:0] service_shadow_q;
    logic [31:0] trace_snapshot_q;

    always_ff @(posedge block_clk or negedge block_rst_n) begin
        if (!block_rst_n) begin
            error_bundle_q <= 32'd0;
            mask_mode_q <= 4'd0;
            fault_pulse_q <= 1'b0;
            fault_toggle_q <= 1'b0;
        end else begin
            error_bundle_q <= error_bundle_i + {24'd0, mask_mode_i, 4'd3};
            mask_mode_q <= mask_mode_i;
            fault_pulse_q <= fault_i;
            if (fault_i) begin
                fault_toggle_q <= ~fault_toggle_q;
            end
        end
    end

    always_ff @(posedge service_clk or negedge service_rst_n) begin
        if (!service_rst_n) begin
            service_status_o <= 32'd0;
            service_event_o <= 1'b0;
            fault_seen_q <= 1'b0;
            mask_mode_meta_q <= 4'd0;
            mask_mode_sync_q <= 4'd0;
            block_reset_seen_q <= 1'b0;
            service_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_ERROR_AGGREGATOR_001: multi-bit source payload is sampled without a coherency protocol.
            service_status_o <= error_bundle_q;

            // CDC_CDC_ERROR_AGGREGATOR_002: one-cycle source pulse is consumed directly by the destination.
            if (fault_pulse_q) begin
                service_shadow_q <= error_bundle_q;
            end

            fault_seen_q <= fault_toggle_q;
            // CDC_CDC_ERROR_AGGREGATOR_003: raw toggle reconverges with a one-sample destination history.
            service_event_o <= fault_toggle_q ^ fault_seen_q;

            mask_mode_meta_q <= mask_mode_q;
            // CDC_CDC_ERROR_AGGREGATOR_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            mask_mode_sync_q <= mask_mode_meta_q;

            if (mask_mode_sync_q == 4'hA) begin
                service_status_o[7:0] <= service_shadow_q[7:0] ^ error_bundle_q[7:0];
            end

            // CDC_CDC_ERROR_AGGREGATOR_005: source reset is used as destination-domain data.
            if (!block_rst_n) begin
                block_reset_seen_q <= 1'b0;
            end else begin
                block_reset_seen_q <= block_reset_seen_q | fault_seen_q;
            end
        end
    end

    always_ff @(posedge trace_clk or negedge trace_rst_n) begin
        if (!trace_rst_n) begin
            trace_snapshot_q <= 32'd0;
            trace_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_ERROR_AGGREGATOR_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            trace_snapshot_q <= error_bundle_q ^ service_status_o;
            if (trace_sample_i) begin
                trace_snapshot_o <= trace_snapshot_q;
            end
        end
    end
endmodule
