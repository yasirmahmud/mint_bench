// SPDX-License-Identifier: MIT
//
// Boot ROM patch bridge CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module cdc_boot_rom_patch_top (
    input  logic        rom_clk,
    input  logic        core_clk,
    input  logic        cfg_clk,
    input  logic        rom_rst_n,
    input  logic        core_rst_n,
    input  logic        cfg_rst_n,
    input  logic        patch_valid_i,
    input  logic [31:0] patch_word_i,
    input  logic [3:0]  patch_mode_i,
    input  logic        cfg_sample_i,
    output logic [31:0] core_status_o,
    output logic        core_event_o,
    output logic [31:0] cfg_snapshot_o
);
    logic [31:0] patch_word_q;
    logic [3:0]  patch_mode_q;
    logic        patch_valid_pulse_q;
    logic        patch_valid_toggle_q;
    logic        patch_valid_seen_q;
    logic [3:0]  patch_mode_meta_q;
    logic [3:0]  patch_mode_sync_q;
    logic        rom_reset_seen_q;
    logic [31:0] core_shadow_q;
    logic [31:0] cfg_snapshot_q;

    always_ff @(posedge rom_clk or negedge rom_rst_n) begin
        if (!rom_rst_n) begin
            patch_word_q <= 32'd0;
            patch_mode_q <= 4'd0;
            patch_valid_pulse_q <= 1'b0;
            patch_valid_toggle_q <= 1'b0;
        end else begin
            patch_word_q <= patch_word_i + {24'd0, patch_mode_i, 4'd3};
            patch_mode_q <= patch_mode_i;
            patch_valid_pulse_q <= patch_valid_i;
            if (patch_valid_i) begin
                patch_valid_toggle_q <= ~patch_valid_toggle_q;
            end
        end
    end

    always_ff @(posedge core_clk or negedge core_rst_n) begin
        if (!core_rst_n) begin
            core_status_o <= 32'd0;
            core_event_o <= 1'b0;
            patch_valid_seen_q <= 1'b0;
            patch_mode_meta_q <= 4'd0;
            patch_mode_sync_q <= 4'd0;
            rom_reset_seen_q <= 1'b0;
            core_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_BOOT_ROM_PATCH_001: multi-bit source payload is sampled without a coherency protocol.
            core_status_o <= patch_word_q;

            // CDC_CDC_BOOT_ROM_PATCH_002: one-cycle source pulse is consumed directly by the destination.
            if (patch_valid_pulse_q) begin
                core_shadow_q <= patch_word_q;
            end

            patch_valid_seen_q <= patch_valid_toggle_q;
            // CDC_CDC_BOOT_ROM_PATCH_003: raw toggle reconverges with a one-sample destination history.
            core_event_o <= patch_valid_toggle_q ^ patch_valid_seen_q;

            patch_mode_meta_q <= patch_mode_q;
            // CDC_CDC_BOOT_ROM_PATCH_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            patch_mode_sync_q <= patch_mode_meta_q;

            if (patch_mode_sync_q == 4'hA) begin
                core_status_o[7:0] <= core_shadow_q[7:0] ^ patch_word_q[7:0];
            end

            // CDC_CDC_BOOT_ROM_PATCH_005: source reset is used as destination-domain data.
            if (!rom_rst_n) begin
                rom_reset_seen_q <= 1'b0;
            end else begin
                rom_reset_seen_q <= rom_reset_seen_q | patch_valid_seen_q;
            end
        end
    end

    always_ff @(posedge cfg_clk or negedge cfg_rst_n) begin
        if (!cfg_rst_n) begin
            cfg_snapshot_q <= 32'd0;
            cfg_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_BOOT_ROM_PATCH_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            cfg_snapshot_q <= patch_word_q ^ core_status_o;
            if (cfg_sample_i) begin
                cfg_snapshot_o <= cfg_snapshot_q;
            end
        end
    end
endmodule
