module my_module_ex1(input clk, d, output reg q);
 always @(clk) begin if (!clk) q <= d;
 end endmodule
