module curve_synth_5285_20260110_203823_attempt1 (
  input [2:0] in_vec,
  output      is_onehot
);

  assign is_onehot = $onehot(in_vec);

endmodule
