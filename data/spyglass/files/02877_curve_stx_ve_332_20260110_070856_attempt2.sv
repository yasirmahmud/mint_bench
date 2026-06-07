module curve_stx_ve_332_20260110_070856_attempt2 (
  input in_a,
  input in_b
);

  // STX_VE_332: Gate 'nand' has invalid output specification for '1'b1'
  nand u_nand (1'b1, in_a, in_b);

endmodule
