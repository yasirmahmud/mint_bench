// Top module instantiating CONFIG_BLOCK
module curve_elab_3518_20260111_214138_554272_w15680_attempt12 (
  input wire sys_clk,
  output wire module_busy
);

  // ELAB_3518 violation: 
  // The parameter 'CONFIG_VALUE' (defined as integer in CONFIG_BLOCK)
  // is overridden with a double-type value (12.34) during instantiation.
  // The instance name 'dcm_sp_inst' is used as specified by the rule description.
  CONFIG_BLOCK #(.CONFIG_VALUE(12.34)) dcm_sp_inst (
    .clk      (sys_clk),
    .busy_out (module_busy)
  );

endmodule
