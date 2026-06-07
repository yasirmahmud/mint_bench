module flop_data_undriven_ex2 (input clk, output reg q);
 wire d_undriven;
 always @(posedge clk) q <= d_undriven;
 endmodule
