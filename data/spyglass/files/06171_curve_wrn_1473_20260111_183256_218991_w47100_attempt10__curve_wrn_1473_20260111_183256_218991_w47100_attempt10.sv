module curve_wrn_1473_20260111_183256_218991_w47100_attempt10 (
  input wire clk,
  output wire result
);

  // Instantiate the sub_module. The instance 'u_sub_inst' is fully resolvable.
  sub_module u_sub_inst (
    .in_a  (clk),
    .out_b (result)
  );

  // This defparam attempts to set a parameter 'UNDEFINED_PARAM' on 'u_sub_inst'.
  // However, 'UNDEFINED_PARAM' is not declared or defined within 'sub_module'.
  // As a result, the hierarchical reference 'u_sub_inst.UNDEFINED_PARAM' cannot be resolved,
  // directly triggering the WRN_1473 violation.
  defparam u_sub_inst.UNDEFINED_PARAM = 32'hFEEDFACE;

endmodule
