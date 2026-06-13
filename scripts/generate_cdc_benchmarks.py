#!/usr/bin/env python3
from __future__ import annotations

import json
import re
from dataclasses import dataclass
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
CDC_ROOT = ROOT / "data" / "cdc"


@dataclass(frozen=True)
class CdcDesign:
    name: str
    title: str
    source_domain: str
    destination_domain: str
    auxiliary_domain: str
    payload: str
    mode: str
    event: str
    reset: str


DESIGNS = [
    CdcDesign("cdc_axi_stream_bridge", "AXI stream bridge", "s_axis", "m_axis", "cfg", "packet", "route", "tlast", "s_axis"),
    CdcDesign("cdc_dma_descriptor", "DMA descriptor handoff", "cfg", "dma", "mem", "descriptor", "channel", "kick", "cfg"),
    CdcDesign("cdc_interrupt_router", "Interrupt router", "periph", "cpu", "debug", "irq_vector", "priority", "irq", "periph"),
    CdcDesign("cdc_reset_sequencer", "Reset sequencer", "pmu", "core", "fabric", "reset_state", "boot_mode", "release", "pmu"),
    CdcDesign("cdc_clock_mux_status", "Clock mux status monitor", "scan", "func", "cfg", "mux_status", "select", "scan_done", "scan"),
    CdcDesign("cdc_low_power_island", "Low-power island control", "aon", "island", "sys", "power_state", "retention", "wake", "aon"),
    CdcDesign("cdc_sensor_packetizer", "Sensor packetizer", "sensor", "fabric", "cfg", "sample_packet", "format", "sample", "sensor"),
    CdcDesign("cdc_timer_capture", "Timer capture block", "timer", "apb", "trace", "timer_count", "capture_mode", "tick", "timer"),
    CdcDesign("cdc_uart_debug_bridge", "UART debug bridge", "uart", "sys", "debug", "rx_word", "debug_mode", "rx_ready", "uart"),
    CdcDesign("cdc_i2c_register_bank", "I2C register bank", "i2c", "cfg", "sys", "i2c_shadow", "bank", "stop", "i2c"),
    CdcDesign("cdc_spi_dma_frontend", "SPI DMA frontend", "spi", "dma", "cfg", "spi_frame", "lane", "frame_done", "spi"),
    CdcDesign("cdc_video_frame_sync", "Video frame synchronizer", "pixel", "system", "display", "frame_meta", "color_mode", "vsync", "pixel"),
    CdcDesign("cdc_audio_sample_bridge", "Audio sample bridge", "audio", "bus", "dsp", "sample_word", "gain_mode", "sample_strobe", "audio"),
    CdcDesign("cdc_gpio_wakeup", "GPIO wakeup collector", "gpio", "pmu", "aon", "gpio_state", "wake_mode", "edge", "gpio"),
    CdcDesign("cdc_memory_scrubber", "Memory scrubber", "mem", "ctrl", "diag", "scrub_status", "scrub_mode", "done", "mem"),
    CdcDesign("cdc_error_aggregator", "Error aggregator", "block", "service", "trace", "error_bundle", "mask_mode", "fault", "block"),
    CdcDesign("cdc_security_lifecycle", "Security lifecycle bridge", "lc", "core", "otp", "lifecycle_state", "policy", "escalate", "lc"),
    CdcDesign("cdc_perf_monitor", "Performance monitor", "core", "trace", "bus", "counter_snapshot", "trace_mode", "sample", "core"),
    CdcDesign("cdc_noc_credit_return", "NoC credit return path", "router", "noc", "mgmt", "credit_state", "vc_mode", "credit", "router"),
    CdcDesign("cdc_pcie_completion", "PCIe completion bridge", "pcie", "core", "cfg", "completion_data", "tag_mode", "cpl", "pcie"),
    CdcDesign("cdc_ethernet_mac_stats", "Ethernet MAC statistics bridge", "rxmac", "csr", "txmac", "mac_stats", "stat_sel", "rx_good", "rxmac"),
    CdcDesign("cdc_usb_endpoint", "USB endpoint bridge", "usb", "sys", "debug", "endpoint_data", "ep_mode", "token", "usb"),
    CdcDesign("cdc_ddr_refresh_ctrl", "DDR refresh controller", "ddr", "ctrl", "apb", "refresh_state", "rank_mode", "refresh", "ddr"),
    CdcDesign("cdc_jtag_access_port", "JTAG access port", "jtag", "system", "trace", "jtag_shift", "tap_state", "update", "jtag"),
    CdcDesign("cdc_mailbox_apb", "Mailbox APB bridge", "apb", "mailbox", "irq", "mail_payload", "mailbox_mode", "write", "apb"),
    CdcDesign("cdc_thermal_shutdown", "Thermal shutdown bridge", "thermal", "pmu", "aon", "thermal_code", "trip_mode", "overtemp", "thermal"),
    CdcDesign("cdc_pll_lock_monitor", "PLL lock monitor", "pll", "sys", "cfg", "lock_vector", "bypass_mode", "lock", "pll"),
    CdcDesign("cdc_watchdog_service", "Watchdog service path", "wdt", "cpu", "pmu", "watchdog_count", "service_mode", "bark", "wdt"),
    CdcDesign("cdc_crypto_key_loader", "Crypto key loader", "key", "crypto", "bus", "key_share", "key_mode", "key_valid", "key"),
    CdcDesign("cdc_ml_accel_queue", "ML accelerator queue", "host", "accel", "dma", "queue_entry", "op_mode", "enqueue", "host"),
    CdcDesign("cdc_cache_coherency_probe", "Cache coherency probe", "snoop", "cache", "core", "probe_bits", "probe_mode", "probe", "snoop"),
    CdcDesign("cdc_trace_funnel", "Trace funnel", "trace", "fabric", "debug", "trace_word", "funnel_mode", "trace_valid", "trace"),
    CdcDesign("cdc_serdes_lane_align", "SERDES lane alignment", "serdes", "link", "cfg", "lane_marker", "align_mode", "comma", "serdes"),
    CdcDesign("cdc_can_bus_gateway", "CAN bus gateway", "can", "sys", "diag", "can_frame", "filter_mode", "frame", "can"),
    CdcDesign("cdc_adc_sample_fifo", "ADC sample frontend", "adc", "dsp", "cfg", "adc_sample", "range_mode", "sample_ready", "adc"),
    CdcDesign("cdc_dac_control", "DAC control bridge", "bus", "dac", "analog", "dac_code", "slew_mode", "load", "bus"),
    CdcDesign("cdc_pwm_duty_update", "PWM duty update", "cfg", "pwm", "aon", "duty_cycle", "period_mode", "commit", "cfg"),
    CdcDesign("cdc_qspi_flash_reader", "QSPI flash reader", "qspi", "ahb", "cfg", "flash_word", "read_mode", "burst_done", "qspi"),
    CdcDesign("cdc_sdio_command", "SDIO command bridge", "sdio", "sys", "dma", "cmd_response", "cmd_mode", "cmd_done", "sdio"),
    CdcDesign("cdc_fuse_shadow", "Fuse shadow loader", "fuse", "core", "otp", "fuse_word", "shadow_mode", "fuse_done", "fuse"),
    CdcDesign("cdc_boot_rom_patch", "Boot ROM patch bridge", "rom", "core", "cfg", "patch_word", "patch_mode", "patch_valid", "rom"),
    CdcDesign("cdc_debug_breakpoint", "Debug breakpoint bridge", "debug", "core", "trace", "break_state", "halt_mode", "break_hit", "debug"),
    CdcDesign("cdc_dma_done_arbiter", "DMA done arbiter", "dma", "irq", "cfg", "done_vector", "arb_mode", "done", "dma"),
    CdcDesign("cdc_packet_timestamp", "Packet timestamp bridge", "ptp", "mac", "csr", "timestamp_word", "time_mode", "stamp", "ptp"),
    CdcDesign("cdc_lane_bonding_ctrl", "Lane bonding controller", "lane", "pcs", "cfg", "bond_state", "bond_mode", "bond_done", "lane"),
    CdcDesign("cdc_sram_bist_status", "SRAM BIST status bridge", "bist", "sys", "test", "bist_status", "repair_mode", "bist_done", "bist"),
    CdcDesign("cdc_riscv_debug_hart", "RISC-V debug hart bridge", "dm", "hart", "jtag", "hart_cmd", "debug_mode", "resume", "dm"),
    CdcDesign("cdc_power_domain_ack", "Power-domain acknowledge path", "pwr", "soc", "aon", "ack_vector", "power_mode", "ack", "pwr"),
    CdcDesign("cdc_voltage_monitor", "Voltage monitor bridge", "volt", "pmu", "sys", "voltage_code", "alarm_mode", "droop", "volt"),
    CdcDesign("cdc_display_tearing", "Display tearing-effect sync", "display", "host", "pixel", "te_state", "panel_mode", "te", "display"),
    CdcDesign("cdc_camera_csi_rx", "Camera CSI receiver", "csi", "isp", "cfg", "frame_header", "lane_mode", "sof", "csi"),
    CdcDesign("cdc_tdm_audio_router", "TDM audio router", "tdm", "audio", "bus", "slot_sample", "slot_mode", "slot_valid", "tdm"),
    CdcDesign("cdc_hbm_channel_status", "HBM channel status bridge", "hbm", "noc", "cfg", "channel_status", "stack_mode", "alert", "hbm"),
    CdcDesign("cdc_satellite_modem", "Satellite modem bridge", "modem", "host", "rf", "modem_packet", "link_mode", "syncword", "modem"),
    CdcDesign("cdc_timebase_adjust", "Timebase adjustment bridge", "rtc", "cpu", "aon", "time_adjust", "slew_mode", "adjust", "rtc"),
    CdcDesign("cdc_secure_mailbox", "Secure mailbox bridge", "secure", "normal", "audit", "secure_msg", "access_mode", "doorbell", "secure"),
    CdcDesign("cdc_sensor_fusion", "Sensor fusion bridge", "imu", "fusion", "host", "fusion_input", "fusion_mode", "imu_ready", "imu"),
    CdcDesign("cdc_network_flow_table", "Network flow-table bridge", "parser", "lookup", "mgmt", "flow_key", "lookup_mode", "flow_hit", "parser"),
]


