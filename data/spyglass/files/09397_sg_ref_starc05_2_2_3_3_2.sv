module STARC05_2_2_3_3_ex2 (input clk, d, output reg q);
 always @(posedge clk) begin q <= 1'b0;
 q <= d;
 end endmodule
