module curve_elab_3518_20260111_235143_356786_w25608_attempt17 (
  input wire system_clk,
  output wire divided_output
);

  // ELAB_3518 violation: This line triggers the rule.
  // The integer parameter 'DIVISOR' in 'FREQUENCY_ADJUSTER'
  // is overridden with a double-type value (7.5) during instantiation
  // of 'dcm_sp_inst'. This directly matches the rule description
  // "Double type values are used for overriding a parameter or port in instance 'dcm_sp_inst'".
  FREQUENCY_ADJUSTER #(.DIVISOR(7.5)) dcm_sp_inst (
    .clk_in    (system_clk),
    .out_pulse (divided_output)
  );

endmodule
