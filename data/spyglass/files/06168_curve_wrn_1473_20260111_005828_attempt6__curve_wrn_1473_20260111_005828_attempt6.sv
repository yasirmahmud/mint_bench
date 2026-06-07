module curve_wrn_1473_20260111_005828_attempt6;

  // Instantiate the very_simple_sub module multiple times.
  // These instances (inst_sub_0, inst_sub_1, etc.) *do exist* in the hierarchy.
  very_simple_sub inst_sub_0 ();
  very_simple_sub inst_sub_1 ();
  very_simple_sub inst_sub_2 ();
  very_simple_sub inst_sub_3 ();

  // Each of these 'defparam' statements attempts to modify a parameter
  // (e.g., 'PARAM_X') within an existing instance. However, 'very_simple_sub'
  // does not declare any parameters. Therefore, the hierarchical reference
  // 'inst_sub_N.PARAM_X' cannot be fully resolved because the target parameter
  // does not exist within the module type.
  // This triggers exactly one WRN_1473 violation for each 'defparam' line.
  // Since the instances themselves are found, this should prevent SYNTH_5164.
  defparam inst_sub_0.PARAM_X = 10;
  defparam inst_sub_1.PARAM_Y = 20;
  defparam inst_sub_2.PARAM_Z = 30;
  defparam inst_sub_3.PARAM_W = 40;

endmodule
