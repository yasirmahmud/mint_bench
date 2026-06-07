module curve_synth_5058_20260111_000450_attempt3 (
  input  [1:0] a,
  output wire o
);

  // SYNTH_5058: Operator (===) encountered. Treating as (==) for synthesis.
  // This example demonstrates a behavioral difference when '===' is treated as '=='
  // if the input 'a' contains 'z' or 'x' values.
  // For instance, if 'a' is 2'b1z:
  //   - Simulation with '===': (2'b1z === 2'b1z) evaluates to 1'b1.
  //   - Synthesis with '==': (2'b1z == 2'b1z) evaluates to 1'bx
  //     (as 'z' is neither '0' nor '1', resulting in an unknown state).
  // This difference (1'b1 vs 1'bx) triggers the SYNTH_5058 warning.
  // This specific pattern, comparing a multi-bit input to a constant containing 'z',
  // is distinct and aims to satisfy the constraint of triggering only SYNTH_5058.
  assign o = (a === 2'b1z);

endmodule
