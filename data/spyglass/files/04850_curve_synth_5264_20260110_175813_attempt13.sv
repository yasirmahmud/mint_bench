module curve_synth_5264_20260110_175813_attempt13 (
  input real unsynthesizable_port
);
  // Rule SYNTH_5264 (Net type 'REAL' is not supported) is expected to be triggered
  // by the declaration of 'input real unsynthesizable_port'.
  // 'real' data type is not synthesizable and is therefore not supported for module ports.
  // This example is distinct from previous attempts by using only a single 'input real' port
  // and no internal logic or assignments, aiming to isolate the SYNTH_5264 violation
  // and potentially avoid other secondary errors like ErrorAnalyzeBBox, which might be triggered
  // by internal usage of real types or assignments to real ports.

endmodule
