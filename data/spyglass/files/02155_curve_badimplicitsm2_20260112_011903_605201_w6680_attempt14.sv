module curve_badimplicitsm2_20260112_011903_605201_w6680_attempt14 (
  input wire        sys_clk,
  input wire        d_in,
  output reg        p_out,
  output reg        n_out
);

  // SpyGlass violation: badimplicitSM2
  // This 'always' block implicitly describes sequential logic that updates
  // states (p_out and n_out) on both positive and negative edges of the same clock (sys_clk).
  // Such a construct is unsynthesizable as states can only be updated on the same clock phase.
  always begin
    @(posedge sys_clk) p_out <= d_in;
    @(negedge sys_clk) n_out <= d_in;
  end

endmodule
