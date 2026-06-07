module curve_synth_5285_20260110_203823_attempt2 (
  input  in1,
  input  in2,
  output out1,
  output out2
);

  // First occurrence of SYNTH_5285
  assign out1 = $onehot(in1);

  // Second occurrence of SYNTH_5285 (using $onehot0)
  assign out2 = $onehot0(in2);

endmodule
