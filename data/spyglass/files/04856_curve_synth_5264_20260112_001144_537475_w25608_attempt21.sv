module curve_synth_5264_20260112_001144_537475_w25608_attempt21 (
  input real input_real_port
);
  // Rule SYNTH_5264 (Net type 'REAL' is not supported) is expected to be triggered
  // due to the 'real' type used for the port. No internal logic is added to
  // avoid triggering other synthesis or linting rules (e.g., unused signals, latches).
  // Note: SYNTH_5264 often leads to a secondary ErrorAnalyzeBBox due to unsynthesizable design.
endmodule
