// Top module instantiating CHILD_PROCESSOR
module curve_elab_3518_20260111_214138_554272_w15680_attempt13 (
  input wire system_clk,
  output wire output_data
);

  // ELAB_3518 violation: 
  // The parameter 'CLOCK_DIVISOR' (defined as integer in CHILD_PROCESSOR)
  // is overridden with a double-type value (8.88) during instantiation.
  // The instance name 'dcm_sp_inst' is used as specified by the rule description.
  CHILD_PROCESSOR #(.CLOCK_DIVISOR(8.88)) dcm_sp_inst (
    .clk_in    (system_clk),
    .proc_out  (output_data)
  );

endmodule