def module_name(design: CdcDesign) -> str:
    return f"{design.name}_top"


def issue_id(design: CdcDesign, index: int) -> str:
    return f"{design.name.upper()}_{index:03d}"


def render_sv(design: CdcDesign) -> str:
    mod = module_name(design)
    s = design.source_domain
    d = design.destination_domain
    a = design.auxiliary_domain
    payload = design.payload
    mode = design.mode
    event = design.event
    reset = design.reset
    return f"""// SPDX-License-Identifier: MIT
//
// {design.title} CDC benchmark.
// The CDC_ markers identify intentional benchmark defects.

`timescale 1ns/1ps

module {mod} (
    input  logic        {s}_clk,
    input  logic        {d}_clk,
    input  logic        {a}_clk,
    input  logic        {s}_rst_n,
    input  logic        {d}_rst_n,
    input  logic        {a}_rst_n,
    input  logic        {event}_i,
    input  logic [31:0] {payload}_i,
    input  logic [3:0]  {mode}_i,
    input  logic        {a}_sample_i,
    output logic [31:0] {d}_status_o,
    output logic        {d}_event_o,
    output logic [31:0] {a}_snapshot_o
);
    logic [31:0] {payload}_q;
    logic [3:0]  {mode}_q;
    logic        {event}_pulse_q;
    logic        {event}_toggle_q;
    logic        {event}_seen_q;
    logic [3:0]  {mode}_meta_q;
    logic [3:0]  {mode}_sync_q;
    logic        {reset}_reset_seen_q;
    logic [31:0] {d}_shadow_q;
    logic [31:0] {a}_snapshot_q;

    always_ff @(posedge {s}_clk or negedge {s}_rst_n) begin
        if (!{s}_rst_n) begin
            {payload}_q <= 32'd0;
            {mode}_q <= 4'd0;
            {event}_pulse_q <= 1'b0;
            {event}_toggle_q <= 1'b0;
        end else begin
            {payload}_q <= {payload}_i + {{24'd0, {mode}_i, 4'd3}};
            {mode}_q <= {mode}_i;
            {event}_pulse_q <= {event}_i;
            if ({event}_i) begin
                {event}_toggle_q <= ~{event}_toggle_q;
            end
        end
    end

    always_ff @(posedge {d}_clk or negedge {d}_rst_n) begin
        if (!{d}_rst_n) begin
            {d}_status_o <= 32'd0;
            {d}_event_o <= 1'b0;
            {event}_seen_q <= 1'b0;
            {mode}_meta_q <= 4'd0;
            {mode}_sync_q <= 4'd0;
            {reset}_reset_seen_q <= 1'b0;
            {d}_shadow_q <= 32'd0;
        end else begin
            // CDC_{issue_id(design, 1)}: multi-bit source payload is sampled without a coherency protocol.
            {d}_status_o <= {payload}_q;

            // CDC_{issue_id(design, 2)}: one-cycle source pulse is consumed directly by the destination.
            if ({event}_pulse_q) begin
                {d}_shadow_q <= {payload}_q;
            end

            {event}_seen_q <= {event}_toggle_q;
            // CDC_{issue_id(design, 3)}: raw toggle reconverges with a one-sample destination history.
            {d}_event_o <= {event}_toggle_q ^ {event}_seen_q;

            {mode}_meta_q <= {mode}_q;
            // CDC_{issue_id(design, 4)}: encoded control bits are synchronized independently and decoded as an atomic mode.
            {mode}_sync_q <= {mode}_meta_q;

            if ({mode}_sync_q == 4'hA) begin
                {d}_status_o[7:0] <= {d}_shadow_q[7:0] ^ {payload}_q[7:0];
            end

            // CDC_{issue_id(design, 5)}: source reset is used as destination-domain data.
            if (!{s}_rst_n) begin
                {reset}_reset_seen_q <= 1'b0;
            end else begin
                {reset}_reset_seen_q <= {reset}_reset_seen_q | {event}_seen_q;
            end
        end
    end

    always_ff @(posedge {a}_clk or negedge {a}_rst_n) begin
        if (!{a}_rst_n) begin
            {a}_snapshot_q <= 32'd0;
            {a}_snapshot_o <= 32'd0;
        end else begin
            // CDC_{issue_id(design, 6)}: auxiliary snapshot combines source and destination values without a snapshot handshake.
            {a}_snapshot_q <= {payload}_q ^ {d}_status_o;
            if ({a}_sample_i) begin
                {a}_snapshot_o <= {a}_snapshot_q;
            end
        end
    end
endmodule
"""


