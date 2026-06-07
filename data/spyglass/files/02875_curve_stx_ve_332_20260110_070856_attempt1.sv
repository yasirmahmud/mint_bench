module curve_stx_ve_332_20260110_070856_attempt1 (
  input in1,
  input in2
);

  // STX_VE_332: Gate 'and' has invalid output specification for '1'b1'
  and u_and (1'b1, in1, in2);

endmodule
