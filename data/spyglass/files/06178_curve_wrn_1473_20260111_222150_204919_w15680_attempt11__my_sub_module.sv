// Define a simple submodule without any parameters. This ensures that any defparam
// targeting a parameter within an instance of this module will be unresolved,
// thus triggering WRN_1473.
module my_sub_module ();
  // No parameters are defined here.
endmodule
