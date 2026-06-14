// SPDX-License-Identifier: MIT
//
// DMA descriptor handoff CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module dma_descriptor_top (
    input  logic        cfg_clk,
    input  logic        dma_clk,
    input  logic        mem_clk,
    input  logic        cfg_rst_n,
    input  logic        dma_rst_n,
    input  logic        mem_rst_n,
    input  logic        kick_i,
    input  logic [31:0] descriptor_i,
    input  logic [3:0]  channel_i,
    input  logic        mem_sample_i,
    output logic [31:0] dma_status_o,
    output logic        dma_event_o,
    output logic [31:0] mem_snapshot_o
);
    logic [31:0] descriptor_q;
    logic [3:0]  channel_q;
    logic        kick_pulse_q;
    logic        kick_toggle_q;
    logic        kick_seen_q;
    logic [3:0]  channel_meta_q;
    logic [3:0]  channel_sync_q;
    logic        cfg_reset_seen_q;
    logic [31:0] dma_shadow_q;
    logic [31:0] mem_snapshot_q;

    always_ff @(posedge cfg_clk or negedge cfg_rst_n) begin
        if (!cfg_rst_n) begin
            descriptor_q <= 32'd0;
            channel_q <= 4'd0;
            kick_pulse_q <= 1'b0;
            kick_toggle_q <= 1'b0;
        end else begin
            descriptor_q <= descriptor_i + {24'd0, channel_i, 4'd3};
            channel_q <= channel_i;
            kick_pulse_q <= kick_i;
            if (kick_i) begin
                kick_toggle_q <= ~kick_toggle_q;
            end
        end
    end

    always_ff @(posedge dma_clk or negedge dma_rst_n) begin
        if (!dma_rst_n) begin
            dma_status_o <= 32'd0;
            dma_event_o <= 1'b0;
            kick_seen_q <= 1'b0;
            channel_meta_q <= 4'd0;
            channel_sync_q <= 4'd0;
            cfg_reset_seen_q <= 1'b0;
            dma_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_DMA_DESCRIPTOR_001: multi-bit source payload is sampled without a coherency protocol.
            dma_status_o <= descriptor_q;

            // CDC_CDC_DMA_DESCRIPTOR_002: one-cycle source pulse is consumed directly by the destination.
            if (kick_pulse_q) begin
                dma_shadow_q <= descriptor_q;
            end

            kick_seen_q <= kick_toggle_q;
            // CDC_CDC_DMA_DESCRIPTOR_003: raw toggle reconverges with a one-sample destination history.
            dma_event_o <= kick_toggle_q ^ kick_seen_q;

            channel_meta_q <= channel_q;
            // CDC_CDC_DMA_DESCRIPTOR_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            channel_sync_q <= channel_meta_q;

            if (channel_sync_q == 4'hA) begin
                dma_status_o[7:0] <= dma_shadow_q[7:0] ^ descriptor_q[7:0];
            end

            // CDC_CDC_DMA_DESCRIPTOR_005: source reset is used as destination-domain data.
            if (!cfg_rst_n) begin
                cfg_reset_seen_q <= 1'b0;
            end else begin
                cfg_reset_seen_q <= cfg_reset_seen_q | kick_seen_q;
            end
        end
    end

    always_ff @(posedge mem_clk or negedge mem_rst_n) begin
        if (!mem_rst_n) begin
            mem_snapshot_q <= 32'd0;
            mem_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_DMA_DESCRIPTOR_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            mem_snapshot_q <= descriptor_q ^ dma_status_o;
            if (mem_sample_i) begin
                mem_snapshot_o <= mem_snapshot_q;
            end
        end
    end
endmodule
