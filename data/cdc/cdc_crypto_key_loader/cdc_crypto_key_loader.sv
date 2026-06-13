// SPDX-License-Identifier: MIT
//
// Crypto key loader CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module cdc_crypto_key_loader_top (
    input  logic        key_clk,
    input  logic        crypto_clk,
    input  logic        bus_clk,
    input  logic        key_rst_n,
    input  logic        crypto_rst_n,
    input  logic        bus_rst_n,
    input  logic        key_valid_i,
    input  logic [31:0] key_share_i,
    input  logic [3:0]  key_mode_i,
    input  logic        bus_sample_i,
    output logic [31:0] crypto_status_o,
    output logic        crypto_event_o,
    output logic [31:0] bus_snapshot_o
);
    logic [31:0] key_share_q;
    logic [3:0]  key_mode_q;
    logic        key_valid_pulse_q;
    logic        key_valid_toggle_q;
    logic        key_valid_seen_q;
    logic [3:0]  key_mode_meta_q;
    logic [3:0]  key_mode_sync_q;
    logic        key_reset_seen_q;
    logic [31:0] crypto_shadow_q;
    logic [31:0] bus_snapshot_q;

    always_ff @(posedge key_clk or negedge key_rst_n) begin
        if (!key_rst_n) begin
            key_share_q <= 32'd0;
            key_mode_q <= 4'd0;
            key_valid_pulse_q <= 1'b0;
            key_valid_toggle_q <= 1'b0;
        end else begin
            key_share_q <= key_share_i + {24'd0, key_mode_i, 4'd3};
            key_mode_q <= key_mode_i;
            key_valid_pulse_q <= key_valid_i;
            if (key_valid_i) begin
                key_valid_toggle_q <= ~key_valid_toggle_q;
            end
        end
    end

    always_ff @(posedge crypto_clk or negedge crypto_rst_n) begin
        if (!crypto_rst_n) begin
            crypto_status_o <= 32'd0;
            crypto_event_o <= 1'b0;
            key_valid_seen_q <= 1'b0;
            key_mode_meta_q <= 4'd0;
            key_mode_sync_q <= 4'd0;
            key_reset_seen_q <= 1'b0;
            crypto_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_CRYPTO_KEY_LOADER_001: multi-bit source payload is sampled without a coherency protocol.
            crypto_status_o <= key_share_q;

            // CDC_CDC_CRYPTO_KEY_LOADER_002: one-cycle source pulse is consumed directly by the destination.
            if (key_valid_pulse_q) begin
                crypto_shadow_q <= key_share_q;
            end

            key_valid_seen_q <= key_valid_toggle_q;
            // CDC_CDC_CRYPTO_KEY_LOADER_003: raw toggle reconverges with a one-sample destination history.
            crypto_event_o <= key_valid_toggle_q ^ key_valid_seen_q;

            key_mode_meta_q <= key_mode_q;
            // CDC_CDC_CRYPTO_KEY_LOADER_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            key_mode_sync_q <= key_mode_meta_q;

            if (key_mode_sync_q == 4'hA) begin
                crypto_status_o[7:0] <= crypto_shadow_q[7:0] ^ key_share_q[7:0];
            end

            // CDC_CDC_CRYPTO_KEY_LOADER_005: source reset is used as destination-domain data.
            if (!key_rst_n) begin
                key_reset_seen_q <= 1'b0;
            end else begin
                key_reset_seen_q <= key_reset_seen_q | key_valid_seen_q;
            end
        end
    end

    always_ff @(posedge bus_clk or negedge bus_rst_n) begin
        if (!bus_rst_n) begin
            bus_snapshot_q <= 32'd0;
            bus_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_CRYPTO_KEY_LOADER_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            bus_snapshot_q <= key_share_q ^ crypto_status_o;
            if (bus_sample_i) begin
                bus_snapshot_o <= bus_snapshot_q;
            end
        end
    end
endmodule
