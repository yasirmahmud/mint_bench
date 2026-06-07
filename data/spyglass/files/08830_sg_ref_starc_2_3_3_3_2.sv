module STARC_2_3_3_3_ex2 (input clk, output reg q);
 always @(posedge clk or posedge clk) begin q <= 1'b1;
 end endmodule
