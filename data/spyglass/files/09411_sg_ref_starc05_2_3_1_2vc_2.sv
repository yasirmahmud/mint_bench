module my_module_ex2 (input clk, input d, output reg q);
 always @(clk) begin if (clk) q <= d;
 end endmodule
