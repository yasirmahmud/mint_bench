module curve_wrn_1473_20260111_005828_attempt1;

  // These defparam statements target non-existent module instances.
  // SpyGlass will report WRN_1473 for each of these because the
  // hierarchical references (sub_inst_a, sub_inst_b, sub_inst_c, sub_inst_d)
  // cannot be resolved, leading to 4 occurrences of WRN_1473.
  defparam sub_inst_a.PARAM_A = 1;
  defparam sub_inst_b.PARAM_B = 2;
  defparam sub_inst_c.PARAM_C = 3;
  defparam sub_inst_d.PARAM_D = 4;

  // Minimal logic to ensure the module is not empty and to avoid other potential linting warnings.
  wire dummy_signal;
  assign dummy_signal = 1'b0;

endmodule
