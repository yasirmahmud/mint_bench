module UNDEFINED_MODULE_TYPE (
  // Add dummy ports to make the definition non-empty for SpyGlass.
  // No functional ports are used by my_black_box_inst in the parent module.
  input dummy_in,
  output dummy_out
);
  // Define the parameter that is being set by 'defparam' in the parent module.
  // This makes the parameter resolvable and avoids related errors/warnings.
  parameter SYNTH_PARAM = 1; // Provide a default value for the parameter.
endmodule
