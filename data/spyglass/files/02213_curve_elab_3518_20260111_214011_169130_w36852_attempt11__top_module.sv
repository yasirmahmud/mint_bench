module top_module (
  input clk,
  output out
);
  wire internal_wire;

  // ELAB_3518: This instantiation triggers the violation.
  // A double-type value (4.2) is used to override the integer parameter PARAM_VAL
  // in the instance named 'dcm_sp_inst', as specified by the rule.
  SUB_MOD #(.PARAM_VAL(4.2)) dcm_sp_inst (
    .in_port(clk),
    .out_port(internal_wire)
  );
  
  // Connect the output to avoid unused signal warnings
  assign out = internal_wire;

endmodule
