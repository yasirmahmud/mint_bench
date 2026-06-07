module curve_stx_ve_332_20260110_070856_attempt4 (
  input in1,
  input in2
);

  // STX_VE_332: Gate 'xor' has invalid output specification for '1'b1'
  // This rule triggers when a constant value (like 1'b1 or 1'b0) is used as the output
  // of a gate primitive (e.g., 'and', 'nand', 'or', 'xor', etc.).
  xor u_xor (1'b1, in1, in2);

endmodule
