module curve_stx_ve_282_20260112_002656_400090_w6680_attempt16 (
  input  wire top_input_A,
  input  wire top_input_B,
  output wire top_output_A,
  output wire top_output_B,
  input  wire dummy_input_for_violation // Used to connect to non-existent ports
);

  // Instantiate sub_module for the first time
  // This instance will trigger the first STX_VE_282 violation due to '.non_existent_port_1'
  sub_module i_sub_instance_0 (
    .sub_data_in       (top_input_A),      // Connects to an existing port
    .sub_data_out      (top_output_A),     // Connects to an existing port
    .non_existent_port_1 (dummy_input_for_violation) // Violation 1: Portname 'non_existent_port_1' not found in 'sub_module'
  );

  // Instantiate sub_module for the second time
  // This instance will trigger the second STX_VE_282 violation due to '.non_existent_port_2'
  sub_module i_sub_instance_1 (
    .sub_data_in       (top_input_B),      // Connects to an existing port
    .sub_data_out      (top_output_B),     // Connects to an existing port
    .non_existent_port_2 (dummy_input_for_violation) // Violation 2: Portname 'non_existent_port_2' not found in 'sub_module'
  );

  // All top-level ports are used either directly by existing sub_module ports or
  // by the crafted non-existent port connections to prevent other linting violations.

endmodule
