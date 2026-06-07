module top_level_design (
  input top_in_1,
  input top_in_2,
  output top_out_1,
  output top_out_2
);

  // Instance of my_sub_module with two non-existent port connections
  my_sub_module u_instance (
    .sub_in_a(top_in_1),         // Valid connection
    .sub_out_b(top_out_1),       // Valid connection
    .non_existent_port_in(top_in_2),  // STX_VE_282 violation 1: 'non_existent_port_in' is not a port of 'my_sub_module'
    .non_existent_port_out(top_out_2) // STX_VE_282 violation 2: 'non_existent_port_out' is not a port of 'my_sub_module'
  );

endmodule
