// SPDX-License-Identifier: MIT
//
// ML accelerator queue CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module ml_accel_queue_top (
    input  logic        host_clk,
    input  logic        accel_clk,
    input  logic        dma_clk,
    input  logic        host_rst_n,
    input  logic        accel_rst_n,
    input  logic        dma_rst_n,
    input  logic        enqueue_i,
    input  logic [31:0] queue_entry_i,
    input  logic [3:0]  op_mode_i,
    input  logic        dma_sample_i,
    output logic [31:0] accel_status_o,
    output logic        accel_event_o,
    output logic [31:0] dma_snapshot_o
);
    logic [31:0] queue_entry_q;
    logic [3:0]  op_mode_q;
    logic        enqueue_pulse_q;
    logic        enqueue_toggle_q;
    logic        enqueue_seen_q;
    logic [3:0]  op_mode_meta_q;
    logic [3:0]  op_mode_sync_q;
    logic        host_reset_seen_q;
    logic [31:0] accel_shadow_q;
    logic [31:0] dma_snapshot_q;

    always_ff @(posedge host_clk or negedge host_rst_n) begin
        if (!host_rst_n) begin
            queue_entry_q <= 32'd0;
            op_mode_q <= 4'd0;
            enqueue_pulse_q <= 1'b0;
            enqueue_toggle_q <= 1'b0;
        end else begin
            queue_entry_q <= queue_entry_i + {24'd0, op_mode_i, 4'd3};
            op_mode_q <= op_mode_i;
            enqueue_pulse_q <= enqueue_i;
            if (enqueue_i) begin
                enqueue_toggle_q <= ~enqueue_toggle_q;
            end
        end
    end

    always_ff @(posedge accel_clk or negedge accel_rst_n) begin
        if (!accel_rst_n) begin
            accel_status_o <= 32'd0;
            accel_event_o <= 1'b0;
            enqueue_seen_q <= 1'b0;
            op_mode_meta_q <= 4'd0;
            op_mode_sync_q <= 4'd0;
            host_reset_seen_q <= 1'b0;
            accel_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_ML_ACCEL_QUEUE_001: multi-bit source payload is sampled without a coherency protocol.
            accel_status_o <= queue_entry_q;

            // CDC_CDC_ML_ACCEL_QUEUE_002: one-cycle source pulse is consumed directly by the destination.
            if (enqueue_pulse_q) begin
                accel_shadow_q <= queue_entry_q;
            end

            enqueue_seen_q <= enqueue_toggle_q;
            // CDC_CDC_ML_ACCEL_QUEUE_003: raw toggle reconverges with a one-sample destination history.
            accel_event_o <= enqueue_toggle_q ^ enqueue_seen_q;

            op_mode_meta_q <= op_mode_q;
            // CDC_CDC_ML_ACCEL_QUEUE_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            op_mode_sync_q <= op_mode_meta_q;

            if (op_mode_sync_q == 4'hA) begin
                accel_status_o[7:0] <= accel_shadow_q[7:0] ^ queue_entry_q[7:0];
            end

            // CDC_CDC_ML_ACCEL_QUEUE_005: source reset is used as destination-domain data.
            if (!host_rst_n) begin
                host_reset_seen_q <= 1'b0;
            end else begin
                host_reset_seen_q <= host_reset_seen_q | enqueue_seen_q;
            end
        end
    end

    always_ff @(posedge dma_clk or negedge dma_rst_n) begin
        if (!dma_rst_n) begin
            dma_snapshot_q <= 32'd0;
            dma_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_ML_ACCEL_QUEUE_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            dma_snapshot_q <= queue_entry_q ^ accel_status_o;
            if (dma_sample_i) begin
                dma_snapshot_o <= dma_snapshot_q;
            end
        end
    end
endmodule
