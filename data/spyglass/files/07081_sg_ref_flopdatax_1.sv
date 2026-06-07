module FlopDataX_ex1 (input clk, output reg q);
 reg d;
 always @(posedge clk) begin q <= d;
 end assign d = 1'bx;
 endmodule
