module STARC_2_3_1_1_ex1(input clk, input rst, input d, output reg q);
 always @(posedge clk or posedge rst) begin if (rst) q = 1'b0;
 else q = d;
 end endmodule
