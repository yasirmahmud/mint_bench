module curve_stx_ve_332_20260110_070856_attempt3 (
  input in1,
  input in2
);

  // STX_VE_332: Gate 'or' has invalid output specification for '1'b1'
  // This rule triggers when a constant value (like 1'b1) is used as the output
  // of a gate primitive (e.g., 'and', 'nand', 'or', etc.).
  or u_or (1'b1, in1, in2);

endmodule
