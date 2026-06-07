module curve_synth_5285_20260112_004352_522857_w6680_attempt15 (
  input [3:0] data_vec_a,
  input [3:0] data_vec_b,
  output is_onehot_status_a,
  output is_onehot_status_b
);

  // SYNTH_5285 violation for $onehot (occurrence 1)
  // System function '$onehot' is not synthesizable
  assign is_onehot_status_a = $onehot(data_vec_a);

  // SYNTH_5285 violation for $onehot (occurrence 2)
  // System function '$onehot' is not synthesizable
  assign is_onehot_status_b = $onehot(data_vec_b);

endmodule
