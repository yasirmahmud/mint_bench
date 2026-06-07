module curve_synth_5285_20260110_203823_attempt2 (
  input  in1,
  input  in2,
  output out1,
  output out2
);

  // Resolved SYNTH_5285: For a single-bit input, $onehot(in) is equivalent to in.
  assign out1 = in1;

  // Resolved SYNTH_5285: For a single-bit input, $onehot0(in) is always 1'b1.
  assign out2 = 1'b1;

endmodule
