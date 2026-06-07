module sim_race08_ex1(input d, input clk_a, input clk_b, output reg q);
 wire clk;
 assign clk = clk_a;
 assign clk = clk_b;
 always @(posedge clk) q <= d;
 endmodule
