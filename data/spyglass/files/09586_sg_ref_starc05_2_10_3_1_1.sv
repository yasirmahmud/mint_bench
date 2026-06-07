module starc05_2_10_3_1_ex1(input clk, input [3:0] a, input [4:0] b);
 reg dummy;
 always @(posedge clk) begin if (a == a*b) dummy <= 1'b1;
 end endmodule
