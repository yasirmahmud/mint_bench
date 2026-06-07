module curve_synth_5338_20260110_204324_attempt6 (
    input [2:0] base_val_a,      // Input can take non-power-of-2 values
    output [8:0] result_a,       // Sufficient width for 7**3 = 343
    input [3:0] base_val_b,      // Input can take non-power-of-2 values
    output [15:0] result_b      // Sufficient width for 15**4 = 50625
);

  // First SYNTH_5338 violation:
  // The base 'base_val_a' is a variable that can take non-power-of-2 values.
  // The exponent '3' is not 0, 1, or 2.
  assign result_a = base_val_a ** 3;

  // Second SYNTH_5338 violation:
  // The base 'base_val_b' is a variable that can take non-power-of-2 values.
  // The exponent '4' is not 0, 1, or 2.
  assign result_b = base_val_b ** 4;

endmodule
