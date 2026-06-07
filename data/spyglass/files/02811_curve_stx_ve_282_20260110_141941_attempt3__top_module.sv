module top_module (
  input top_data_in_a,
  input top_data_in_b,
  output top_data_out_a,
  output top_data_out_b
);

  // Instance 1: Triggers STX_VE_282 for 'non_existent_input'
  // The module 'sub_module' does not have a port named 'non_existent_input'.
  sub_module i_sub_0 (
    .non_existent_input(top_data_in_a), // Violation STX_VE_282 occurs here
    .sub_out_b(top_data_out_a)
  );

  // Instance 2: Triggers STX_VE_282 for 'unknown_output_port'
  // The module 'sub_module' does not have a port named 'unknown_output_port'.
  sub_module i_sub_1 (
    .sub_in_a(top_data_in_b),
    .unknown_output_port(top_data_out_b) // Violation STX_VE_282 occurs here
  );

endmodule
