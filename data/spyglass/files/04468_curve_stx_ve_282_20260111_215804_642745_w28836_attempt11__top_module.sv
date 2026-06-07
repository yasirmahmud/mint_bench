module top_module (
  input wire top_input_a,
  input wire top_input_b,
  output wire top_output_a,
  output wire top_output_b
);

  // Define a simple sub-module locally within top_module
  // This sub_module has 's_in' and 's_out' as its only actual ports.
