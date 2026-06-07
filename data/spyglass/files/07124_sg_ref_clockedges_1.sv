module ClockEdges_ex1 (input clk, input d1, input d2, output reg q1, output reg q2);
 wire clk_n;
 assign clk_n = ~clk;
 always @(clk or d1) begin if (clk) begin q1 = d1;
 end end always @(clk_n or d2) begin if (clk_n) begin q2 = d2;
 end end endmodule
