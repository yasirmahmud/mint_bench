module curve_wrn_1473_20260111_005828_attempt3;
  // Instantiate the sub-module multiple times.
  // The instances exist, but the parameters being targeted by defparam do not exist within sub_module.
  sub_module sub_inst_a ();
  sub_module sub_inst_b ();
  sub_module sub_inst_c ();
  sub_module sub_inst_d ();

  // These defparam statements target parameters that do not exist in 'sub_module'.
  // This is expected to trigger WRN_1473 for each statement,
  // as the hierarchical reference to the parameter is unresolved,
  // even though the instance itself is resolved.
  defparam sub_inst_a.UNDEFINED_PARAM1 = 1'b0;
  defparam sub_inst_b.UNDEFINED_PARAM2 = 1'b1;
  defparam sub_inst_c.UNDEFINED_PARAM3 = 2'd2;
  defparam sub_inst_d.UNDEFINED_PARAM4 = 3'd3;

endmodule
