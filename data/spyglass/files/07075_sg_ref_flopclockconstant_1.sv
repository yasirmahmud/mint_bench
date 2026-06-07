module flop_clock_constant_ex1(input d, output reg q);
 wire clk_const = 1'b0;
 always @(posedge clk_const) q <= d;
 endmodule
