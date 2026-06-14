// SPDX-License-Identifier: MIT
//
// Interrupt router CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module interrupt_router_top (
    input  logic        periph_clk,
    input  logic        cpu_clk,
    input  logic        debug_clk,
    input  logic        periph_rst_n,
    input  logic        cpu_rst_n,
    input  logic        debug_rst_n,
    input  logic        irq_i,
    input  logic [31:0] irq_vector_i,
    input  logic [3:0]  priority_i,
    input  logic        debug_sample_i,
    output logic [31:0] cpu_status_o,
    output logic        cpu_event_o,
    output logic [31:0] debug_snapshot_o
);
    logic [31:0] irq_vector_q;
    logic [3:0]  priority_q;
    logic        irq_pulse_q;
    logic        irq_toggle_q;
    logic        irq_seen_q;
    logic [3:0]  priority_meta_q;
    logic [3:0]  priority_sync_q;
    logic        periph_reset_seen_q;
    logic [31:0] cpu_shadow_q;
    logic [31:0] debug_snapshot_q;

    always_ff @(posedge periph_clk or negedge periph_rst_n) begin
        if (!periph_rst_n) begin
            irq_vector_q <= 32'd0;
            priority_q <= 4'd0;
            irq_pulse_q <= 1'b0;
            irq_toggle_q <= 1'b0;
        end else begin
            irq_vector_q <= irq_vector_i + {24'd0, priority_i, 4'd3};
            priority_q <= priority_i;
            irq_pulse_q <= irq_i;
            if (irq_i) begin
                irq_toggle_q <= ~irq_toggle_q;
            end
        end
    end

    always_ff @(posedge cpu_clk or negedge cpu_rst_n) begin
        if (!cpu_rst_n) begin
            cpu_status_o <= 32'd0;
            cpu_event_o <= 1'b0;
            irq_seen_q <= 1'b0;
            priority_meta_q <= 4'd0;
            priority_sync_q <= 4'd0;
            periph_reset_seen_q <= 1'b0;
            cpu_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_INTERRUPT_ROUTER_001: multi-bit source payload is sampled without a coherency protocol.
            cpu_status_o <= irq_vector_q;

            // CDC_CDC_INTERRUPT_ROUTER_002: one-cycle source pulse is consumed directly by the destination.
            if (irq_pulse_q) begin
                cpu_shadow_q <= irq_vector_q;
            end

            irq_seen_q <= irq_toggle_q;
            // CDC_CDC_INTERRUPT_ROUTER_003: raw toggle reconverges with a one-sample destination history.
            cpu_event_o <= irq_toggle_q ^ irq_seen_q;

            priority_meta_q <= priority_q;
            // CDC_CDC_INTERRUPT_ROUTER_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            priority_sync_q <= priority_meta_q;

            if (priority_sync_q == 4'hA) begin
                cpu_status_o[7:0] <= cpu_shadow_q[7:0] ^ irq_vector_q[7:0];
            end

            // CDC_CDC_INTERRUPT_ROUTER_005: source reset is used as destination-domain data.
            if (!periph_rst_n) begin
                periph_reset_seen_q <= 1'b0;
            end else begin
                periph_reset_seen_q <= periph_reset_seen_q | irq_seen_q;
            end
        end
    end

    always_ff @(posedge debug_clk or negedge debug_rst_n) begin
        if (!debug_rst_n) begin
            debug_snapshot_q <= 32'd0;
            debug_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_INTERRUPT_ROUTER_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            debug_snapshot_q <= irq_vector_q ^ cpu_status_o;
            if (debug_sample_i) begin
                debug_snapshot_o <= debug_snapshot_q;
            end
        end
    end
endmodule
