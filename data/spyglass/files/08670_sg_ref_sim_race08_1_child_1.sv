module sim_race08_ex1(input d, input clk_a, input clk_b, output reg q);
 wire clk;
 assign clk = clk_a;
 always @(posedge clk) q <= d;
 endmodule
