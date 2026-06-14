// SPDX-License-Identifier: MIT
//
// I2C register bank CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module i2c_register_bank_top (
    input  logic        i2c_clk,
    input  logic        cfg_clk,
    input  logic        sys_clk,
    input  logic        i2c_rst_n,
    input  logic        cfg_rst_n,
    input  logic        sys_rst_n,
    input  logic        stop_i,
    input  logic [31:0] i2c_shadow_i,
    input  logic [3:0]  bank_i,
    input  logic        sys_sample_i,
    output logic [31:0] cfg_status_o,
    output logic        cfg_event_o,
    output logic [31:0] sys_snapshot_o
);
    logic [31:0] i2c_shadow_q;
    logic [3:0]  bank_q;
    logic        stop_pulse_q;
    logic        stop_toggle_q;
    logic        stop_seen_q;
    logic [3:0]  bank_meta_q;
    logic [3:0]  bank_sync_q;
    logic        i2c_reset_seen_q;
    logic [31:0] cfg_shadow_q;
    logic [31:0] sys_snapshot_q;

    always_ff @(posedge i2c_clk or negedge i2c_rst_n) begin
        if (!i2c_rst_n) begin
            i2c_shadow_q <= 32'd0;
            bank_q <= 4'd0;
            stop_pulse_q <= 1'b0;
            stop_toggle_q <= 1'b0;
        end else begin
            i2c_shadow_q <= i2c_shadow_i + {24'd0, bank_i, 4'd3};
            bank_q <= bank_i;
            stop_pulse_q <= stop_i;
            if (stop_i) begin
                stop_toggle_q <= ~stop_toggle_q;
            end
        end
    end

    always_ff @(posedge cfg_clk or negedge cfg_rst_n) begin
        if (!cfg_rst_n) begin
            cfg_status_o <= 32'd0;
            cfg_event_o <= 1'b0;
            stop_seen_q <= 1'b0;
            bank_meta_q <= 4'd0;
            bank_sync_q <= 4'd0;
            i2c_reset_seen_q <= 1'b0;
            cfg_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_I2C_REGISTER_BANK_001: multi-bit source payload is sampled without a coherency protocol.
            cfg_status_o <= i2c_shadow_q;

            // CDC_CDC_I2C_REGISTER_BANK_002: one-cycle source pulse is consumed directly by the destination.
            if (stop_pulse_q) begin
                cfg_shadow_q <= i2c_shadow_q;
            end

            stop_seen_q <= stop_toggle_q;
            // CDC_CDC_I2C_REGISTER_BANK_003: raw toggle reconverges with a one-sample destination history.
            cfg_event_o <= stop_toggle_q ^ stop_seen_q;

            bank_meta_q <= bank_q;
            // CDC_CDC_I2C_REGISTER_BANK_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            bank_sync_q <= bank_meta_q;

            if (bank_sync_q == 4'hA) begin
                cfg_status_o[7:0] <= cfg_shadow_q[7:0] ^ i2c_shadow_q[7:0];
            end

            // CDC_CDC_I2C_REGISTER_BANK_005: source reset is used as destination-domain data.
            if (!i2c_rst_n) begin
                i2c_reset_seen_q <= 1'b0;
            end else begin
                i2c_reset_seen_q <= i2c_reset_seen_q | stop_seen_q;
            end
        end
    end

    always_ff @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin
            sys_snapshot_q <= 32'd0;
            sys_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_I2C_REGISTER_BANK_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            sys_snapshot_q <= i2c_shadow_q ^ cfg_status_o;
            if (sys_sample_i) begin
                sys_snapshot_o <= sys_snapshot_q;
            end
        end
    end
endmodule
