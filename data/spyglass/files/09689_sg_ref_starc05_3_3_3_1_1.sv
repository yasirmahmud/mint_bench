module STARC05_3_3_3_1_ex1 (input clk, input rst, output reg q);
 always @(posedge clk or posedge rst) begin if (rst) q <= 1'b0;
 else q <= clk;
 end endmodule
