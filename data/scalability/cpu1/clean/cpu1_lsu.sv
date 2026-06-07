`timescale 1ns/1ps
`default_nettype none

module cpu1_lsu (
    input  wire        mem_read,
    input  wire        mem_write,
    input  wire [31:0] addr_base,
    input  wire [31:0] store_data,
    input  wire [31:0] imm,
    input  wire [31:0] io_rdata,
    input  wire        io_ready,
    output wire [15:0] io_addr,
    output wire [31:0] io_wdata,
    output wire [3:0]  io_wstrb,
    output wire        io_valid,
    output wire        io_write,
    output wire [31:0] load_data,
    output wire        stall,
    output wire        fault
);
    wire [31:0] effective_addr;

    assign effective_addr = addr_base + imm;
    assign io_addr = effective_addr[15:0];
    assign io_wdata = store_data;
    assign io_wstrb = mem_write ? 4'hF : 4'h0;
    assign io_valid = mem_read | mem_write;
    assign io_write = mem_write;
    assign load_data = io_rdata ^ {16'd0, effective_addr[15:0]};
    assign stall = io_valid & !io_ready;
    assign fault = io_valid & (effective_addr[31:16] != 16'd0);
endmodule

`default_nettype wire
