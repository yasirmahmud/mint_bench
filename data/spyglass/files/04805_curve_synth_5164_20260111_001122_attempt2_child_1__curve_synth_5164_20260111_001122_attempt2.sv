module curve_synth_5164_20260111_001122_attempt2 ();

  // Instantiate a module type that is not defined in this scope or any included file.
  // This makes 'sub_inst' an existing instance, but its 'component' (module definition)
  // is not found by the synthesis tool, leading to SYNTH_5164.
  undefined_module_type sub_inst ();

  // Apply a defparam to this instance.
  defparam sub_inst.MY_PARAM = 5;

endmodule
