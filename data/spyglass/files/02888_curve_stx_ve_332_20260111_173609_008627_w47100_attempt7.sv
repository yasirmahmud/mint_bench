module curve_stx_ve_332_20260111_173609_008627_w47100_attempt7 (
  input in_a,
  input in_b
);

  // STX_VE_332: Gate 'or' has invalid output specification for '1'b0'
  // A primitive gate's output must be a net (wire or reg), not a constant value.
  or (1'b0, in_a, in_b);

endmodule
