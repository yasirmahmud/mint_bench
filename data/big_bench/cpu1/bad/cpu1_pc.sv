`timescale 1ns/1ps
`default_nettype none

module cpu1_pc #(
    parameter [15:0] RESET_PC = 16'h0000
) (
    input  wire        clk,
    input  wire        rst_n,
    input  wire        stall,
    input  wire        redirect_valid,
    input  wire [15:0] redirect_pc,
    output reg  [15:0] pc_q,
    output wire [15:0] pc_plus2
);
    assign pc_plus2 = pc_q + 16'd2;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            pc_q = RESET_PC;
        end else if (!stall) begin
            if (redirect_valid) begin
                pc_q <= redirect_pc;
            end else begin
                pc_q <= pc_plus2;
            end
        end else begin
            pc_q <= pc_q;
        end
    end
endmodule

`default_nettype wire
