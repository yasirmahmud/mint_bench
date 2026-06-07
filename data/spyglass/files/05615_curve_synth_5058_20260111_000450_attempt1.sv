module curve_synth_5058_20260111_000450_attempt1 (
  input  a,
  input  b,
  output o
);

  // SYNTH_5058: Operator (===) encountered. Treating as (==) for synthesis.
  // The case equality operator (===) will be treated as logical equality (==)
  // during synthesis, which can lead to different behavior than simulation
  // if 'x' or 'z' values are involved.
  assign o = (a === b);

endmodule
