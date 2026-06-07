module clock_edges_ex2 (input clk, input d1, input d2, output reg q1, output reg q2);
 always @(clk or d1) if (clk) q1 <= d1;
 always @(clk or d2) if (!clk) q2 <= d2;
 endmodule
