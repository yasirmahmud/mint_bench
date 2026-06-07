module curve_stx_ve_332_20260111_173609_008627_w47100_attempt6 (
  input in_a,
  input in_b
);

  // STX_VE_332: Gate 'and' has invalid output specification for '1'b1'
  // A primitive gate's output must be a net (wire or reg), not a constant value.
  and (1'b1, in_a, in_b);

endmodule
