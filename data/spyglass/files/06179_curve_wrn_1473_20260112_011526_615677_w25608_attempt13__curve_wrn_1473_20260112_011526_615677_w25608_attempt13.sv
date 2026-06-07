// This is the top-level module, named according to the filename requirement.
// It instantiates 'sub_component' and attempts to use defparam
// on a non-existent parameter within the instance.
module curve_wrn_1473_20260112_011526_615677_w25608_attempt13 (
  input wire top_in,
  output wire top_out
);

  // Instantiate the sub-component.
  sub_component sub_inst_a (
    .s_in(top_in),
    .s_out(top_out)
  );

  // WRN_1473 violation: The hierarchical reference 'sub_inst_a.UNDEFINED_CONFIG_VALUE'
  // cannot be resolved because 'UNDEFINED_CONFIG_VALUE' is not a parameter
  // within the 'sub_component' module. This line will trigger exactly one WRN_1473 violation.
  defparam sub_inst_a.UNDEFINED_CONFIG_VALUE = 8'hA5;

endmodule
