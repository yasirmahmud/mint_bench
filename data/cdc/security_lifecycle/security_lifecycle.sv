// SPDX-License-Identifier: MIT
//
// Security lifecycle bridge CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module security_lifecycle_top (
    input  logic        lc_clk,
    input  logic        core_clk,
    input  logic        otp_clk,
    input  logic        lc_rst_n,
    input  logic        core_rst_n,
    input  logic        otp_rst_n,
    input  logic        escalate_i,
    input  logic [31:0] lifecycle_state_i,
    input  logic [3:0]  policy_i,
    input  logic        otp_sample_i,
    output logic [31:0] core_status_o,
    output logic        core_event_o,
    output logic [31:0] otp_snapshot_o
);
    logic [31:0] lifecycle_state_q;
    logic [3:0]  policy_q;
    logic        escalate_pulse_q;
    logic        escalate_toggle_q;
    logic        escalate_seen_q;
    logic [3:0]  policy_meta_q;
    logic [3:0]  policy_sync_q;
    logic        lc_reset_seen_q;
    logic [31:0] core_shadow_q;
    logic [31:0] otp_snapshot_q;

    always_ff @(posedge lc_clk or negedge lc_rst_n) begin
        if (!lc_rst_n) begin
            lifecycle_state_q <= 32'd0;
            policy_q <= 4'd0;
            escalate_pulse_q <= 1'b0;
            escalate_toggle_q <= 1'b0;
        end else begin
            lifecycle_state_q <= lifecycle_state_i + {24'd0, policy_i, 4'd3};
            policy_q <= policy_i;
            escalate_pulse_q <= escalate_i;
            if (escalate_i) begin
                escalate_toggle_q <= ~escalate_toggle_q;
            end
        end
    end

    always_ff @(posedge core_clk or negedge core_rst_n) begin
        if (!core_rst_n) begin
            core_status_o <= 32'd0;
            core_event_o <= 1'b0;
            escalate_seen_q <= 1'b0;
            policy_meta_q <= 4'd0;
            policy_sync_q <= 4'd0;
            lc_reset_seen_q <= 1'b0;
            core_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_SECURITY_LIFECYCLE_001: multi-bit source payload is sampled without a coherency protocol.
            core_status_o <= lifecycle_state_q;

            // CDC_CDC_SECURITY_LIFECYCLE_002: one-cycle source pulse is consumed directly by the destination.
            if (escalate_pulse_q) begin
                core_shadow_q <= lifecycle_state_q;
            end

            escalate_seen_q <= escalate_toggle_q;
            // CDC_CDC_SECURITY_LIFECYCLE_003: raw toggle reconverges with a one-sample destination history.
            core_event_o <= escalate_toggle_q ^ escalate_seen_q;

            policy_meta_q <= policy_q;
            // CDC_CDC_SECURITY_LIFECYCLE_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            policy_sync_q <= policy_meta_q;

            if (policy_sync_q == 4'hA) begin
                core_status_o[7:0] <= core_shadow_q[7:0] ^ lifecycle_state_q[7:0];
            end

            // CDC_CDC_SECURITY_LIFECYCLE_005: source reset is used as destination-domain data.
            if (!lc_rst_n) begin
                lc_reset_seen_q <= 1'b0;
            end else begin
                lc_reset_seen_q <= lc_reset_seen_q | escalate_seen_q;
            end
        end
    end

    always_ff @(posedge otp_clk or negedge otp_rst_n) begin
        if (!otp_rst_n) begin
            otp_snapshot_q <= 32'd0;
            otp_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_SECURITY_LIFECYCLE_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            otp_snapshot_q <= lifecycle_state_q ^ core_status_o;
            if (otp_sample_i) begin
                otp_snapshot_o <= otp_snapshot_q;
            end
        end
    end
endmodule
