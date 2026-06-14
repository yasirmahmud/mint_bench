// SPDX-License-Identifier: MIT
//
// multi_protocol_cdc_hazards.sv
//
// A compact multi-module SystemVerilog benchmark containing CDC defects that
// often require semantic or protocol reasoning beyond simple structural checks.
// Each intentional issue is tagged with CDC_### and is described in
// multi_protocol_cdc_hazards_errors.json.

`timescale 1ns/1ps

module multi_protocol_cdc_hazards_top (
    input  logic        cfg_clk,
    input  logic        axi_clk,
    input  logic        sensor_clk,
    input  logic        dsp_clk,
    input  logic        mem_clk,
    input  logic        debug_clk,
    input  logic        scan_clk,
    input  logic        cfg_rst_n,
    input  logic        axi_rst_n,
    input  logic        sensor_rst_n,
    input  logic        dsp_rst_n,
    input  logic        mem_rst_n,
    input  logic        debug_rst_n,
    input  logic        scan_enable,
    input  logic        test_mode,
    input  logic        cfg_write,
    input  logic        cfg_read,
    input  logic [31:0] cfg_wdata,
    input  logic [15:0] cfg_addr,
    output logic        irq_o,
    output logic [31:0] debug_status_o
);
    logic        sensor_event_pulse;
    logic        sensor_event_toggle;
    logic        sensor_valid;
    logic [7:0]  sensor_status;
    logic [2:0]  sensor_mode;
    logic [11:0] sensor_threshold_shadow;
    logic [15:0] sensor_crc;
    logic [31:0] sensor_timestamp;
    logic [31:0] sensor_payload;
    logic [4:0]  sensor_gray_count;

    logic        cfg_cmd_pulse;
    logic        cfg_irq_enable;
    logic        cfg_reset_req;
    logic [2:0]  cfg_mode_shadow;
    logic [11:0] cfg_threshold;
    logic [31:0] cfg_descriptor;
    logic [31:0] cfg_status_word;

    logic        axi_desc_valid;
    logic        axi_mem_kick;
    logic [31:0] axi_descriptor;
    logic [31:0] axi_status_word;
    logic        mem_done_toggle;
    logic [4:0]  mem_read_ptr_bin;
    logic [4:0]  mem_write_ptr_bin;
    logic [31:0] dsp_sample;
    logic        dsp_event_level;
    logic        dsp_irq_req;
    logic        debug_trigger;
    logic        debug_clear_cfg;
    logic        cdc_reset_n;

    multi_protocol_cdc_hazards_sensor_frontend u_sensor_frontend (
        .sensor_clk(sensor_clk),
        .sensor_rst_n(sensor_rst_n),
        .test_mode_i(test_mode),
        .cfg_threshold_i(cfg_threshold),
        .event_pulse_o(sensor_event_pulse),
        .event_toggle_o(sensor_event_toggle),
        .valid_o(sensor_valid),
        .status_o(sensor_status),
        .mode_o(sensor_mode),
        .threshold_shadow_o(sensor_threshold_shadow),
        .crc_o(sensor_crc),
        .timestamp_o(sensor_timestamp),
        .payload_o(sensor_payload),
        .gray_count_o(sensor_gray_count)
    );

    multi_protocol_cdc_hazards_ctrl_domain u_ctrl_domain (
        .cfg_clk(cfg_clk),
        .scan_clk(scan_clk),
        .cfg_rst_n(cfg_rst_n),
        .sensor_rst_n_i(sensor_rst_n),
        .debug_trigger_i(debug_trigger),
        .scan_enable_i(scan_enable),
        .cfg_write_i(cfg_write),
        .cfg_read_i(cfg_read),
        .cfg_wdata_i(cfg_wdata),
        .cfg_addr_i(cfg_addr),
        .sensor_event_pulse_i(sensor_event_pulse),
        .sensor_event_toggle_i(sensor_event_toggle),
        .sensor_valid_i(sensor_valid),
        .sensor_status_i(sensor_status),
        .sensor_mode_i(sensor_mode),
        .sensor_threshold_shadow_i(sensor_threshold_shadow),
        .sensor_crc_i(sensor_crc),
        .sensor_timestamp_i(sensor_timestamp),
        .sensor_payload_i(sensor_payload),
        .sensor_gray_count_i(sensor_gray_count),
        .cfg_cmd_pulse_o(cfg_cmd_pulse),
        .cfg_irq_enable_o(cfg_irq_enable),
        .cfg_reset_req_o(cfg_reset_req),
        .cfg_mode_shadow_o(cfg_mode_shadow),
        .cfg_threshold_o(cfg_threshold),
        .cfg_descriptor_o(cfg_descriptor),
        .cfg_status_word_o(cfg_status_word),
        .debug_clear_o(debug_clear_cfg)
    );

    multi_protocol_cdc_hazards_axi_bridge u_axi_bridge (
        .axi_clk(axi_clk),
        .axi_rst_n(axi_rst_n),
        .cfg_rst_n_i(cfg_rst_n),
        .cfg_cmd_pulse_i(cfg_cmd_pulse),
        .cfg_irq_enable_i(cfg_irq_enable),
        .cfg_reset_req_i(cfg_reset_req),
        .cfg_mode_shadow_i(cfg_mode_shadow),
        .cfg_descriptor_i(cfg_descriptor),
        .cfg_addr_i(cfg_addr),
        .cfg_wdata_i(cfg_wdata),
        .dsp_irq_req_i(dsp_irq_req),
        .mem_done_toggle_i(mem_done_toggle),
        .mem_read_ptr_bin_i(mem_read_ptr_bin),
        .axi_desc_valid_o(axi_desc_valid),
        .axi_descriptor_o(axi_descriptor),
        .axi_mem_kick_o(axi_mem_kick),
        .axi_status_word_o(axi_status_word),
        .irq_o(irq_o)
    );

    multi_protocol_cdc_hazards_dsp_block u_dsp_block (
        .dsp_clk(dsp_clk),
        .dsp_rst_n(dsp_rst_n),
        .sensor_event_toggle_i(sensor_event_toggle),
        .sensor_valid_i(sensor_valid),
        .sensor_payload_i(sensor_payload),
        .sensor_status_i(sensor_status),
        .sensor_gray_count_i(sensor_gray_count),
        .cfg_mode_shadow_i(cfg_mode_shadow),
        .cfg_threshold_i(cfg_threshold),
        .debug_clear_cfg_i(debug_clear_cfg),
        .dsp_sample_o(dsp_sample),
        .dsp_event_level_o(dsp_event_level),
        .dsp_irq_req_o(dsp_irq_req)
    );

    multi_protocol_cdc_hazards_mem_writer u_mem_writer (
        .mem_clk(mem_clk),
        .mem_rst_n(mem_rst_n),
        .axi_rst_n_i(axi_rst_n),
        .axi_desc_valid_i(axi_desc_valid),
        .axi_mem_kick_i(axi_mem_kick),
        .axi_descriptor_i(axi_descriptor),
        .axi_status_word_i(axi_status_word),
        .mem_done_toggle_o(mem_done_toggle),
        .mem_read_ptr_bin_o(mem_read_ptr_bin),
        .mem_write_ptr_bin_o(mem_write_ptr_bin)
    );

    multi_protocol_cdc_hazards_debug_tap u_debug_tap (
        .debug_clk(debug_clk),
        .debug_rst_n(debug_rst_n),
        .cfg_clk(cfg_clk),
        .cfg_status_word_i(cfg_status_word),
        .axi_status_word_i(axi_status_word),
        .dsp_sample_i(dsp_sample),
        .dsp_event_level_i(dsp_event_level),
        .mem_write_ptr_bin_i(mem_write_ptr_bin),
        .debug_status_o(debug_status_o),
        .debug_trigger_o(debug_trigger)
    );

    multi_protocol_cdc_hazards_reset_manager u_reset_manager (
        .cfg_clk(cfg_clk),
        .axi_clk(axi_clk),
        .mem_clk(mem_clk),
        .cfg_rst_n(cfg_rst_n),
        .axi_rst_n(axi_rst_n),
        .mem_rst_n(mem_rst_n),
        .cfg_reset_req_i(cfg_reset_req),
        .mem_done_toggle_i(mem_done_toggle),
        .cdc_reset_n_o(cdc_reset_n)
    );

endmodule

module multi_protocol_cdc_hazards_sensor_frontend (
    input  logic        sensor_clk,
    input  logic        sensor_rst_n,
    input  logic        test_mode_i,
    input  logic [11:0] cfg_threshold_i,
    output logic        event_pulse_o,
    output logic        event_toggle_o,
    output logic        valid_o,
    output logic [7:0]  status_o,
    output logic [2:0]  mode_o,
    output logic [11:0] threshold_shadow_o,
    output logic [15:0] crc_o,
    output logic [31:0] timestamp_o,
    output logic [31:0] payload_o,
    output logic [4:0]  gray_count_o
);
    logic [31:0] lfsr_q;
    logic [4:0]  count_q;
    logic        event_raw;

    assign event_raw = (lfsr_q[7:0] == status_o) || test_mode_i;

    always_ff @(posedge sensor_clk or negedge sensor_rst_n) begin
        if (!sensor_rst_n) begin
            lfsr_q             <= 32'h1;
            count_q            <= 5'd0;
            event_pulse_o      <= 1'b0;
            event_toggle_o     <= 1'b0;
            valid_o            <= 1'b0;
            status_o           <= 8'h11;
            mode_o             <= 3'd0;
            threshold_shadow_o <= 12'd0;
            crc_o              <= 16'h1ace;
            timestamp_o        <= 32'd0;
            payload_o          <= 32'd0;
            gray_count_o       <= 5'd0;
        end else begin
            lfsr_q             <= {lfsr_q[30:0], lfsr_q[31] ^ lfsr_q[21] ^ lfsr_q[1] ^ lfsr_q[0]};
            count_q            <= count_q + {4'd0, event_raw} + {4'd0, test_mode_i};
            event_pulse_o      <= event_raw;
            event_toggle_o     <= event_toggle_o ^ event_raw;
            valid_o            <= lfsr_q[3] ^ lfsr_q[9];
            status_o           <= status_o + {7'd0, event_raw};
            mode_o             <= lfsr_q[18:16];
            threshold_shadow_o <= cfg_threshold_i;
            crc_o              <= crc_o ^ lfsr_q[15:0] ^ {4'd0, cfg_threshold_i};
            timestamp_o        <= timestamp_o + 32'd1;
            payload_o          <= {timestamp_o[15:0], lfsr_q[15:0]};
            gray_count_o       <= count_q ^ (count_q >> 1);
        end
    end
endmodule

module multi_protocol_cdc_hazards_ctrl_domain (
    input  logic        cfg_clk,
    input  logic        scan_clk,
    input  logic        cfg_rst_n,
    input  logic        sensor_rst_n_i,
    input  logic        debug_trigger_i,
    input  logic        scan_enable_i,
    input  logic        cfg_write_i,
    input  logic        cfg_read_i,
    input  logic [31:0] cfg_wdata_i,
    input  logic [15:0] cfg_addr_i,
    input  logic        sensor_event_pulse_i,
    input  logic        sensor_event_toggle_i,
    input  logic        sensor_valid_i,
    input  logic [7:0]  sensor_status_i,
    input  logic [2:0]  sensor_mode_i,
    input  logic [11:0] sensor_threshold_shadow_i,
    input  logic [15:0] sensor_crc_i,
    input  logic [31:0] sensor_timestamp_i,
    input  logic [31:0] sensor_payload_i,
    input  logic [4:0]  sensor_gray_count_i,
    output logic        cfg_cmd_pulse_o,
    output logic        cfg_irq_enable_o,
    output logic        cfg_reset_req_o,
    output logic [2:0]  cfg_mode_shadow_o,
    output logic [11:0] cfg_threshold_o,
    output logic [31:0] cfg_descriptor_o,
    output logic [31:0] cfg_status_word_o,
    output logic        debug_clear_o
);
    logic        gated_cfg_clk;
    logic        event_toggle_d;
    logic        pulse_sticky_q;
    logic [7:0]  status_q;
    logic [2:0]  mode_meta_q;
    logic [2:0]  mode_sync_q;
    logic [11:0] threshold_q;
    logic [15:0] timestamp_low_q;
    logic [31:0] payload_q;
    logic [4:0]  gray_meta_q;
    logic [4:0]  gray_sync_q;
    logic [4:0]  gray_prev_q;
    logic [31:0] debug_count_q;
    logic        debug_trigger_meta_q;

    // CDC_012: scan_enable_i selects a foreign clock for cfg state without a safe clock-mux cell.
    assign gated_cfg_clk = scan_enable_i ? scan_clk : cfg_clk;

    always_ff @(posedge cfg_clk or negedge cfg_rst_n) begin
        if (!cfg_rst_n) begin
            cfg_threshold_o <= 12'h120;
        end else if (cfg_write_i && (cfg_addr_i == 16'h0010)) begin
            cfg_threshold_o <= cfg_wdata_i[11:0];
        end
    end

    always_ff @(posedge cfg_clk or negedge cfg_rst_n) begin
        if (!cfg_rst_n) begin
            status_q              <= 8'd0;
            event_toggle_d        <= 1'b0;
            pulse_sticky_q        <= 1'b0;
            mode_meta_q           <= 3'd0;
            mode_sync_q           <= 3'd0;
            threshold_q           <= 12'd0;
            timestamp_low_q       <= 16'd0;
            payload_q             <= 32'd0;
            gray_meta_q           <= 5'd0;
            gray_sync_q           <= 5'd0;
            gray_prev_q           <= 5'd0;
            cfg_mode_shadow_o     <= 3'd0;
            cfg_descriptor_o      <= 32'd0;
            cfg_status_word_o     <= 32'd0;
            cfg_cmd_pulse_o       <= 1'b0;
            cfg_irq_enable_o      <= 1'b0;
            cfg_reset_req_o       <= 1'b0;
            debug_clear_o         <= 1'b0;
            debug_trigger_meta_q  <= 1'b0;
        end else begin
            cfg_cmd_pulse_o  <= cfg_write_i && (cfg_addr_i == 16'h0020);
            cfg_irq_enable_o <= cfg_write_i && cfg_wdata_i[0];
            cfg_reset_req_o  <= cfg_write_i && (cfg_addr_i == 16'h00f0);

            // CDC_001: Per-bit synchronized status bus is consumed as one coherent sensor-domain word.
            status_q <= sensor_status_i;

            // CDC_002: One-cycle sensor pulse is sampled by cfg_clk without a pulse stretcher or toggle handshake.
            pulse_sticky_q <= pulse_sticky_q | sensor_event_pulse_i;

            // CDC_003: Toggle edge detector uses only one destination sample before reconvergence with current async value.
            event_toggle_d <= sensor_event_toggle_i;

            // CDC_004: Synced-looking valid controls an unsynchronized payload bundle.
            if (sensor_valid_i) begin
                payload_q <= sensor_payload_i;
            end

            // CDC_005: Timestamp halves are captured in different cfg cycles, making impossible time values.
            timestamp_low_q <= sensor_timestamp_i[15:0];
            cfg_descriptor_o <= {sensor_timestamp_i[31:16], timestamp_low_q};

            // CDC_006: Async CRC bits feed a cfg-domain qualifier through combinational reduction logic.
            if (^sensor_crc_i) begin
                cfg_status_word_o[15:0] <= sensor_crc_i;
            end

            // CDC_007: A reset generated in the sensor domain is treated as a cfg-domain synchronous status event.
            if (!sensor_rst_n_i) begin
                cfg_status_word_o[16] <= 1'b1;
            end

            mode_meta_q <= sensor_mode_i;
            mode_sync_q <= mode_meta_q;
            // CDC_008: Independently synchronized mode bits reconverge as an encoded control value.
            cfg_mode_shadow_o <= mode_sync_q;

            // CDC_009: Sensor threshold mirror is copied into cfg logic without an ownership or acknowledge protocol.
            threshold_q <= sensor_threshold_shadow_i;

            gray_meta_q <= sensor_gray_count_i;
            gray_sync_q <= gray_meta_q;
            // CDC_010: Gray count comparison assumes the producer increments by one, but test_mode can skip states.
            if ((gray_sync_q ^ gray_prev_q) > 5'b00001) begin
                cfg_status_word_o[17] <= 1'b1;
            end
            gray_prev_q <= gray_sync_q;

            debug_trigger_meta_q <= debug_trigger_i;
            // CDC_011: Debug trigger crossing is used after a single sample and can double-clear cfg state.
            debug_clear_o <= debug_trigger_i & ~debug_trigger_meta_q;

            cfg_status_word_o[31:24] <= status_q;
            cfg_status_word_o[23:20] <= {event_toggle_d, pulse_sticky_q, threshold_q[1:0]};
            cfg_status_word_o[19:18] <= debug_count_q[1:0];
        end
    end

    always_ff @(posedge gated_cfg_clk or negedge cfg_rst_n) begin
        if (!cfg_rst_n) begin
            debug_count_q <= 32'd0;
        end else if (cfg_read_i) begin
            debug_count_q <= debug_count_q + 32'd1;
        end
    end

endmodule

module multi_protocol_cdc_hazards_axi_bridge (
    input  logic        axi_clk,
    input  logic        axi_rst_n,
    input  logic        cfg_rst_n_i,
    input  logic        cfg_cmd_pulse_i,
    input  logic        cfg_irq_enable_i,
    input  logic        cfg_reset_req_i,
    input  logic [2:0]  cfg_mode_shadow_i,
    input  logic [31:0] cfg_descriptor_i,
    input  logic [15:0] cfg_addr_i,
    input  logic [31:0] cfg_wdata_i,
    input  logic        dsp_irq_req_i,
    input  logic        mem_done_toggle_i,
    input  logic [4:0]  mem_read_ptr_bin_i,
    output logic        axi_desc_valid_o,
    output logic [31:0] axi_descriptor_o,
    output logic        axi_mem_kick_o,
    output logic [31:0] axi_status_word_o,
    output logic        irq_o
);
    logic cmd_meta_q;
    logic cmd_sync_q;
    logic irq_enable_meta_q;
    logic irq_enable_sync_q;
    logic mem_done_d;
    logic [4:0] mem_ptr_meta_q;
    logic [4:0] mem_ptr_sync_q;
    logic [31:0] write_shadow_q;

    always_ff @(posedge axi_clk or negedge axi_rst_n) begin
        if (!axi_rst_n) begin
            cmd_meta_q         <= 1'b0;
            cmd_sync_q         <= 1'b0;
            irq_enable_meta_q  <= 1'b0;
            irq_enable_sync_q  <= 1'b0;
            mem_done_d         <= 1'b0;
            mem_ptr_meta_q     <= 5'd0;
            mem_ptr_sync_q     <= 5'd0;
            write_shadow_q     <= 32'd0;
            axi_desc_valid_o   <= 1'b0;
            axi_descriptor_o   <= 32'd0;
            axi_mem_kick_o     <= 1'b0;
            axi_status_word_o  <= 32'd0;
            irq_o              <= 1'b0;
        end else begin
            cmd_meta_q <= cfg_cmd_pulse_i;
            cmd_sync_q <= cmd_meta_q;
            // CDC_013: Source pulse is synchronized as a level, so narrow cfg commands can be missed or repeated.
            axi_desc_valid_o <= cmd_sync_q;

            // CDC_014: cfg descriptor is sampled after only the command bit crosses; no bundle stability contract exists.
            if (cmd_sync_q) begin
                axi_descriptor_o <= cfg_descriptor_i;
            end

            // CDC_015: cfg address and data are captured as a cross-domain sideband without a handshake.
            if (cmd_sync_q && (cfg_addr_i[7:0] == 8'h20)) begin
                write_shadow_q <= cfg_wdata_i;
            end

            irq_enable_meta_q <= cfg_irq_enable_i;
            irq_enable_sync_q <= irq_enable_meta_q;
            // CDC_016: Separately synchronized irq enable reconverges with an unsynchronized dsp interrupt request.
            irq_o <= irq_enable_sync_q & dsp_irq_req_i;

            // CDC_017: cfg reset request gates axi behavior after an unsynchronized single-bit crossing.
            if (cfg_reset_req_i) begin
                axi_status_word_o[0] <= 1'b0;
            end

            // CDC_018: cfg reset_n deassertion is observed directly in axi logic and can release state asynchronously.
            if (!cfg_rst_n_i) begin
                axi_status_word_o[1] <= 1'b0;
            end

            mem_done_d <= mem_done_toggle_i;
            // CDC_019: Memory-domain toggle return is edge-detected with one sample in the AXI domain.
            axi_status_word_o[2] <= mem_done_toggle_i ^ mem_done_d;

            mem_ptr_meta_q <= mem_read_ptr_bin_i;
            mem_ptr_sync_q <= mem_ptr_meta_q;
            // CDC_020: Binary memory pointer is synchronized bitwise and used arithmetically in AXI.
            axi_status_word_o[12:8] <= mem_ptr_sync_q + 5'd1;

            // CDC_021: Cross-domain mode value controls transaction routing without atomic encoding guarantees.
            axi_mem_kick_o <= cmd_sync_q & (cfg_mode_shadow_i == 3'd5);
            axi_status_word_o[31:16] <= write_shadow_q[15:0];
        end
    end
endmodule

module multi_protocol_cdc_hazards_dsp_block (
    input  logic        dsp_clk,
    input  logic        dsp_rst_n,
    input  logic        sensor_event_toggle_i,
    input  logic        sensor_valid_i,
    input  logic [31:0] sensor_payload_i,
    input  logic [7:0]  sensor_status_i,
    input  logic [4:0]  sensor_gray_count_i,
    input  logic [2:0]  cfg_mode_shadow_i,
    input  logic [11:0] cfg_threshold_i,
    input  logic        debug_clear_cfg_i,
    output logic [31:0] dsp_sample_o,
    output logic        dsp_event_level_o,
    output logic        dsp_irq_req_o
);
    logic event_meta_q;
    logic event_sync_q;
    logic event_prev_q;
    logic valid_meta_q;
    logic valid_sync_q;
    logic [4:0] gray_meta_q;
    logic [4:0] gray_sync_q;
    logic [2:0] mode_meta_q;
    logic [2:0] mode_sync_q;

    always_ff @(posedge dsp_clk or negedge dsp_rst_n) begin
        if (!dsp_rst_n) begin
            event_meta_q      <= 1'b0;
            event_sync_q      <= 1'b0;
            event_prev_q      <= 1'b0;
            valid_meta_q      <= 1'b0;
            valid_sync_q      <= 1'b0;
            gray_meta_q       <= 5'd0;
            gray_sync_q       <= 5'd0;
            mode_meta_q       <= 3'd0;
            mode_sync_q       <= 3'd0;
            dsp_sample_o      <= 32'd0;
            dsp_event_level_o <= 1'b0;
            dsp_irq_req_o     <= 1'b0;
        end else begin
            event_meta_q <= sensor_event_toggle_i;
            event_sync_q <= event_meta_q;
            event_prev_q <= event_sync_q;
            dsp_event_level_o <= event_sync_q ^ event_prev_q;

            valid_meta_q <= sensor_valid_i;
            valid_sync_q <= valid_meta_q;
            // CDC_022: Synchronized valid is used to sample raw sensor payload and status buses.
            if (valid_sync_q) begin
                dsp_sample_o <= sensor_payload_i ^ {24'd0, sensor_status_i};
            end

            gray_meta_q <= sensor_gray_count_i;
            gray_sync_q <= gray_meta_q;
            // CDC_023: Gray counter phase is combined with cfg threshold from another clock domain.
            if (gray_sync_q[2:0] == cfg_threshold_i[2:0]) begin
                dsp_irq_req_o <= 1'b1;
            end

            mode_meta_q <= cfg_mode_shadow_i;
            mode_sync_q <= mode_meta_q;
            // CDC_024: Independently synchronized mode bits and async clear reconverge in DSP control.
            if (debug_clear_cfg_i || (mode_sync_q == 3'd7)) begin
                dsp_irq_req_o <= 1'b0;
            end
        end
    end
endmodule

module multi_protocol_cdc_hazards_mem_writer (
    input  logic        mem_clk,
    input  logic        mem_rst_n,
    input  logic        axi_rst_n_i,
    input  logic        axi_desc_valid_i,
    input  logic        axi_mem_kick_i,
    input  logic [31:0] axi_descriptor_i,
    input  logic [31:0] axi_status_word_i,
    output logic        mem_done_toggle_o,
    output logic [4:0]  mem_read_ptr_bin_o,
    output logic [4:0]  mem_write_ptr_bin_o
);
    logic desc_valid_meta_q;
    logic desc_valid_sync_q;
    logic kick_d;

    always_ff @(posedge mem_clk or negedge mem_rst_n) begin
        if (!mem_rst_n) begin
            desc_valid_meta_q   <= 1'b0;
            desc_valid_sync_q   <= 1'b0;
            kick_d              <= 1'b0;
            mem_done_toggle_o   <= 1'b0;
            mem_read_ptr_bin_o  <= 5'd0;
            mem_write_ptr_bin_o <= 5'd0;
        end else begin
            desc_valid_meta_q <= axi_desc_valid_i;
            desc_valid_sync_q <= desc_valid_meta_q;
            // CDC_025: Descriptor valid is synchronized, but descriptor payload is sampled raw in mem_clk.
            if (desc_valid_sync_q) begin
                mem_write_ptr_bin_o <= mem_write_ptr_bin_o + axi_descriptor_i[4:0];
            end

            kick_d <= axi_mem_kick_i;
            // CDC_026: AXI kick pulse is edge-detected in mem_clk without a toggle or acknowledge protocol.
            if (axi_mem_kick_i & ~kick_d) begin
                mem_done_toggle_o <= ~mem_done_toggle_o;
            end

            // CDC_027: AXI status bits are folded into a memory pointer without bus coherency protection.
            mem_read_ptr_bin_o <= mem_read_ptr_bin_o + axi_status_word_i[12:8];

            // CDC_028: AXI reset is used as a synchronous data condition in memory-domain logic.
            if (!axi_rst_n_i) begin
                mem_read_ptr_bin_o <= 5'd0;
            end
        end
    end
endmodule

module multi_protocol_cdc_hazards_debug_tap (
    input  logic        debug_clk,
    input  logic        debug_rst_n,
    input  logic        cfg_clk,
    input  logic [31:0] cfg_status_word_i,
    input  logic [31:0] axi_status_word_i,
    input  logic [31:0] dsp_sample_i,
    input  logic        dsp_event_level_i,
    input  logic [4:0]  mem_write_ptr_bin_i,
    output logic [31:0] debug_status_o,
    output logic        debug_trigger_o
);
    logic [31:0] shadow_q;
    logic        event_d;
    logic        cfg_shadow_reset_q;

    always_ff @(posedge debug_clk or negedge debug_rst_n) begin
        if (!debug_rst_n) begin
            shadow_q        <= 32'd0;
            event_d         <= 1'b0;
            debug_status_o  <= 32'd0;
            debug_trigger_o <= 1'b0;
        end else begin
            // CDC_029: Debug samples cfg, AXI, DSP, and MEM status in one cycle without snapshot handshakes.
            shadow_q <= cfg_status_word_i ^ axi_status_word_i ^ dsp_sample_i ^ {27'd0, mem_write_ptr_bin_i};

            event_d <= dsp_event_level_i;
            // CDC_030: DSP event level is sampled and converted to a debug pulse with only one history flop.
            debug_trigger_o <= dsp_event_level_i & ~event_d;

            debug_status_o <= shadow_q;
        end
    end

    // CDC_031: Debug reset asynchronously releases cfg-clocked shadow logic.
    always_ff @(posedge cfg_clk or negedge debug_rst_n) begin
        if (!debug_rst_n) begin
            cfg_shadow_reset_q <= 1'b0;
        end else begin
            cfg_shadow_reset_q <= cfg_shadow_reset_q | debug_status_o[0];
        end
    end
endmodule

module multi_protocol_cdc_hazards_reset_manager (
    input  logic cfg_clk,
    input  logic axi_clk,
    input  logic mem_clk,
    input  logic cfg_rst_n,
    input  logic axi_rst_n,
    input  logic mem_rst_n,
    input  logic cfg_reset_req_i,
    input  logic mem_done_toggle_i,
    output logic cdc_reset_n_o
);
    logic cfg_seen_q;
    logic axi_seen_q;
    logic mem_seen_q;
    logic mem_done_axi_q;
    logic mem_done_cfg_q;

    always_ff @(posedge cfg_clk or negedge cfg_rst_n) begin
        if (!cfg_rst_n) begin
            cfg_seen_q     <= 1'b0;
            mem_done_cfg_q <= 1'b0;
        end else begin
            mem_done_cfg_q <= mem_done_toggle_i;
            // CDC_032: Memory completion toggle is consumed in cfg reset sequencing with a single sample.
            cfg_seen_q <= cfg_reset_req_i | mem_done_cfg_q;
        end
    end

    always_ff @(posedge axi_clk or negedge axi_rst_n) begin
        if (!axi_rst_n) begin
            axi_seen_q     <= 1'b0;
            mem_done_axi_q <= 1'b0;
        end else begin
            mem_done_axi_q <= mem_done_toggle_i;
            // CDC_033: Same async toggle is sampled in AXI and reconverged with cfg reset sequencing.
            axi_seen_q <= mem_done_axi_q;
        end
    end

    always_ff @(posedge mem_clk or negedge mem_rst_n) begin
        if (!mem_rst_n) begin
            mem_seen_q <= 1'b0;
        end else begin
            mem_seen_q <= mem_done_toggle_i;
        end
    end

    always_comb begin
        // CDC_034: Reset release combines state from three unrelated clock domains as combinational logic.
        cdc_reset_n_o = cfg_seen_q & axi_seen_q & mem_seen_q;
    end
endmodule
