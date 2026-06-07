module curve_synth_5264_20260110_175813_attempt12 (
  output real out_value
);
  // Rule SYNTH_5264 (Net type 'REAL' is not supported) is expected to be triggered
  // by the declaration of 'output real out_value'.
  // 'real' data type is not synthesizable and is therefore not supported for module ports.
  // This example is distinct from previous attempts by using only a single 'output real' port
  // and assigning a real literal to it, avoiding input ports or complex real arithmetic
  // (like multiplication) that might trigger other unrelated violations like ErrorAnalyzeBBox.

  assign out_value = 1.0;

endmodule
