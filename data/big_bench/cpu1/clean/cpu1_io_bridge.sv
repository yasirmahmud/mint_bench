`timescale 1ns/1ps
`default_nettype none

module cpu1_io_bridge (
    input  wire        core_valid,
    input  wire        core_write,
    input  wire [15:0] core_addr,
    input  wire [31:0] core_wdata,
    input  wire [3:0]  core_wstrb,
    output wire [31:0] core_rdata,
    output wire        core_ready,
    output wire        io_valid,
    output wire        io_write,
    output wire [15:0] io_addr,
    output wire [31:0] io_wdata,
    output wire [3:0]  io_wstrb,
    input  wire [31:0] io_rdata,
    input  wire        io_ready
);
    assign io_valid = core_valid;
    assign io_write = core_write;
    assign io_addr = core_addr;
    assign io_wdata = core_wdata;
    assign io_wstrb = core_wstrb;
    assign core_rdata = io_rdata;
    assign core_ready = io_ready | !core_valid;
endmodule

`default_nettype wire
