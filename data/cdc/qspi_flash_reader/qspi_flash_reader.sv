// SPDX-License-Identifier: MIT
//
// QSPI flash reader CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module qspi_flash_reader_top (
    input  logic        qspi_clk,
    input  logic        ahb_clk,
    input  logic        cfg_clk,
    input  logic        qspi_rst_n,
    input  logic        ahb_rst_n,
    input  logic        cfg_rst_n,
    input  logic        burst_done_i,
    input  logic [31:0] flash_word_i,
    input  logic [3:0]  read_mode_i,
    input  logic        cfg_sample_i,
    output logic [31:0] ahb_status_o,
    output logic        ahb_event_o,
    output logic [31:0] cfg_snapshot_o
);
    logic [31:0] flash_word_q;
    logic [3:0]  read_mode_q;
    logic        burst_done_pulse_q;
    logic        burst_done_toggle_q;
    logic        burst_done_seen_q;
    logic [3:0]  read_mode_meta_q;
    logic [3:0]  read_mode_sync_q;
    logic        qspi_reset_seen_q;
    logic [31:0] ahb_shadow_q;
    logic [31:0] cfg_snapshot_q;

    always_ff @(posedge qspi_clk or negedge qspi_rst_n) begin
        if (!qspi_rst_n) begin
            flash_word_q <= 32'd0;
            read_mode_q <= 4'd0;
            burst_done_pulse_q <= 1'b0;
            burst_done_toggle_q <= 1'b0;
        end else begin
            flash_word_q <= flash_word_i + {24'd0, read_mode_i, 4'd3};
            read_mode_q <= read_mode_i;
            burst_done_pulse_q <= burst_done_i;
            if (burst_done_i) begin
                burst_done_toggle_q <= ~burst_done_toggle_q;
            end
        end
    end

    always_ff @(posedge ahb_clk or negedge ahb_rst_n) begin
        if (!ahb_rst_n) begin
            ahb_status_o <= 32'd0;
            ahb_event_o <= 1'b0;
            burst_done_seen_q <= 1'b0;
            read_mode_meta_q <= 4'd0;
            read_mode_sync_q <= 4'd0;
            qspi_reset_seen_q <= 1'b0;
            ahb_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_QSPI_FLASH_READER_001: multi-bit source payload is sampled without a coherency protocol.
            ahb_status_o <= flash_word_q;

            // CDC_CDC_QSPI_FLASH_READER_002: one-cycle source pulse is consumed directly by the destination.
            if (burst_done_pulse_q) begin
                ahb_shadow_q <= flash_word_q;
            end

            burst_done_seen_q <= burst_done_toggle_q;
            // CDC_CDC_QSPI_FLASH_READER_003: raw toggle reconverges with a one-sample destination history.
            ahb_event_o <= burst_done_toggle_q ^ burst_done_seen_q;

            read_mode_meta_q <= read_mode_q;
            // CDC_CDC_QSPI_FLASH_READER_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            read_mode_sync_q <= read_mode_meta_q;

            if (read_mode_sync_q == 4'hA) begin
                ahb_status_o[7:0] <= ahb_shadow_q[7:0] ^ flash_word_q[7:0];
            end

            // CDC_CDC_QSPI_FLASH_READER_005: source reset is used as destination-domain data.
            if (!qspi_rst_n) begin
                qspi_reset_seen_q <= 1'b0;
            end else begin
                qspi_reset_seen_q <= qspi_reset_seen_q | burst_done_seen_q;
            end
        end
    end

    always_ff @(posedge cfg_clk or negedge cfg_rst_n) begin
        if (!cfg_rst_n) begin
            cfg_snapshot_q <= 32'd0;
            cfg_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_QSPI_FLASH_READER_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            cfg_snapshot_q <= flash_word_q ^ ahb_status_o;
            if (cfg_sample_i) begin
                cfg_snapshot_o <= cfg_snapshot_q;
            end
        end
    end
endmodule
