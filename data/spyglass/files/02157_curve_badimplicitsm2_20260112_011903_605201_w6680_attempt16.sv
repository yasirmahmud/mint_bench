module curve_badimplicitsm2_20260112_011903_605201_w6680_attempt16 (
  input wire        sys_clk,
  input wire        data_in,
  output reg        ff_neg_edge,
  output reg        ff_pos_edge
);

  // SpyGlass violation: badimplicitSM2
  // This 'always' block contains multiple event control statements,
  // targeting different clock edges (negedge and posedge of sys_clk)
  // for different registers (ff_neg_edge and ff_pos_edge).
  // This construct describes unsynthesizable implicit sequential logic where
  // states are attempted to be updated on different clock phases within the same 'always' block,
  // which triggers the badimplicitSM2 violation.
  always begin
    @(negedge sys_clk) ff_neg_edge <= data_in;
    @(posedge sys_clk) ff_pos_edge <= data_in;
  end

endmodule
