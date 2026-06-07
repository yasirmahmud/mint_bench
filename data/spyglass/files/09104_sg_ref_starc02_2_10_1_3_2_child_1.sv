module STARC02_2_10_1_3_ex2(input [1:0] a, output reg b);
 always @(*) begin
  // According to SpyGlass warnings (SYNTH_5034, STARC05-2.10.1.4a/b),
  // the comparison 'a == 2'bx' with don't care bits will always evaluate to false
  // in synthesis and most simulations when using the logical equality operator '=='.
  // Therefore, the 'if' condition is never met, and 'b' is always assigned '1'b0'.
  // The functional behavior is preserved by explicitly assigning 'b = 1'b0'.
  b = 1'b0;
 end
 endmodule
