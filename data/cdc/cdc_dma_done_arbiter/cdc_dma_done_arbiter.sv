// SPDX-License-Identifier: MIT
//
// DMA done arbiter CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module cdc_dma_done_arbiter_top (
    input  logic        dma_clk,
    input  logic        irq_clk,
    input  logic        cfg_clk,
    input  logic        dma_rst_n,
    input  logic        irq_rst_n,
    input  logic        cfg_rst_n,
    input  logic        done_i,
    input  logic [31:0] done_vector_i,
    input  logic [3:0]  arb_mode_i,
    input  logic        cfg_sample_i,
    output logic [31:0] irq_status_o,
    output logic        irq_event_o,
    output logic [31:0] cfg_snapshot_o
);
    logic [31:0] done_vector_q;
    logic [3:0]  arb_mode_q;
    logic        done_pulse_q;
    logic        done_toggle_q;
    logic        done_seen_q;
    logic [3:0]  arb_mode_meta_q;
    logic [3:0]  arb_mode_sync_q;
    logic        dma_reset_seen_q;
    logic [31:0] irq_shadow_q;
    logic [31:0] cfg_snapshot_q;

    always_ff @(posedge dma_clk or negedge dma_rst_n) begin
        if (!dma_rst_n) begin
            done_vector_q <= 32'd0;
            arb_mode_q <= 4'd0;
            done_pulse_q <= 1'b0;
            done_toggle_q <= 1'b0;
        end else begin
            done_vector_q <= done_vector_i + {24'd0, arb_mode_i, 4'd3};
            arb_mode_q <= arb_mode_i;
            done_pulse_q <= done_i;
            if (done_i) begin
                done_toggle_q <= ~done_toggle_q;
            end
        end
    end

    always_ff @(posedge irq_clk or negedge irq_rst_n) begin
        if (!irq_rst_n) begin
            irq_status_o <= 32'd0;
            irq_event_o <= 1'b0;
            done_seen_q <= 1'b0;
            arb_mode_meta_q <= 4'd0;
            arb_mode_sync_q <= 4'd0;
            dma_reset_seen_q <= 1'b0;
            irq_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_DMA_DONE_ARBITER_001: multi-bit source payload is sampled without a coherency protocol.
            irq_status_o <= done_vector_q;

            // CDC_CDC_DMA_DONE_ARBITER_002: one-cycle source pulse is consumed directly by the destination.
            if (done_pulse_q) begin
                irq_shadow_q <= done_vector_q;
            end

            done_seen_q <= done_toggle_q;
            // CDC_CDC_DMA_DONE_ARBITER_003: raw toggle reconverges with a one-sample destination history.
            irq_event_o <= done_toggle_q ^ done_seen_q;

            arb_mode_meta_q <= arb_mode_q;
            // CDC_CDC_DMA_DONE_ARBITER_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            arb_mode_sync_q <= arb_mode_meta_q;

            if (arb_mode_sync_q == 4'hA) begin
                irq_status_o[7:0] <= irq_shadow_q[7:0] ^ done_vector_q[7:0];
            end

            // CDC_CDC_DMA_DONE_ARBITER_005: source reset is used as destination-domain data.
            if (!dma_rst_n) begin
                dma_reset_seen_q <= 1'b0;
            end else begin
                dma_reset_seen_q <= dma_reset_seen_q | done_seen_q;
            end
        end
    end

    always_ff @(posedge cfg_clk or negedge cfg_rst_n) begin
        if (!cfg_rst_n) begin
            cfg_snapshot_q <= 32'd0;
            cfg_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_DMA_DONE_ARBITER_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            cfg_snapshot_q <= done_vector_q ^ irq_status_o;
            if (cfg_sample_i) begin
                cfg_snapshot_o <= cfg_snapshot_q;
            end
        end
    end
endmodule
