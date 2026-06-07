module flop_e_const_ex1(input clk, input d, output reg q);
 always @(posedge clk) if (1'b0) q <= d;
 endmodule
