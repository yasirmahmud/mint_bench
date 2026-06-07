module LatchGatedClock_ex1 (input wire d, input wire clk_in, input wire gate_cond, output reg q);
 wire gated_enable = clk_in & gate_cond;
 always @(d or gated_enable) if (gated_enable) q = d;
 endmodule
