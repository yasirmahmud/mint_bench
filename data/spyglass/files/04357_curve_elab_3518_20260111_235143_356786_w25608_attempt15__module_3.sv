// ELAB_3518 violation: The integer parameter 'INITIAL_VALUE'
  // is overridden with a double-type value (5.5) during instantiation
  // of 'dcm_sp_inst'. This directly triggers the ELAB_3518 rule.
  SIMPLE_BLOCK #(.INITIAL_VALUE(5.5)) dcm_sp_inst (
    .in_val  (data_in),
    .out_val (data_out)
  );

endmodule
