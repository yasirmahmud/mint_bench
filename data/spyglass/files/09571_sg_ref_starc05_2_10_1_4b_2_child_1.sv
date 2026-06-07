module starc05_2_10_1_4b_ex2(input [1:0] a, output reg b);
 always @(*) begin
  if (a === 2'b1x) b = 1'b1;
  else b = 1'b0;
 end
endmodule
