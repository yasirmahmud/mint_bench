module curve_synth_5338_20260110_204324_attempt3 (
    input [1:0] base_val_1,
    input [2:0] base_val_2,
    output [4:0] result_pow_3,
    output [11:0] result_pow_4
);

  // First instance of SYNTH_5338 violation:
  // 'base_val_1' is a 2-bit input, so it can be 3, which is not a power of 2.
  // The exponent '3' is not 0, 1, or 2.
  assign result_pow_3 = base_val_1 ** 3;

  // Second instance of SYNTH_5338 violation:
  // 'base_val_2' is a 3-bit input, so it can be 3, 5, 6, or 7, none of which are powers of 2.
  // The exponent '4' is not 0, 1, or 2.
  assign result_pow_4 = base_val_2 ** 4;

endmodule
