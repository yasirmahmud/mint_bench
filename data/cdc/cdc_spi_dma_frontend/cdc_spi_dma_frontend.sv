// SPDX-License-Identifier: MIT
//
// SPI DMA frontend CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module cdc_spi_dma_frontend_top (
    input  logic        spi_clk,
    input  logic        dma_clk,
    input  logic        cfg_clk,
    input  logic        spi_rst_n,
    input  logic        dma_rst_n,
    input  logic        cfg_rst_n,
    input  logic        frame_done_i,
    input  logic [31:0] spi_frame_i,
    input  logic [3:0]  lane_i,
    input  logic        cfg_sample_i,
    output logic [31:0] dma_status_o,
    output logic        dma_event_o,
    output logic [31:0] cfg_snapshot_o
);
    logic [31:0] spi_frame_q;
    logic [3:0]  lane_q;
    logic        frame_done_pulse_q;
    logic        frame_done_toggle_q;
    logic        frame_done_seen_q;
    logic [3:0]  lane_meta_q;
    logic [3:0]  lane_sync_q;
    logic        spi_reset_seen_q;
    logic [31:0] dma_shadow_q;
    logic [31:0] cfg_snapshot_q;

    always_ff @(posedge spi_clk or negedge spi_rst_n) begin
        if (!spi_rst_n) begin
            spi_frame_q <= 32'd0;
            lane_q <= 4'd0;
            frame_done_pulse_q <= 1'b0;
            frame_done_toggle_q <= 1'b0;
        end else begin
            spi_frame_q <= spi_frame_i + {24'd0, lane_i, 4'd3};
            lane_q <= lane_i;
            frame_done_pulse_q <= frame_done_i;
            if (frame_done_i) begin
                frame_done_toggle_q <= ~frame_done_toggle_q;
            end
        end
    end

    always_ff @(posedge dma_clk or negedge dma_rst_n) begin
        if (!dma_rst_n) begin
            dma_status_o <= 32'd0;
            dma_event_o <= 1'b0;
            frame_done_seen_q <= 1'b0;
            lane_meta_q <= 4'd0;
            lane_sync_q <= 4'd0;
            spi_reset_seen_q <= 1'b0;
            dma_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_SPI_DMA_FRONTEND_001: multi-bit source payload is sampled without a coherency protocol.
            dma_status_o <= spi_frame_q;

            // CDC_CDC_SPI_DMA_FRONTEND_002: one-cycle source pulse is consumed directly by the destination.
            if (frame_done_pulse_q) begin
                dma_shadow_q <= spi_frame_q;
            end

            frame_done_seen_q <= frame_done_toggle_q;
            // CDC_CDC_SPI_DMA_FRONTEND_003: raw toggle reconverges with a one-sample destination history.
            dma_event_o <= frame_done_toggle_q ^ frame_done_seen_q;

            lane_meta_q <= lane_q;
            // CDC_CDC_SPI_DMA_FRONTEND_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            lane_sync_q <= lane_meta_q;

            if (lane_sync_q == 4'hA) begin
                dma_status_o[7:0] <= dma_shadow_q[7:0] ^ spi_frame_q[7:0];
            end

            // CDC_CDC_SPI_DMA_FRONTEND_005: source reset is used as destination-domain data.
            if (!spi_rst_n) begin
                spi_reset_seen_q <= 1'b0;
            end else begin
                spi_reset_seen_q <= spi_reset_seen_q | frame_done_seen_q;
            end
        end
    end

    always_ff @(posedge cfg_clk or negedge cfg_rst_n) begin
        if (!cfg_rst_n) begin
            cfg_snapshot_q <= 32'd0;
            cfg_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_SPI_DMA_FRONTEND_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            cfg_snapshot_q <= spi_frame_q ^ dma_status_o;
            if (cfg_sample_i) begin
                cfg_snapshot_o <= cfg_snapshot_q;
            end
        end
    end
endmodule
