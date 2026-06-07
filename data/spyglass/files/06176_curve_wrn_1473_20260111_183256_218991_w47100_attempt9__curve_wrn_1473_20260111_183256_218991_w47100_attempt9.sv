module curve_wrn_1473_20260111_183256_218991_w47100_attempt9 (
  input wire top_clk,
  output wire top_out
);

  wire child_out_internal;

  // Instantiate the child module. This instance is fully resolvable.
  child_module #(
    .KNOWN_PARAM (10) // Override KNOWN_PARAM with a default value
  ) child_inst (
    .clk      (top_clk),
    .out_data (child_out_internal)
  );

  // This defparam attempts to set a parameter 'UNDEFINED_PARAM' on 'child_inst'.
  // However, 'UNDEFINED_PARAM' is not defined in 'child_module'.
  // Therefore, the hierarchical reference 'child_inst.UNDEFINED_PARAM' is unresolved,
  // directly triggering the WRN_1473 violation.
  defparam child_inst.UNDEFINED_PARAM = 16'hABCD;

  // Connect child output to top output to prevent unused signal warnings
  assign top_out = child_out_internal;

endmodule
