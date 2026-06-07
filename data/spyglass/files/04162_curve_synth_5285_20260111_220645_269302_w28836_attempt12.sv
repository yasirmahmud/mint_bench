module curve_synth_5285_20260111_220645_269302_w28836_attempt12 (
  input [4:0] control_vec,
  output logic is_onehot_flag_a,
  output logic is_onehot_flag_b,
  output [4:0] data_copy
);

  // SYNTH_5285 violation for $onehot (occurrence 1)
  // System function '$onehot' is not synthesizable
  assign is_onehot_flag_a = $onehot(control_vec);

  // SYNTH_5285 violation for $onehot (occurrence 2)
  // System function '$onehot' is not synthesizable
  assign is_onehot_flag_b = $onehot(control_vec);

  // Synthesizable logic to ensure 'control_vec' input is read and avoid W240
  assign data_copy = control_vec;

endmodule
