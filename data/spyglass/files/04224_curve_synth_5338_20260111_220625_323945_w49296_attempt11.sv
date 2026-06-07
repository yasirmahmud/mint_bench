module curve_synth_5338_20260111_220625_323945_w49296_attempt11 (
  input [3:0] base_val_a,
  input [4:0] base_val_b,
  output [15:0] result_a,
  output [19:0] result_b
);

  // SYNTH_5338 violation 1:
  // Exponentiation is not supported when the base is not guaranteed to be a power of 2
  // and the exponent is not 0, 1, or 2.
  // Here, 'base_val_a' is a 4-bit input that can take non-power-of-2 values (e.g., 3, 5).
  // The exponent '4' is not 0, 1, or 2.
  assign result_a = base_val_a ** 4;

  // SYNTH_5338 violation 2:
  // Similar to the first violation, 'base_val_b' is a 5-bit input that can take
  // non-power-of-2 values (e.g., 3, 5, 6, 7), and the exponent '4' is invalid.
  assign result_b = base_val_b ** 4;

endmodule
