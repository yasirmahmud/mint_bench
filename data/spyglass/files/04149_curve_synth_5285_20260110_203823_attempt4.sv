module curve_synth_5285_20260110_203823_attempt4 (
  input  [3:0] in_data,
  output       is_onehot,
  output       is_onehot0,
  output [3:0] dummy_out
);

  // First occurrence of SYNTH_5285: $onehot is not synthesizable
  assign is_onehot  = $onehot(in_data);

  // Second occurrence of SYNTH_5285: $onehot0 is also not synthesizable
  assign is_onehot0 = $onehot0(in_data);

  // Synthesizable usage of in_data to prevent W240 (input declared but not read)
  assign dummy_out = in_data;

endmodule
