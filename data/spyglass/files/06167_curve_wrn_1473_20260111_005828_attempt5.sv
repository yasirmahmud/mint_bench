module curve_wrn_1473_20260111_005828_attempt5;

  // These defparam statements refer to instances (inst_a, inst_b, inst_c, inst_d)
  // that are never declared or instantiated within this module. Because the
  // instance itself is not found, the hierarchical reference "inst_X.P_VALUE"
  // cannot be resolved.
  // This directly triggers WRN_1473 for each statement as an "unresolved
  // hierarchial reference".
  defparam inst_a.P_VALUE = 10;
  defparam inst_b.P_VALUE = 20;
  defparam inst_c.P_VALUE = 30;
  defparam inst_d.P_VALUE = 40;

  // Add a simple declaration and initial block to ensure the top module is not empty
  // and to avoid other potential warnings about empty modules or unused signals.
  reg dummy_top_signal;
  initial begin
    dummy_top_signal = 1'b0;
  end

endmodule
