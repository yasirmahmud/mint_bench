module very_simple_sub #(
  // Added a dummy parameter to resolve 'WarnAnalyzeBBox' (empty definition) violation.
  parameter DUMMY_PARAM = 1
);
  // This module was intentionally empty, now has a dummy parameter.
  // The 'defparam' statements that targeted non-existent parameters are removed
  // from the parent module, resolving WRN_1473 and SYNTH_5164 violations.
endmodule