def descriptions(design: CdcDesign) -> dict[str, str]:
    s = design.source_domain
    d = design.destination_domain
    a = design.auxiliary_domain
    payload = design.payload
    mode = design.mode
    event = design.event
    reset = design.reset
    return {
        issue_id(design, 1): f"{payload}_q is a multi-bit value produced in {s}_clk and sampled directly in {d}_clk without a bundled-data handshake or hold guarantee.",
        issue_id(design, 2): f"{event}_pulse_q is a one-cycle {s}_clk pulse consumed directly in {d}_clk, so the event can be missed or sampled metastably.",
        issue_id(design, 3): f"{event}_toggle_q reconverges with a one-sample {d}_clk history, allowing metastability or double-counting in {d}_event_o.",
        issue_id(design, 4): f"{mode}_sync_q receives independently synchronized bits from encoded control vector {mode}_q before decoding in {d}_clk, so transient illegal modes can be observed.",
        issue_id(design, 5): f"{reset}_rst_n is used as data inside {d}_clk logic, so reset deassertion can asynchronously change destination state.",
        issue_id(design, 6): f"{a}_snapshot_q combines {s}_clk payload state with {d}_clk status state in {a}_clk without a cross-domain snapshot protocol.",
    }


def find_issue_lines(text: str) -> dict[str, int]:
    lines = text.splitlines()
    result: dict[str, int] = {}
    marker_re = re.compile(r"CDC_(CDC_[A-Z0-9_]+_\d{3})")
    for index, line in enumerate(lines):
        match = marker_re.search(line)
        if not match:
            continue
        issue = match.group(1)
        for target_index in range(index + 1, len(lines)):
            candidate = lines[target_index].strip()
            if candidate and not candidate.startswith("//"):
                result[issue] = target_index + 1
                break
    return result


