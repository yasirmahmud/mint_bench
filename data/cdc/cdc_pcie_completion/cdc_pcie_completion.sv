// SPDX-License-Identifier: MIT
//
// PCIe completion bridge CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module cdc_pcie_completion_top (
    input  logic        pcie_clk,
    input  logic        core_clk,
    input  logic        cfg_clk,
    input  logic        pcie_rst_n,
    input  logic        core_rst_n,
    input  logic        cfg_rst_n,
    input  logic        cpl_i,
    input  logic [31:0] completion_data_i,
    input  logic [3:0]  tag_mode_i,
    input  logic        cfg_sample_i,
    output logic [31:0] core_status_o,
    output logic        core_event_o,
    output logic [31:0] cfg_snapshot_o
);
    logic [31:0] completion_data_q;
    logic [3:0]  tag_mode_q;
    logic        cpl_pulse_q;
    logic        cpl_toggle_q;
    logic        cpl_seen_q;
    logic [3:0]  tag_mode_meta_q;
    logic [3:0]  tag_mode_sync_q;
    logic        pcie_reset_seen_q;
    logic [31:0] core_shadow_q;
    logic [31:0] cfg_snapshot_q;

    always_ff @(posedge pcie_clk or negedge pcie_rst_n) begin
        if (!pcie_rst_n) begin
            completion_data_q <= 32'd0;
            tag_mode_q <= 4'd0;
            cpl_pulse_q <= 1'b0;
            cpl_toggle_q <= 1'b0;
        end else begin
            completion_data_q <= completion_data_i + {24'd0, tag_mode_i, 4'd3};
            tag_mode_q <= tag_mode_i;
            cpl_pulse_q <= cpl_i;
            if (cpl_i) begin
                cpl_toggle_q <= ~cpl_toggle_q;
            end
        end
    end

    always_ff @(posedge core_clk or negedge core_rst_n) begin
        if (!core_rst_n) begin
            core_status_o <= 32'd0;
            core_event_o <= 1'b0;
            cpl_seen_q <= 1'b0;
            tag_mode_meta_q <= 4'd0;
            tag_mode_sync_q <= 4'd0;
            pcie_reset_seen_q <= 1'b0;
            core_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_PCIE_COMPLETION_001: multi-bit source payload is sampled without a coherency protocol.
            core_status_o <= completion_data_q;

            // CDC_CDC_PCIE_COMPLETION_002: one-cycle source pulse is consumed directly by the destination.
            if (cpl_pulse_q) begin
                core_shadow_q <= completion_data_q;
            end

            cpl_seen_q <= cpl_toggle_q;
            // CDC_CDC_PCIE_COMPLETION_003: raw toggle reconverges with a one-sample destination history.
            core_event_o <= cpl_toggle_q ^ cpl_seen_q;

            tag_mode_meta_q <= tag_mode_q;
            // CDC_CDC_PCIE_COMPLETION_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            tag_mode_sync_q <= tag_mode_meta_q;

            if (tag_mode_sync_q == 4'hA) begin
                core_status_o[7:0] <= core_shadow_q[7:0] ^ completion_data_q[7:0];
            end

            // CDC_CDC_PCIE_COMPLETION_005: source reset is used as destination-domain data.
            if (!pcie_rst_n) begin
                pcie_reset_seen_q <= 1'b0;
            end else begin
                pcie_reset_seen_q <= pcie_reset_seen_q | cpl_seen_q;
            end
        end
    end

    always_ff @(posedge cfg_clk or negedge cfg_rst_n) begin
        if (!cfg_rst_n) begin
            cfg_snapshot_q <= 32'd0;
            cfg_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_PCIE_COMPLETION_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            cfg_snapshot_q <= completion_data_q ^ core_status_o;
            if (cfg_sample_i) begin
                cfg_snapshot_o <= cfg_snapshot_q;
            end
        end
    end
endmodule
