module top_module (
  input top_input_val,
  output [1:0] top_output_val
);

  // Instance 1: This connection will trigger STX_VE_282 for port 'data_in'
  // The module 'my_sub_module' does not have a port named 'data_in', it has 'input_a'.
  my_sub_module i_sub_0 (
    .data_in(top_input_val), // Violates STX_VE_282
    .output_b(top_output_val[0])
  );

  // Instance 2: This connection will also trigger STX_VE_282 for port 'data_in'
  // The module 'my_sub_module' does not have a port named 'data_in', it has 'input_a'.
  my_sub_module i_sub_1 (
    .data_in(top_input_val), // Violates STX_VE_282
    .output_b(top_output_val[1])
  );

endmodule