def write_design(design: CdcDesign) -> None:
    design_dir = CDC_ROOT / design.name
    design_dir.mkdir(parents=True, exist_ok=True)
    sv_name = f"{design.name}.sv"
    sv_text = render_sv(design)
    (design_dir / sv_name).write_text(sv_text, encoding="utf-8")

    issue_lines = find_issue_lines(sv_text)
    issue_descriptions = descriptions(design)
    errors = [
        {
            "file_name": sv_name,
            "line": issue_lines[key],
            "description": issue_descriptions[key],
        }
        for key in sorted(issue_descriptions)
    ]
    (design_dir / f"{design.name}_errors.json").write_text(
        json.dumps({"errors": errors}, indent=2) + "\n",
        encoding="utf-8",
    )

    readme = f"""# {design.name}

{design.title} CDC benchmark containing six intentional clock-domain crossing defects.

The design focuses on:

- multi-bit data capture without a bundled-data protocol
- direct consumption of a one-cycle source-domain pulse
- reconvergence between a raw toggle and destination history
- independent synchronization of an encoded control vector
- reset-as-data use across clock domains
- mixed-domain auxiliary snapshots without a snapshot handshake

Ground-truth annotations are stored in `{design.name}_errors.json` using the standardized benchmark format from `docs/example_benchmark_format.json`.
"""
    (design_dir / "README.md").write_text(readme, encoding="utf-8")


def main() -> None:
    for design in DESIGNS:
        write_design(design)
    print(f"generated {len(DESIGNS)} CDC benchmark designs")


if __name__ == "__main__":
    main()
