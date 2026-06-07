module my_module_ex2 (input clk, input d, output reg q);
 reg clk_prev;
 initial clk_prev = 1'b0;
 always @(clk) begin if (clk && !clk_prev) q <= d;
 clk_prev <= clk;
 end endmodule
