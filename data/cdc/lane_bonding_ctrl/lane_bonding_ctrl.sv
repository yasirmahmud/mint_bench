// SPDX-License-Identifier: MIT
//
// Lane bonding controller CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module lane_bonding_ctrl_top (
    input  logic        lane_clk,
    input  logic        pcs_clk,
    input  logic        cfg_clk,
    input  logic        lane_rst_n,
    input  logic        pcs_rst_n,
    input  logic        cfg_rst_n,
    input  logic        bond_done_i,
    input  logic [31:0] bond_state_i,
    input  logic [3:0]  bond_mode_i,
    input  logic        cfg_sample_i,
    output logic [31:0] pcs_status_o,
    output logic        pcs_event_o,
    output logic [31:0] cfg_snapshot_o
);
    logic [31:0] bond_state_q;
    logic [3:0]  bond_mode_q;
    logic        bond_done_pulse_q;
    logic        bond_done_toggle_q;
    logic        bond_done_seen_q;
    logic [3:0]  bond_mode_meta_q;
    logic [3:0]  bond_mode_sync_q;
    logic        lane_reset_seen_q;
    logic [31:0] pcs_shadow_q;
    logic [31:0] cfg_snapshot_q;

    always_ff @(posedge lane_clk or negedge lane_rst_n) begin
        if (!lane_rst_n) begin
            bond_state_q <= 32'd0;
            bond_mode_q <= 4'd0;
            bond_done_pulse_q <= 1'b0;
            bond_done_toggle_q <= 1'b0;
        end else begin
            bond_state_q <= bond_state_i + {24'd0, bond_mode_i, 4'd3};
            bond_mode_q <= bond_mode_i;
            bond_done_pulse_q <= bond_done_i;
            if (bond_done_i) begin
                bond_done_toggle_q <= ~bond_done_toggle_q;
            end
        end
    end

    always_ff @(posedge pcs_clk or negedge pcs_rst_n) begin
        if (!pcs_rst_n) begin
            pcs_status_o <= 32'd0;
            pcs_event_o <= 1'b0;
            bond_done_seen_q <= 1'b0;
            bond_mode_meta_q <= 4'd0;
            bond_mode_sync_q <= 4'd0;
            lane_reset_seen_q <= 1'b0;
            pcs_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_LANE_BONDING_CTRL_001: multi-bit source payload is sampled without a coherency protocol.
            pcs_status_o <= bond_state_q;

            // CDC_CDC_LANE_BONDING_CTRL_002: one-cycle source pulse is consumed directly by the destination.
            if (bond_done_pulse_q) begin
                pcs_shadow_q <= bond_state_q;
            end

            bond_done_seen_q <= bond_done_toggle_q;
            // CDC_CDC_LANE_BONDING_CTRL_003: raw toggle reconverges with a one-sample destination history.
            pcs_event_o <= bond_done_toggle_q ^ bond_done_seen_q;

            bond_mode_meta_q <= bond_mode_q;
            // CDC_CDC_LANE_BONDING_CTRL_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            bond_mode_sync_q <= bond_mode_meta_q;

            if (bond_mode_sync_q == 4'hA) begin
                pcs_status_o[7:0] <= pcs_shadow_q[7:0] ^ bond_state_q[7:0];
            end

            // CDC_CDC_LANE_BONDING_CTRL_005: source reset is used as destination-domain data.
            if (!lane_rst_n) begin
                lane_reset_seen_q <= 1'b0;
            end else begin
                lane_reset_seen_q <= lane_reset_seen_q | bond_done_seen_q;
            end
        end
    end

    always_ff @(posedge cfg_clk or negedge cfg_rst_n) begin
        if (!cfg_rst_n) begin
            cfg_snapshot_q <= 32'd0;
            cfg_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_LANE_BONDING_CTRL_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            cfg_snapshot_q <= bond_state_q ^ pcs_status_o;
            if (cfg_sample_i) begin
                cfg_snapshot_o <= cfg_snapshot_q;
            end
        end
    end
endmodule
