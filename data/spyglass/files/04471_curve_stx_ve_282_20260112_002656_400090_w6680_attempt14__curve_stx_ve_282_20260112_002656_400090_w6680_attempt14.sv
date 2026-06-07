module curve_stx_ve_282_20260112_002656_400090_w6680_attempt14 (
  input  [7:0] top_in_a,
  input  [7:0] top_in_b,
  output [7:0] top_out_a,
  output [7:0] top_out_b
);

  // This instance triggers two STX_VE_282 violations as requested by the summary (2 occurrences).
  // The named ports 'non_existent_port_X' and 'non_existent_port_Y'
  // do not exist in the 'my_sub_module' definition.
  my_sub_module i_sub_instance (
    .existing_in_a       (top_in_a),         // Valid connection to an existing port
    .non_existent_port_X (top_in_b),         // Violation 1: Portname 'non_existent_port_X' not found in 'my_sub_module'
    .existing_in_b       (top_in_b),         // Valid connection to an existing port
    .non_existent_port_Y (top_out_b),        // Violation 2: Portname 'non_existent_port_Y' not found in 'my_sub_module'
    .existing_out_a      (top_out_a)         // Valid connection to an existing port
  );

endmodule
