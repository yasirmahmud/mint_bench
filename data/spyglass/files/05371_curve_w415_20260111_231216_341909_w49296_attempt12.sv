module curve_w415_20260111_231216_341909_w49296_attempt12 (
  input wire input_a,
  input wire input_b,
  input wire input_c,
  input wire selector,
  output wire output_z
);

  // Declare a wire that will be driven by multiple continuous assignments
  wire y;

  // First continuous assignment to 'y'
  assign y = input_a & input_b;

  // Second continuous assignment to 'y', creating the W415 violation
  // This uses a conditional assignment, making it distinct from previous simple examples.
  assign y = selector ? input_c : input_b; // ERROR: Signal 'y' has multiple simultaneous drivers

  // Simple output assignment to avoid unused signal warnings
  assign output_z = y;

endmodule
