module GroupOFAsgn_ex2;
 reg b, c, d;
 always @(*) begin
  d <= 1'b0; // Fix: Assign d explicitly
  c <= 1'b0; // Fix: Assign c explicitly
  b <= 1'b0; // Fix: Assign b explicitly
 end
endmodule
