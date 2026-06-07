module curve_badimplicitsm2_20260112_011903_605201_w6680_attempt15 (
  input wire        clk_i,
  input wire        data_i,
  output reg        pos_q,
  output reg        neg_q
);

  // SpyGlass violation: badimplicitSM2
  // This 'always' block contains multiple event control statements targeting different clock edges
  // (posedge and negedge of clk_i) for different registers (pos_q and neg_q).
  // This construct is considered unsynthesizable implicit sequential logic where states
  // are updated on different clock phases within the same 'always' block, triggering badimplicitSM2.
  always begin
    @(posedge clk_i) pos_q <= data_i;
    @(negedge clk_i) neg_q <= ~data_i;
  end

endmodule
