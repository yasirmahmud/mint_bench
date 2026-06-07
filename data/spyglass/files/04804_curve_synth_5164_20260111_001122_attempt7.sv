module curve_synth_5164_20260111_001122_attempt7 (
  input wire clk,
  output wire out
);

  // This module declares an instance 'u_undefined_component' of a module type
  // 'undefined_module_type'. Crucially, 'undefined_module_type' is NOT defined
  // anywhere in this file or any included files.
  //
  // The intent here is to differentiate between 'WRN_1473' (Unresolved hierarchical reference)
  // and 'SYNTH_5164' (Component not found). By declaring the instance 'u_undefined_component',
  // the tool's front-end might consider the hierarchical path 'u_undefined_component.SOME_PARAMETER'
  // as partially 'resolved' (as 'u_undefined_component' exists in the hierarchy).
  // However, during the synthesis elaboration phase, the tool will fail to find the actual
  // module definition for 'undefined_module_type', meaning it cannot find the 'component'
  // for 'u_undefined_component'. This should trigger SYNTH_5164.
  //
  // If WRN_1473 still triggers, it indicates that the tool considers a hierarchical
  // reference to a parameter of an instance with an undefined type to be 'unresolved'.
  // This attempt is distinct from previous ones by explicitly declaring the instance
  // of an *undefined module type*, rather than defparam-ing an instance that is not declared at all.
  undefined_module_type u_undefined_component ();

  // This defparam attempts to set a parameter on the declared instance 'u_undefined_component'.
  // Since 'u_undefined_component' refers to an undefined module type, its actual 'component'
  // for synthesis cannot be found, leading to SYNTH_5164.
  defparam u_undefined_component.SOME_PARAMETER = 42;

  // Minimal logic to avoid unused input/output warnings.
  reg dummy_reg;
  always @(posedge clk) begin
    dummy_reg <= 1'b0;
  end
  assign out = dummy_reg;

endmodule
