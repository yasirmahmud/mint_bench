// SPDX-License-Identifier: MIT
//
// Secure mailbox bridge CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module secure_mailbox_top (
    input  logic        secure_clk,
    input  logic        normal_clk,
    input  logic        audit_clk,
    input  logic        secure_rst_n,
    input  logic        normal_rst_n,
    input  logic        audit_rst_n,
    input  logic        doorbell_i,
    input  logic [31:0] secure_msg_i,
    input  logic [3:0]  access_mode_i,
    input  logic        audit_sample_i,
    output logic [31:0] normal_status_o,
    output logic        normal_event_o,
    output logic [31:0] audit_snapshot_o
);
    logic [31:0] secure_msg_q;
    logic [3:0]  access_mode_q;
    logic        doorbell_pulse_q;
    logic        doorbell_toggle_q;
    logic        doorbell_seen_q;
    logic [3:0]  access_mode_meta_q;
    logic [3:0]  access_mode_sync_q;
    logic        secure_reset_seen_q;
    logic [31:0] normal_shadow_q;
    logic [31:0] audit_snapshot_q;

    always_ff @(posedge secure_clk or negedge secure_rst_n) begin
        if (!secure_rst_n) begin
            secure_msg_q <= 32'd0;
            access_mode_q <= 4'd0;
            doorbell_pulse_q <= 1'b0;
            doorbell_toggle_q <= 1'b0;
        end else begin
            secure_msg_q <= secure_msg_i + {24'd0, access_mode_i, 4'd3};
            access_mode_q <= access_mode_i;
            doorbell_pulse_q <= doorbell_i;
            if (doorbell_i) begin
                doorbell_toggle_q <= ~doorbell_toggle_q;
            end
        end
    end

    always_ff @(posedge normal_clk or negedge normal_rst_n) begin
        if (!normal_rst_n) begin
            normal_status_o <= 32'd0;
            normal_event_o <= 1'b0;
            doorbell_seen_q <= 1'b0;
            access_mode_meta_q <= 4'd0;
            access_mode_sync_q <= 4'd0;
            secure_reset_seen_q <= 1'b0;
            normal_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_SECURE_MAILBOX_001: multi-bit source payload is sampled without a coherency protocol.
            normal_status_o <= secure_msg_q;

            // CDC_CDC_SECURE_MAILBOX_002: one-cycle source pulse is consumed directly by the destination.
            if (doorbell_pulse_q) begin
                normal_shadow_q <= secure_msg_q;
            end

            doorbell_seen_q <= doorbell_toggle_q;
            // CDC_CDC_SECURE_MAILBOX_003: raw toggle reconverges with a one-sample destination history.
            normal_event_o <= doorbell_toggle_q ^ doorbell_seen_q;

            access_mode_meta_q <= access_mode_q;
            // CDC_CDC_SECURE_MAILBOX_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            access_mode_sync_q <= access_mode_meta_q;

            if (access_mode_sync_q == 4'hA) begin
                normal_status_o[7:0] <= normal_shadow_q[7:0] ^ secure_msg_q[7:0];
            end

            // CDC_CDC_SECURE_MAILBOX_005: source reset is used as destination-domain data.
            if (!secure_rst_n) begin
                secure_reset_seen_q <= 1'b0;
            end else begin
                secure_reset_seen_q <= secure_reset_seen_q | doorbell_seen_q;
            end
        end
    end

    always_ff @(posedge audit_clk or negedge audit_rst_n) begin
        if (!audit_rst_n) begin
            audit_snapshot_q <= 32'd0;
            audit_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_SECURE_MAILBOX_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            audit_snapshot_q <= secure_msg_q ^ normal_status_o;
            if (audit_sample_i) begin
                audit_snapshot_o <= audit_snapshot_q;
            end
        end
    end
endmodule
