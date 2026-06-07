module curve_wrn_1473_20260111_005828_attempt6;

  // Instantiate the very_simple_sub module multiple times.
  very_simple_sub inst_sub_0 ();
  very_simple_sub inst_sub_1 ();
  very_simple_sub inst_sub_2 ();
  very_simple_sub inst_sub_3 ();

  // The original 'defparam' statements have been removed.
  // They previously attempted to modify non-existent parameters within
  // instances of 'very_simple_sub', leading to WRN_1473 and SYNTH_5164 violations.
  // Removing these statements resolves those violations while preserving the
  // functional behavior, as the original defparams had no actual effect due
  // to the absence of the targeted parameters.

endmodule
