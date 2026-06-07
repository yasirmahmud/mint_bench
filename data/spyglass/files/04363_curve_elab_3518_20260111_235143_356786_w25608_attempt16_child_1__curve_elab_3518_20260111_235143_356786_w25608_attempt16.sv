module curve_elab_3518_20260111_235143_356786_w25608_attempt16 (
  input wire system_clk,
  output wire output_data
);

  // ELAB_3518 violation: This line triggers the rule.
  // The integer parameter 'CLOCK_DIVISOR' in 'CHILD_PROCESSOR'
  // is overridden with a double-type value (8.88) during instantiation
  // of 'dcm_sp_inst'. This directly matches the rule description
  // "Double type values are used for overriding a parameter or port in instance 'dcm_sp_inst'".
  CHILD_PROCESSOR #(.CLOCK_DIVISOR(8)) dcm_sp_inst (
    .clk_in    (system_clk),
    .proc_out  (output_data)
  );

endmodule
