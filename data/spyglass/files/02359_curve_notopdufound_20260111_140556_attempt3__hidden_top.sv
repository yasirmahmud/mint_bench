`timescale 1ns / 1ps

// This Verilog file defines a module within a conditional compilation block (`ifdef`).
// The condition `SIMULATION_ONLY_MODULE` is intentionally left undefined.
// As a result, when SpyGlass analyzes this file without `SIMULATION_ONLY_MODULE` defined,
// it will not find any top-level design unit, triggering the 'NoTopDUFound' violation.

`ifdef SIMULATION_ONLY_MODULE
module hidden_top (
    input clk,
    input rst_n,
    output reg [3:0] counter_out
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            counter_out <= 4'h0;
        end else begin
            counter_out <= counter_out + 1'b1;
        end
    end

endmodule
