// First instance of sub_module
  // This instantiation explicitly attempts to connect to a port named
  // 'non_existent_input_port' which is not defined in 'sub_module'.
  // This will trigger the first STX_VE_282 violation.
  sub_module i_sub_0 (
    .s_in                    (top_input_a),         // Valid connection to an existing port
    .s_out                   (top_output_a),        // Valid connection to an existing port
    .non_existent_input_port (top_input_b)          // STX_VE_282 violation 1: Port 'non_existent_input_port' not found
  );

  // Second instance of sub_module
  // This instantiation explicitly attempts to connect to a port named
  // 'non_existent_output_port' which is not defined in 'sub_module'.
  // This will trigger the second STX_VE_282 violation.
  sub_module i_sub_1 (
    .s_in                    (top_input_b),         // Valid connection to an existing port
    .s_out                   (top_output_b),        // Valid connection to an existing port
    .non_existent_output_port(top_output_a)         // STX_VE_282 violation 2: Port 'non_existent_output_port' not found
  );

endmodule
