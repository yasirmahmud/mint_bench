module flop_e_const_ex2 (input clk, input d, output reg q);
 always @(posedge clk) begin if (1'b0) begin q <= d;
 end end endmodule
