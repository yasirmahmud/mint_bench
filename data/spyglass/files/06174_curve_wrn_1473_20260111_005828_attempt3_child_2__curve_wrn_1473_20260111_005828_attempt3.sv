module curve_wrn_1473_20260111_005828_attempt3;
  // Instantiate the sub-module multiple times.
  sub_module sub_inst_a ();
  sub_module sub_inst_b ();
  sub_module sub_inst_c ();
  sub_module sub_inst_d ();

  // The original defparam statements targeted parameters that did not exist in 'sub_module'.
  // These statements caused WRN_1473 and SYNTH_5164 violations.
  // To resolve these violations, the defparam statements have been removed.
  // Since 'sub_module' had no parameters, these defparam statements did not affect functional behavior.

endmodule
