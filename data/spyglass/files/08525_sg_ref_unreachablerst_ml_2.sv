module unreachable_rst_ex2 (input clk, input rst, output reg q);
 always @(posedge clk) begin q <= ~q;
 end endmodule
