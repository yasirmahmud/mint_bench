// SPDX-License-Identifier: MIT
//
// ADC sample frontend CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module cdc_adc_sample_fifo_top (
    input  logic        adc_clk,
    input  logic        dsp_clk,
    input  logic        cfg_clk,
    input  logic        adc_rst_n,
    input  logic        dsp_rst_n,
    input  logic        cfg_rst_n,
    input  logic        sample_ready_i,
    input  logic [31:0] adc_sample_i,
    input  logic [3:0]  range_mode_i,
    input  logic        cfg_sample_i,
    output logic [31:0] dsp_status_o,
    output logic        dsp_event_o,
    output logic [31:0] cfg_snapshot_o
);
    logic [31:0] adc_sample_q;
    logic [3:0]  range_mode_q;
    logic        sample_ready_pulse_q;
    logic        sample_ready_toggle_q;
    logic        sample_ready_seen_q;
    logic [3:0]  range_mode_meta_q;
    logic [3:0]  range_mode_sync_q;
    logic        adc_reset_seen_q;
    logic [31:0] dsp_shadow_q;
    logic [31:0] cfg_snapshot_q;

    always_ff @(posedge adc_clk or negedge adc_rst_n) begin
        if (!adc_rst_n) begin
            adc_sample_q <= 32'd0;
            range_mode_q <= 4'd0;
            sample_ready_pulse_q <= 1'b0;
            sample_ready_toggle_q <= 1'b0;
        end else begin
            adc_sample_q <= adc_sample_i + {24'd0, range_mode_i, 4'd3};
            range_mode_q <= range_mode_i;
            sample_ready_pulse_q <= sample_ready_i;
            if (sample_ready_i) begin
                sample_ready_toggle_q <= ~sample_ready_toggle_q;
            end
        end
    end

    always_ff @(posedge dsp_clk or negedge dsp_rst_n) begin
        if (!dsp_rst_n) begin
            dsp_status_o <= 32'd0;
            dsp_event_o <= 1'b0;
            sample_ready_seen_q <= 1'b0;
            range_mode_meta_q <= 4'd0;
            range_mode_sync_q <= 4'd0;
            adc_reset_seen_q <= 1'b0;
            dsp_shadow_q <= 32'd0;
        end else begin
            // CDC_CDC_ADC_SAMPLE_FIFO_001: multi-bit source payload is sampled without a coherency protocol.
            dsp_status_o <= adc_sample_q;

            // CDC_CDC_ADC_SAMPLE_FIFO_002: one-cycle source pulse is consumed directly by the destination.
            if (sample_ready_pulse_q) begin
                dsp_shadow_q <= adc_sample_q;
            end

            sample_ready_seen_q <= sample_ready_toggle_q;
            // CDC_CDC_ADC_SAMPLE_FIFO_003: raw toggle reconverges with a one-sample destination history.
            dsp_event_o <= sample_ready_toggle_q ^ sample_ready_seen_q;

            range_mode_meta_q <= range_mode_q;
            // CDC_CDC_ADC_SAMPLE_FIFO_004: encoded control bits are synchronized independently and decoded as an atomic mode.
            range_mode_sync_q <= range_mode_meta_q;

            if (range_mode_sync_q == 4'hA) begin
                dsp_status_o[7:0] <= dsp_shadow_q[7:0] ^ adc_sample_q[7:0];
            end

            // CDC_CDC_ADC_SAMPLE_FIFO_005: source reset is used as destination-domain data.
            if (!adc_rst_n) begin
                adc_reset_seen_q <= 1'b0;
            end else begin
                adc_reset_seen_q <= adc_reset_seen_q | sample_ready_seen_q;
            end
        end
    end

    always_ff @(posedge cfg_clk or negedge cfg_rst_n) begin
        if (!cfg_rst_n) begin
            cfg_snapshot_q <= 32'd0;
            cfg_snapshot_o <= 32'd0;
        end else begin
            // CDC_CDC_ADC_SAMPLE_FIFO_006: auxiliary snapshot combines source and destination values without a snapshot handshake.
            cfg_snapshot_q <= adc_sample_q ^ dsp_status_o;
            if (cfg_sample_i) begin
                cfg_snapshot_o <= cfg_snapshot_q;
            end
        end
    end
endmodule
