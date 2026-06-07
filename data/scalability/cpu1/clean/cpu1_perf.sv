`timescale 1ns/1ps
`default_nettype none

module cpu1_perf (
    input  wire        clk,
    input  wire        rst_n,
    input  wire        stall,
    input  wire        retire,
    input  wire        mem_read,
    input  wire        mem_write,
    input  wire        branch_taken,
    output reg  [31:0] cycle_count,
    output reg  [31:0] instr_count,
    output reg  [31:0] load_count,
    output reg  [31:0] store_count,
    output reg  [31:0] branch_count
);
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cycle_count  <= 32'd0;
            instr_count  <= 32'd0;
            load_count   <= 32'd0;
            store_count  <= 32'd0;
            branch_count <= 32'd0;
        end else begin
            cycle_count <= cycle_count + 32'd1;
            if (retire && !stall) begin
                instr_count <= instr_count + 32'd1;
                if (mem_read) begin
                    load_count <= load_count + 32'd1;
                end
                if (mem_write) begin
                    store_count <= store_count + 32'd1;
                end
                if (branch_taken) begin
                    branch_count <= branch_count + 32'd1;
                end
            end
        end
    end
endmodule

`default_nettype wire
