module flop_srex_ex2 (input clk, input d, output reg q);
 wire async_reset;
 always @(posedge clk or posedge async_reset) begin if (async_reset) q <= 1'b0;
 else q <= d;
 end endmodule
