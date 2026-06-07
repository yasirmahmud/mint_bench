module UNDEFINED_MODULE_TYPE (
  // No ports are used by my_black_box_inst in the parent module.
  // This module is kept empty to function as a placeholder for a black box.
);
  // Define the parameter that is being set by 'defparam' in the parent module.
  // This makes the parameter resolvable and avoids related errors/warnings.
  parameter SYNTH_PARAM = 1; // Provide a default value for the parameter.
endmodule
