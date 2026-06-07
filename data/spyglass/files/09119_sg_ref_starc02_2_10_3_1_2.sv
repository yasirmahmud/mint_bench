module starc02_2_10_3_1_ex2(input clk, input [3:0] a, input [4:0] b);
 reg dummy_reg;
 always @(posedge clk) begin if (a == a + b) begin dummy_reg <= 1'b0;
 end end endmodule
