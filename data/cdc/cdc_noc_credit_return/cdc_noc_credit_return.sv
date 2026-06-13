// SPDX-License-Identifier: MIT
//
// NoC credit return path CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module cdc_noc_credit_return_top (
    input  logic        router_clk,
    input  logic        noc_clk,
    input  logic        mgmt_clk,
    input  logic        router_rst_n,
    input  logic        noc_rst_n,
    input  logic        mgmt_rst_n,
    input  logic        credit_i,
    input  logic [31:0] credit_state_i,
    input  logic [3:0]  vc_mode_i,
    input  logic        mgmt_sample_i,
    output logic [31:0] noc_status_o,
    output logic        noc_event_o,
    output logic [31:0] mgmt_snapshot_o
);
    logic [31:0] credit_state_q;
    logic [3:0]  vc_mode_q;
    logic        credit_pulse_q;
    logic        credit_toggle_q;
    logic        credit_seen_q;
    logic [3:0]  vc_mode_meta_q;
    logic [3:0]  vc_mode_sync_q;
    logic        router_reset_seen_q;
    logic [31:0] noc_shadow_q;
    logic [31:0] mgmt_snapshot_q;

    always_ff @(posedge router_clk or negedge router_rst_n) begin
        if (!router_rst_n) begin
            credit_state_q <= 32'd0;
            vc_mode_q <= 4'd0;
            credit_pulse_q <= 1'b0;
            credit_toggle_q <= 1'b0;
        end else begin
            credit_state_q <= credit_state_i + {24'd0, vc_mode_i, 4'd3};
            vc_mode_q <= vc_mode_i;
            credit_pulse_q <= credit_i;
            if (credit_i) begin
                credit_toggle_q <= ~credit_toggle_q;
            end
        end
    end

    always_ff @(posedge noc_clk or negedge noc_rst_n) begin
        if (!noc_rst_n) begin
            noc_status_o <= 32'd0;
            noc_event_o <= 1'b0;
            credit_seen_q <= 1'b0;
            vc_mode_meta_q <= 4'd0;
            vc_mode_sync_q <= 4'd0;
            router_reset_seen_q <= 1'b0;
            noc_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_NOC_CREDIT_RETURN_001: multi-bit source payload is sampled without a coherency protocol.
            noc_status_o <= credit_state_q;

            // CDC_CDC_NOC_CREDIT_RETURN_002: one-cycle source pulse is consumed directly by the destination.
            if (credit_pulse_q) begin
                noc_shadow_q <= credit_state_q;
            end

            credit_seen_q <= credit_toggle_q;
            // CDC_CDC_NOC_CREDIT_RETURN_003: raw toggle reconverges with a one-sample destination history.
            noc_event_o <= credit_toggle_q ^ credit_seen_q;

            vc_mode_meta_q <= vc_mode_q;
            // CDC_CDC_NOC_CREDIT_RETURN_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            vc_mode_sync_q <= vc_mode_meta_q;

            if (vc_mode_sync_q == 4'hA) begin
                noc_status_o[7:0] <= noc_shadow_q[7:0] ^ credit_state_q[7:0];
            end

            // CDC_CDC_NOC_CREDIT_RETURN_005: source reset is used as destination-domain data.
            if (!router_rst_n) begin
                router_reset_seen_q <= 1'b0;
            end else begin
                router_reset_seen_q <= router_reset_seen_q | credit_seen_q;
            end
        end
    end

    always_ff @(posedge mgmt_clk or negedge mgmt_rst_n) begin
        if (!mgmt_rst_n) begin
            mgmt_snapshot_q <= 32'd0;
            mgmt_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_NOC_CREDIT_RETURN_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            mgmt_snapshot_q <= credit_state_q ^ noc_status_o;
            if (mgmt_sample_i) begin
                mgmt_snapshot_o <= mgmt_snapshot_q;
            end
        end
    end
endmodule
