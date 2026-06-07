// Instantiate sub_module. The named port connections here intentionally use names
  // 'non_existent_port_A' and 'non_existent_port_B' which do not match any ports
  // defined in 'sub_module'.
  // This setup ensures that each non-existent port reference triggers an STX_VE_282 violation.
  // Two named port connections that do not exist in the sub-module will result in two violations.
  sub_module i_sub_instance (
    .non_existent_port_A (top_data_in_0),   // Violation 1: Portname 'non_existent_port_A' not found in 'sub_module'
    .non_existent_port_B (top_data_out_0)   // Violation 2: Portname 'non_existent_port_B' not found in 'sub_module'
  );

endmodule
