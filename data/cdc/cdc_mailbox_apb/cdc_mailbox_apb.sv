// SPDX-License-Identifier: MIT
//
// Mailbox APB bridge CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module cdc_mailbox_apb_top (
    input  logic        apb_clk,
    input  logic        mailbox_clk,
    input  logic        irq_clk,
    input  logic        apb_rst_n,
    input  logic        mailbox_rst_n,
    input  logic        irq_rst_n,
    input  logic        write_i,
    input  logic [31:0] mail_payload_i,
    input  logic [3:0]  mailbox_mode_i,
    input  logic        irq_sample_i,
    output logic [31:0] mailbox_status_o,
    output logic        mailbox_event_o,
    output logic [31:0] irq_snapshot_o
);
    logic [31:0] mail_payload_q;
    logic [3:0]  mailbox_mode_q;
    logic        write_pulse_q;
    logic        write_toggle_q;
    logic        write_seen_q;
    logic [3:0]  mailbox_mode_meta_q;
    logic [3:0]  mailbox_mode_sync_q;
    logic        apb_reset_seen_q;
    logic [31:0] mailbox_shadow_q;
    logic [31:0] irq_snapshot_q;

    always_ff @(posedge apb_clk or negedge apb_rst_n) begin
        if (!apb_rst_n) begin
            mail_payload_q <= 32'd0;
            mailbox_mode_q <= 4'd0;
            write_pulse_q <= 1'b0;
            write_toggle_q <= 1'b0;
        end else begin
            mail_payload_q <= mail_payload_i + {24'd0, mailbox_mode_i, 4'd3};
            mailbox_mode_q <= mailbox_mode_i;
            write_pulse_q <= write_i;
            if (write_i) begin
                write_toggle_q <= ~write_toggle_q;
            end
        end
    end

    always_ff @(posedge mailbox_clk or negedge mailbox_rst_n) begin
        if (!mailbox_rst_n) begin
            mailbox_status_o <= 32'd0;
            mailbox_event_o <= 1'b0;
            write_seen_q <= 1'b0;
            mailbox_mode_meta_q <= 4'd0;
            mailbox_mode_sync_q <= 4'd0;
            apb_reset_seen_q <= 1'b0;
            mailbox_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_MAILBOX_APB_001: multi-bit source payload is sampled without a coherency protocol.
            mailbox_status_o <= mail_payload_q;

            // CDC_CDC_MAILBOX_APB_002: one-cycle source pulse is consumed directly by the destination.
            if (write_pulse_q) begin
                mailbox_shadow_q <= mail_payload_q;
            end

            write_seen_q <= write_toggle_q;
            // CDC_CDC_MAILBOX_APB_003: raw toggle reconverges with a one-sample destination history.
            mailbox_event_o <= write_toggle_q ^ write_seen_q;

            mailbox_mode_meta_q <= mailbox_mode_q;
            // CDC_CDC_MAILBOX_APB_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            mailbox_mode_sync_q <= mailbox_mode_meta_q;

            if (mailbox_mode_sync_q == 4'hA) begin
                mailbox_status_o[7:0] <= mailbox_shadow_q[7:0] ^ mail_payload_q[7:0];
            end

            // CDC_CDC_MAILBOX_APB_005: source reset is used as destination-domain data.
            if (!apb_rst_n) begin
                apb_reset_seen_q <= 1'b0;
            end else begin
                apb_reset_seen_q <= apb_reset_seen_q | write_seen_q;
            end
        end
    end

    always_ff @(posedge irq_clk or negedge irq_rst_n) begin
        if (!irq_rst_n) begin
            irq_snapshot_q <= 32'd0;
            irq_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_MAILBOX_APB_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            irq_snapshot_q <= mail_payload_q ^ mailbox_status_o;
            if (irq_sample_i) begin
                irq_snapshot_o <= irq_snapshot_q;
            end
        end
    end
endmodule
