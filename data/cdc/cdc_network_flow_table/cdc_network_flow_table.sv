// SPDX-License-Identifier: MIT
//
// Network flow-table bridge CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module cdc_network_flow_table_top (
    input  logic        parser_clk,
    input  logic        lookup_clk,
    input  logic        mgmt_clk,
    input  logic        parser_rst_n,
    input  logic        lookup_rst_n,
    input  logic        mgmt_rst_n,
    input  logic        flow_hit_i,
    input  logic [31:0] flow_key_i,
    input  logic [3:0]  lookup_mode_i,
    input  logic        mgmt_sample_i,
    output logic [31:0] lookup_status_o,
    output logic        lookup_event_o,
    output logic [31:0] mgmt_snapshot_o
);
    logic [31:0] flow_key_q;
    logic [3:0]  lookup_mode_q;
    logic        flow_hit_pulse_q;
    logic        flow_hit_toggle_q;
    logic        flow_hit_seen_q;
    logic [3:0]  lookup_mode_meta_q;
    logic [3:0]  lookup_mode_sync_q;
    logic        parser_reset_seen_q;
    logic [31:0] lookup_shadow_q;
    logic [31:0] mgmt_snapshot_q;

    always_ff @(posedge parser_clk or negedge parser_rst_n) begin
        if (!parser_rst_n) begin
            flow_key_q <= 32'd0;
            lookup_mode_q <= 4'd0;
            flow_hit_pulse_q <= 1'b0;
            flow_hit_toggle_q <= 1'b0;
        end else begin
            flow_key_q <= flow_key_i + {24'd0, lookup_mode_i, 4'd3};
            lookup_mode_q <= lookup_mode_i;
            flow_hit_pulse_q <= flow_hit_i;
            if (flow_hit_i) begin
                flow_hit_toggle_q <= ~flow_hit_toggle_q;
            end
        end
    end

    always_ff @(posedge lookup_clk or negedge lookup_rst_n) begin
        if (!lookup_rst_n) begin
            lookup_status_o <= 32'd0;
            lookup_event_o <= 1'b0;
            flow_hit_seen_q <= 1'b0;
            lookup_mode_meta_q <= 4'd0;
            lookup_mode_sync_q <= 4'd0;
            parser_reset_seen_q <= 1'b0;
            lookup_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_NETWORK_FLOW_TABLE_001: multi-bit source payload is sampled without a coherency protocol.
            lookup_status_o <= flow_key_q;

            // CDC_CDC_NETWORK_FLOW_TABLE_002: one-cycle source pulse is consumed directly by the destination.
            if (flow_hit_pulse_q) begin
                lookup_shadow_q <= flow_key_q;
            end

            flow_hit_seen_q <= flow_hit_toggle_q;
            // CDC_CDC_NETWORK_FLOW_TABLE_003: raw toggle reconverges with a one-sample destination history.
            lookup_event_o <= flow_hit_toggle_q ^ flow_hit_seen_q;

            lookup_mode_meta_q <= lookup_mode_q;
            // CDC_CDC_NETWORK_FLOW_TABLE_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            lookup_mode_sync_q <= lookup_mode_meta_q;

            if (lookup_mode_sync_q == 4'hA) begin
                lookup_status_o[7:0] <= lookup_shadow_q[7:0] ^ flow_key_q[7:0];
            end

            // CDC_CDC_NETWORK_FLOW_TABLE_005: source reset is used as destination-domain data.
            if (!parser_rst_n) begin
                parser_reset_seen_q <= 1'b0;
            end else begin
                parser_reset_seen_q <= parser_reset_seen_q | flow_hit_seen_q;
            end
        end
    end

    always_ff @(posedge mgmt_clk or negedge mgmt_rst_n) begin
        if (!mgmt_rst_n) begin
            mgmt_snapshot_q <= 32'd0;
            mgmt_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_NETWORK_FLOW_TABLE_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            mgmt_snapshot_q <= flow_key_q ^ lookup_status_o;
            if (mgmt_sample_i) begin
                mgmt_snapshot_o <= mgmt_snapshot_q;
            end
        end
    end
endmodule
