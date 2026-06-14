// SPDX-License-Identifier: MIT
//
// PWM duty update CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module pwm_duty_update_top (
    input  logic        cfg_clk,
    input  logic        pwm_clk,
    input  logic        aon_clk,
    input  logic        cfg_rst_n,
    input  logic        pwm_rst_n,
    input  logic        aon_rst_n,
    input  logic        commit_i,
    input  logic [31:0] duty_cycle_i,
    input  logic [3:0]  period_mode_i,
    input  logic        aon_sample_i,
    output logic [31:0] pwm_status_o,
    output logic        pwm_event_o,
    output logic [31:0] aon_snapshot_o
);
    logic [31:0] duty_cycle_q;
    logic [3:0]  period_mode_q;
    logic        commit_pulse_q;
    logic        commit_toggle_q;
    logic        commit_seen_q;
    logic [3:0]  period_mode_meta_q;
    logic [3:0]  period_mode_sync_q;
    logic        cfg_reset_seen_q;
    logic [31:0] pwm_shadow_q;
    logic [31:0] aon_snapshot_q;

    always_ff @(posedge cfg_clk or negedge cfg_rst_n) begin
        if (!cfg_rst_n) begin
            duty_cycle_q <= 32'd0;
            period_mode_q <= 4'd0;
            commit_pulse_q <= 1'b0;
            commit_toggle_q <= 1'b0;
        end else begin
            duty_cycle_q <= duty_cycle_i + {24'd0, period_mode_i, 4'd3};
            period_mode_q <= period_mode_i;
            commit_pulse_q <= commit_i;
            if (commit_i) begin
                commit_toggle_q <= ~commit_toggle_q;
            end
        end
    end

    always_ff @(posedge pwm_clk or negedge pwm_rst_n) begin
        if (!pwm_rst_n) begin
            pwm_status_o <= 32'd0;
            pwm_event_o <= 1'b0;
            commit_seen_q <= 1'b0;
            period_mode_meta_q <= 4'd0;
            period_mode_sync_q <= 4'd0;
            cfg_reset_seen_q <= 1'b0;
            pwm_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_PWM_DUTY_UPDATE_001: multi-bit source payload is sampled without a coherency protocol.
            pwm_status_o <= duty_cycle_q;

            // CDC_CDC_PWM_DUTY_UPDATE_002: one-cycle source pulse is consumed directly by the destination.
            if (commit_pulse_q) begin
                pwm_shadow_q <= duty_cycle_q;
            end

            commit_seen_q <= commit_toggle_q;
            // CDC_CDC_PWM_DUTY_UPDATE_003: raw toggle reconverges with a one-sample destination history.
            pwm_event_o <= commit_toggle_q ^ commit_seen_q;

            period_mode_meta_q <= period_mode_q;
            // CDC_CDC_PWM_DUTY_UPDATE_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            period_mode_sync_q <= period_mode_meta_q;

            if (period_mode_sync_q == 4'hA) begin
                pwm_status_o[7:0] <= pwm_shadow_q[7:0] ^ duty_cycle_q[7:0];
            end

            // CDC_CDC_PWM_DUTY_UPDATE_005: source reset is used as destination-domain data.
            if (!cfg_rst_n) begin
                cfg_reset_seen_q <= 1'b0;
            end else begin
                cfg_reset_seen_q <= cfg_reset_seen_q | commit_seen_q;
            end
        end
    end

    always_ff @(posedge aon_clk or negedge aon_rst_n) begin
        if (!aon_rst_n) begin
            aon_snapshot_q <= 32'd0;
            aon_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_PWM_DUTY_UPDATE_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            aon_snapshot_q <= duty_cycle_q ^ pwm_status_o;
            if (aon_sample_i) begin
                aon_snapshot_o <= aon_snapshot_q;
            end
        end
    end
endmodule
