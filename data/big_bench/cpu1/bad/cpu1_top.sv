`timescale 1ns/1ps
`default_nettype none

module cpu1_top (
    input  wire        clk,
    input  wire        rst_n,
    input  wire        irq_async,
    output wire        io_valid,
    output wire        io_write,
    output wire [15:0] io_addr,
    output wire [31:0] io_wdata,
    output wire [3:0]  io_wstrb,
    input  wire [31:0] io_rdata,
    input  wire        io_ready,
    output wire [15:0] trace_pc,
    output wire [31:0] trace_instr,
    output wire [31:0] trace_result,
    output wire        trap,
    output wire [31:0] cycle_count,
    output wire [31:0] instr_count,
    output wire [31:0] debug_state
);
    wire        irq_sync;
    wire        core_io_valid;
    wire        core_io_write;
    wire [15:0] core_io_addr;
    wire [31:0] core_io_wdata;
    wire [3:0]  core_io_wstrb;
    wire [31:0] core_io_rdata;
    wire        core_io_ready;
    wire [7:0]  unused_top_tag;

    assign unused_top_tag = trace_pc[15:8];
    assign trap = debug_state[0];

    cpu1_irq_sync u_irq_sync (
        .clk(clk),
        .rst_n(rst_n),
        .irq_async(irq_async),
        .irq_sync(irq_sync)
    );

    cpu1_core u_core (
        .clk(clk),
        .rst_n(rst_n),
        .irq(irq_sync),
        .io_valid(core_io_valid),
        .io_write(core_io_write),
        .io_addr(core_io_addr),
        .io_wdata(core_io_wdata),
        .io_wstrb(core_io_wstrb),
        .io_rdata(core_io_rdata),
        .io_ready(core_io_ready),
        .trace_pc(trace_pc),
        .trace_instr(trace_instr),
        .trace_result(trace_result),
        .trap(trap),
        .cycle_count(cycle_count),
        .instr_count(instr_count),
        .debug_state(debug_state)
    );

    cpu1_io_bridge u_io_bridge (
        .core_valid(core_io_valid),
        .core_write(core_io_write),
        .core_addr(core_io_addr),
        .core_wdata(core_io_wdata),
        .core_wstrb(core_io_wstrb),
        .core_rdata(core_io_rdata),
        .core_ready(core_io_ready),
        .io_valid(io_valid),
        .io_write(io_write),
        .io_addr(io_addr),
        .io_wdata(io_wdata),
        .io_wstrb(io_wstrb),
        .io_rdata(io_rdata),
        .io_ready(io_ready)
    );
endmodule

`default_nettype wire
