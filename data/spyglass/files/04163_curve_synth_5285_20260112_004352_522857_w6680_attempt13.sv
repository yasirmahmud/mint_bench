module curve_synth_5285_20260112_004352_522857_w6680_attempt13 (
  input [3:0] data_in_a,
  input [3:0] data_in_b,
  output is_onehot_a,
  output is_onehot_b
);

  // SYNTH_5285 violation for $onehot (occurrence 1)
  // System function '$onehot' is not synthesizable
  assign is_onehot_a = $onehot(data_in_a);

  // SYNTH_5285 violation for $onehot (occurrence 2)
  // System function '$onehot' is not synthesizable
  assign is_onehot_b = $onehot(data_in_b);

endmodule
