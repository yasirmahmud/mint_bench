module STARC05_2_4_1_5_ex1 (input wire clk_en, input wire d_in, output reg q_out);
 reg latch1_q;
 always @(clk_en or d_in) if (clk_en) latch1_q = d_in;
 always @(clk_en or latch1_q) if (clk_en) q_out = latch1_q;
 endmodule
