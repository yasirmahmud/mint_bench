module curve_synth_5285_20260112_004352_522857_w6680_attempt14 (
  input [3:0] data_in_a,
  input [3:0] data_in_b,
  output is_onehot_a,
  output is_onehot_b
);

  // Internal wires to ensure inputs are considered "read" by synthesizable logic
  wire [3:0] internal_data_a;
  wire [3:0] internal_data_b;

  // Synthesizable use of inputs to avoid W240 "Input declared but not read"
  assign internal_data_a = data_in_a;
  assign internal_data_b = data_in_b;

  // SYNTH_5285 violation for $onehot (occurrence 1)
  // System function '$onehot' is not synthesizable
  assign is_onehot_a = $onehot(internal_data_a);

  // SYNTH_5285 violation for $onehot (occurrence 2)
  // System function '$onehot' is not synthesizable
  assign is_onehot_b = $onehot(internal_data_b);

endmodule
