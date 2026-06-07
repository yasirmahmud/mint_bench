module curve_synth_5058_20260111_000450_attempt2 (
  input  a,
  output o
);

  // SYNTH_5058: Operator (===) encountered. Treating as (==) for synthesis.
  // In simulation, (a === a) always evaluates to 1'b1, even if 'a' is 'x' or 'z'.
  // In synthesis, if '===' is treated as '==', then (a == a) evaluates to 'x'
  // if 'a' is 'x' or 'z', leading to different behavior than simulation.
  // Replaced (a === a) with 1'b1 to preserve the always-true behavior and resolve SYNTH_5058 and W339a.
  assign o = 1'b1;

endmodule
