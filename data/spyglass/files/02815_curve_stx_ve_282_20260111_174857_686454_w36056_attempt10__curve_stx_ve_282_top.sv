module curve_stx_ve_282_top (
  input wire top_in_a,
  input wire top_in_b,
  output wire top_out_a,
  output wire top_out_b
);

  // Instantiate sub_module_a.
  // The named port 'non_existent_input_port' is used here,
  // but it does not exist in the definition of 'sub_module_a'.
  // 'sub_module_a' expects 'sub_a_input'. This causes the first STX_VE_282 violation.
  sub_module_a i_sub_a (
    .non_existent_input_port(top_in_a), // Mismatched port name (input)
    .sub_a_output(top_out_a)
  );

  // Instantiate sub_module_b.
  // The named port 'non_existent_output_port' is used here,
  // but it does not exist in the definition of 'sub_module_b'.
  // 'sub_module_b' expects 'sub_b_output'. This causes the second STX_VE_282 violation.
  sub_module_b i_sub_b (
    .sub_b_input(top_in_b),
    .non_existent_output_port(top_out_b) // Mismatched port name (output)
  );

endmodule
