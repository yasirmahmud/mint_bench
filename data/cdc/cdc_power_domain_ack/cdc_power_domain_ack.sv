// SPDX-License-Identifier: MIT
//
// Power-domain acknowledge path CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module cdc_power_domain_ack_top (
    input  logic        pwr_clk,
    input  logic        soc_clk,
    input  logic        aon_clk,
    input  logic        pwr_rst_n,
    input  logic        soc_rst_n,
    input  logic        aon_rst_n,
    input  logic        ack_i,
    input  logic [31:0] ack_vector_i,
    input  logic [3:0]  power_mode_i,
    input  logic        aon_sample_i,
    output logic [31:0] soc_status_o,
    output logic        soc_event_o,
    output logic [31:0] aon_snapshot_o
);
    logic [31:0] ack_vector_q;
    logic [3:0]  power_mode_q;
    logic        ack_pulse_q;
    logic        ack_toggle_q;
    logic        ack_seen_q;
    logic [3:0]  power_mode_meta_q;
    logic [3:0]  power_mode_sync_q;
    logic        pwr_reset_seen_q;
    logic [31:0] soc_shadow_q;
    logic [31:0] aon_snapshot_q;

    always_ff @(posedge pwr_clk or negedge pwr_rst_n) begin
        if (!pwr_rst_n) begin
            ack_vector_q <= 32'd0;
            power_mode_q <= 4'd0;
            ack_pulse_q <= 1'b0;
            ack_toggle_q <= 1'b0;
        end else begin
            ack_vector_q <= ack_vector_i + {24'd0, power_mode_i, 4'd3};
            power_mode_q <= power_mode_i;
            ack_pulse_q <= ack_i;
            if (ack_i) begin
                ack_toggle_q <= ~ack_toggle_q;
            end
        end
    end

    always_ff @(posedge soc_clk or negedge soc_rst_n) begin
        if (!soc_rst_n) begin
            soc_status_o <= 32'd0;
            soc_event_o <= 1'b0;
            ack_seen_q <= 1'b0;
            power_mode_meta_q <= 4'd0;
            power_mode_sync_q <= 4'd0;
            pwr_reset_seen_q <= 1'b0;
            soc_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_POWER_DOMAIN_ACK_001: multi-bit source payload is sampled without a coherency protocol.
            soc_status_o <= ack_vector_q;

            // CDC_CDC_POWER_DOMAIN_ACK_002: one-cycle source pulse is consumed directly by the destination.
            if (ack_pulse_q) begin
                soc_shadow_q <= ack_vector_q;
            end

            ack_seen_q <= ack_toggle_q;
            // CDC_CDC_POWER_DOMAIN_ACK_003: raw toggle reconverges with a one-sample destination history.
            soc_event_o <= ack_toggle_q ^ ack_seen_q;

            power_mode_meta_q <= power_mode_q;
            // CDC_CDC_POWER_DOMAIN_ACK_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            power_mode_sync_q <= power_mode_meta_q;

            if (power_mode_sync_q == 4'hA) begin
                soc_status_o[7:0] <= soc_shadow_q[7:0] ^ ack_vector_q[7:0];
            end

            // CDC_CDC_POWER_DOMAIN_ACK_005: source reset is used as destination-domain data.
            if (!pwr_rst_n) begin
                pwr_reset_seen_q <= 1'b0;
            end else begin
                pwr_reset_seen_q <= pwr_reset_seen_q | ack_seen_q;
            end
        end
    end

    always_ff @(posedge aon_clk or negedge aon_rst_n) begin
        if (!aon_rst_n) begin
            aon_snapshot_q <= 32'd0;
            aon_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_POWER_DOMAIN_ACK_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            aon_snapshot_q <= ack_vector_q ^ soc_status_o;
            if (aon_sample_i) begin
                aon_snapshot_o <= aon_snapshot_q;
            end
        end
    end
endmodule
