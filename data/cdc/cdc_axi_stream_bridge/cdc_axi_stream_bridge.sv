// SPDX-License-Identifier: MIT
//
// AXI stream bridge CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module cdc_axi_stream_bridge_top (
    input  logic        s_axis_clk,
    input  logic        m_axis_clk,
    input  logic        cfg_clk,
    input  logic        s_axis_rst_n,
    input  logic        m_axis_rst_n,
    input  logic        cfg_rst_n,
    input  logic        tlast_i,
    input  logic [31:0] packet_i,
    input  logic [3:0]  route_i,
    input  logic        cfg_sample_i,
    output logic [31:0] m_axis_status_o,
    output logic        m_axis_event_o,
    output logic [31:0] cfg_snapshot_o
);
    logic [31:0] packet_q;
    logic [3:0]  route_q;
    logic        tlast_pulse_q;
    logic        tlast_toggle_q;
    logic        tlast_seen_q;
    logic [3:0]  route_meta_q;
    logic [3:0]  route_sync_q;
    logic        s_axis_reset_seen_q;
    logic [31:0] m_axis_shadow_q;
    logic [31:0] cfg_snapshot_q;

    always_ff @(posedge s_axis_clk or negedge s_axis_rst_n) begin
        if (!s_axis_rst_n) begin
            packet_q <= 32'd0;
            route_q <= 4'd0;
            tlast_pulse_q <= 1'b0;
            tlast_toggle_q <= 1'b0;
        end else begin
            packet_q <= packet_i + {24'd0, route_i, 4'd3};
            route_q <= route_i;
            tlast_pulse_q <= tlast_i;
            if (tlast_i) begin
                tlast_toggle_q <= ~tlast_toggle_q;
            end
        end
    end

    always_ff @(posedge m_axis_clk or negedge m_axis_rst_n) begin
        if (!m_axis_rst_n) begin
            m_axis_status_o <= 32'd0;
            m_axis_event_o <= 1'b0;
            tlast_seen_q <= 1'b0;
            route_meta_q <= 4'd0;
            route_sync_q <= 4'd0;
            s_axis_reset_seen_q <= 1'b0;
            m_axis_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_AXI_STREAM_BRIDGE_001: multi-bit source payload is sampled without a coherency protocol.
            m_axis_status_o <= packet_q;

            // CDC_CDC_AXI_STREAM_BRIDGE_002: one-cycle source pulse is consumed directly by the destination.
            if (tlast_pulse_q) begin
                m_axis_shadow_q <= packet_q;
            end

            tlast_seen_q <= tlast_toggle_q;
            // CDC_CDC_AXI_STREAM_BRIDGE_003: raw toggle reconverges with a one-sample destination history.
            m_axis_event_o <= tlast_toggle_q ^ tlast_seen_q;

            route_meta_q <= route_q;
            // CDC_CDC_AXI_STREAM_BRIDGE_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            route_sync_q <= route_meta_q;

            if (route_sync_q == 4'hA) begin
                m_axis_status_o[7:0] <= m_axis_shadow_q[7:0] ^ packet_q[7:0];
            end

            // CDC_CDC_AXI_STREAM_BRIDGE_005: source reset is used as destination-domain data.
            if (!s_axis_rst_n) begin
                s_axis_reset_seen_q <= 1'b0;
            end else begin
                s_axis_reset_seen_q <= s_axis_reset_seen_q | tlast_seen_q;
            end
        end
    end

    always_ff @(posedge cfg_clk or negedge cfg_rst_n) begin
        if (!cfg_rst_n) begin
            cfg_snapshot_q <= 32'd0;
            cfg_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_AXI_STREAM_BRIDGE_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            cfg_snapshot_q <= packet_q ^ m_axis_status_o;
            if (cfg_sample_i) begin
                cfg_snapshot_o <= cfg_snapshot_q;
            end
        end
    end
endmodule
