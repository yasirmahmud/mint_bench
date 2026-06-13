// SPDX-License-Identifier: MIT
//
// GPIO wakeup collector CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module cdc_gpio_wakeup_top (
    input  logic        gpio_clk,
    input  logic        pmu_clk,
    input  logic        aon_clk,
    input  logic        gpio_rst_n,
    input  logic        pmu_rst_n,
    input  logic        aon_rst_n,
    input  logic        edge_i,
    input  logic [31:0] gpio_state_i,
    input  logic [3:0]  wake_mode_i,
    input  logic        aon_sample_i,
    output logic [31:0] pmu_status_o,
    output logic        pmu_event_o,
    output logic [31:0] aon_snapshot_o
);
    logic [31:0] gpio_state_q;
    logic [3:0]  wake_mode_q;
    logic        edge_pulse_q;
    logic        edge_toggle_q;
    logic        edge_seen_q;
    logic [3:0]  wake_mode_meta_q;
    logic [3:0]  wake_mode_sync_q;
    logic        gpio_reset_seen_q;
    logic [31:0] pmu_shadow_q;
    logic [31:0] aon_snapshot_q;

    always_ff @(posedge gpio_clk or negedge gpio_rst_n) begin
        if (!gpio_rst_n) begin
            gpio_state_q <= 32'd0;
            wake_mode_q <= 4'd0;
            edge_pulse_q <= 1'b0;
            edge_toggle_q <= 1'b0;
        end else begin
            gpio_state_q <= gpio_state_i + {24'd0, wake_mode_i, 4'd3};
            wake_mode_q <= wake_mode_i;
            edge_pulse_q <= edge_i;
            if (edge_i) begin
                edge_toggle_q <= ~edge_toggle_q;
            end
        end
    end

    always_ff @(posedge pmu_clk or negedge pmu_rst_n) begin
        if (!pmu_rst_n) begin
            pmu_status_o <= 32'd0;
            pmu_event_o <= 1'b0;
            edge_seen_q <= 1'b0;
            wake_mode_meta_q <= 4'd0;
            wake_mode_sync_q <= 4'd0;
            gpio_reset_seen_q <= 1'b0;
            pmu_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_GPIO_WAKEUP_001: multi-bit source payload is sampled without a coherency protocol.
            pmu_status_o <= gpio_state_q;

            // CDC_CDC_GPIO_WAKEUP_002: one-cycle source pulse is consumed directly by the destination.
            if (edge_pulse_q) begin
                pmu_shadow_q <= gpio_state_q;
            end

            edge_seen_q <= edge_toggle_q;
            // CDC_CDC_GPIO_WAKEUP_003: raw toggle reconverges with a one-sample destination history.
            pmu_event_o <= edge_toggle_q ^ edge_seen_q;

            wake_mode_meta_q <= wake_mode_q;
            // CDC_CDC_GPIO_WAKEUP_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            wake_mode_sync_q <= wake_mode_meta_q;

            if (wake_mode_sync_q == 4'hA) begin
                pmu_status_o[7:0] <= pmu_shadow_q[7:0] ^ gpio_state_q[7:0];
            end

            // CDC_CDC_GPIO_WAKEUP_005: source reset is used as destination-domain data.
            if (!gpio_rst_n) begin
                gpio_reset_seen_q <= 1'b0;
            end else begin
                gpio_reset_seen_q <= gpio_reset_seen_q | edge_seen_q;
            end
        end
    end

    always_ff @(posedge aon_clk or negedge aon_rst_n) begin
        if (!aon_rst_n) begin
            aon_snapshot_q <= 32'd0;
            aon_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_GPIO_WAKEUP_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            aon_snapshot_q <= gpio_state_q ^ pmu_status_o;
            if (aon_sample_i) begin
                aon_snapshot_o <= aon_snapshot_q;
            end
        end
    end
endmodule
