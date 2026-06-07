module curve_synth_5338_20260110_204324_attempt7 (
  input [3:0] base_val,
  output [11:0] result
);

  // SYNTH_5338 violation: Exponentiation is supported only if the base is a power of 2
  // or the exponent is 0, 1, or 2.
  // Here, 'base_val' is a generic 4-bit input, which is not guaranteed to be a power of 2.
  // The exponent '3' is not 0, 1, or 2.
  assign result = base_val ** 3;

endmodule
