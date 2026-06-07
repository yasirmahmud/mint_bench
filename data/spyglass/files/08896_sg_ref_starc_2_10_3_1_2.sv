module starc_2_10_3_1_ex2(input clk, input [3:0] a, input [4:0] b, output reg out);
 always @(posedge clk) begin if (a == a + b) begin out <= 1'b1;
 end else begin out <= 1'b0;
 end end endmodule
