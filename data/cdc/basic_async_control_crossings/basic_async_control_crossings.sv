// SPDX-License-Identifier: MIT
//
// Small CDC validation design.
// The comments marked CDC_MINIMAL_* identify intentional CDC defects.

`timescale 1ns/1ps

module basic_async_control_crossings_top (
    input  logic        src_clk,
    input  logic        dst_clk,
    input  logic        aux_clk,
    input  logic        src_rst_n,
    input  logic        dst_rst_n,
    input  logic        aux_rst_n,
    input  logic        src_event_i,
    input  logic [7:0]  src_data_i,
    input  logic        aux_debug_i,
    output logic [7:0]  dst_data_o,
    output logic        dst_irq_o,
    output logic        aux_seen_o
);
    logic       src_pulse;
    logic       src_toggle;
    logic [7:0] src_bus;
    logic       aux_flag;
    logic       dst_toggle_q;
    logic       dst_toggle_qq;
    logic       dst_async_reset_n;
    logic [7:0] dst_shadow_q;

    basic_async_control_crossings_source u_source (
        .src_clk(src_clk),
        .src_rst_n(src_rst_n),
        .src_event_i(src_event_i),
        .src_data_i(src_data_i),
        .src_pulse_o(src_pulse),
        .src_toggle_o(src_toggle),
        .src_bus_o(src_bus)
    );

    basic_async_control_crossings_aux u_aux (
        .aux_clk(aux_clk),
        .aux_rst_n(aux_rst_n),
        .aux_debug_i(aux_debug_i),
        .src_toggle_i(src_toggle),
        .aux_flag_o(aux_flag),
        .aux_seen_o(aux_seen_o)
    );

    // CDC_MINIMAL_001: src-domain reset is combined into dst-domain async reset
    // release without a destination-clock reset synchronizer.
    assign dst_async_reset_n = dst_rst_n & src_rst_n;

    always_ff @(posedge dst_clk or negedge dst_async_reset_n) begin
        if (!dst_async_reset_n) begin
            dst_toggle_q  <= 1'b0;
            dst_toggle_qq <= 1'b0;
            dst_shadow_q  <= 8'd0;
            dst_data_o    <= 8'd0;
            dst_irq_o     <= 1'b0;
        end else begin
            // CDC_MINIMAL_002: one-cycle src_clk pulse is sampled directly in dst_clk.
            if (src_pulse) begin
                dst_shadow_q <= src_bus;
            end

            // CDC_MINIMAL_003: multi-bit src_bus is captured without a bundled-data
            // handshake or hold guarantee.
            dst_data_o <= src_bus ^ dst_shadow_q;

            dst_toggle_q  <= src_toggle;
            dst_toggle_qq <= dst_toggle_q;

            // CDC_MINIMAL_004: current async toggle value reconverges with a sampled
            // copy; aux_flag is another unrelated clock-domain qualifier.
            dst_irq_o <= (src_toggle ^ dst_toggle_qq) | aux_flag;
        end
    end
endmodule

module basic_async_control_crossings_source (
    input  logic       src_clk,
    input  logic       src_rst_n,
    input  logic       src_event_i,
    input  logic [7:0] src_data_i,
    output logic       src_pulse_o,
    output logic       src_toggle_o,
    output logic [7:0] src_bus_o
);
    always_ff @(posedge src_clk or negedge src_rst_n) begin
        if (!src_rst_n) begin
            src_pulse_o  <= 1'b0;
            src_toggle_o <= 1'b0;
            src_bus_o    <= 8'd0;
        end else begin
            src_pulse_o <= src_event_i;
            if (src_event_i) begin
                src_toggle_o <= ~src_toggle_o;
                src_bus_o    <= src_data_i + 8'h3d;
            end else begin
                src_bus_o <= src_bus_o + 8'd1;
            end
        end
    end
endmodule

module basic_async_control_crossings_aux (
    input  logic aux_clk,
    input  logic aux_rst_n,
    input  logic aux_debug_i,
    input  logic src_toggle_i,
    output logic aux_flag_o,
    output logic aux_seen_o
);
    always_ff @(posedge aux_clk or negedge aux_rst_n) begin
        if (!aux_rst_n) begin
            aux_flag_o <= 1'b0;
            aux_seen_o <= 1'b0;
        end else begin
            // CDC_MINIMAL_005: source toggle is sampled by aux_clk with no synchronizer.
            aux_seen_o <= src_toggle_i;
            aux_flag_o <= aux_debug_i ^ src_toggle_i;
        end
    end
endmodule
