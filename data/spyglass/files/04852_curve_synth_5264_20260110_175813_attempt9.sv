module curve_synth_5264_20260110_175813_attempt9 (
  input real data_float_in
);
  // The 'real' data type is not supported for synthesis at the port interface.
  // This declaration is the direct cause of the SYNTH_5264 violation.
  // The port 'data_float_in' is intentionally left unused, as any attempt
  // to connect or convert a 'real' port to synthesizable logic would either
  // introduce further non-synthesizable constructs or trigger additional
  // rule violations related to type mismatches or unsupported operations.
  // Leaving it unused is considered implicitly 'required' by the target rule
  // to maintain a minimal example focused solely on SYNTH_5264.

endmodule
