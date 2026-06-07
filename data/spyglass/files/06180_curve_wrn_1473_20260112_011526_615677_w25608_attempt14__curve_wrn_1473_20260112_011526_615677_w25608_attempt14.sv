// This is the top-level module, named according to the filename requirement.
// It instantiates 'my_sub_module' and attempts to use defparam
// on a non-existent intermediate hierarchical level within the instance.
module curve_wrn_1473_20260112_011526_615677_w25608_attempt14 (
  input wire top_clk,
  output wire top_data_out
);

  // Instantiate the sub-component.
  my_sub_module u_sub_instance (
    .sub_in(top_clk),
    .sub_out(top_data_out)
  );

  // WRN_1473 violation: The hierarchical references cannot be resolved.
  // In each case, 'non_existent_child_X' is not an instantiated module
  // within 'my_sub_module', making the entire defparam path invalid.
  // This structure targets a non-existent *intermediate instance* in the path,
  // which is distinct from simply targeting a non-existent parameter directly.
  // This creates exactly four occurrences of the target violation.
  defparam u_sub_instance.non_existent_child_0.CONFIG_SETTING_A = 8'hA5;   // Violation 1
  defparam u_sub_instance.non_existent_child_1.DELAY_VALUE_B = 16'd100;    // Violation 2
  defparam u_sub_instance.non_existent_child_2.MODE_SELECTION_C = 2'b01;  // Violation 3
  defparam u_sub_instance.non_existent_child_3.FEATURE_ENABLE_D = 1'b1;  // Violation 4

endmodule
