module top_module (
  input wire clk,
  input wire reset,
  input wire data_in_a,
  input wire data_in_b,
  output wire result_out
);

  wire internal_c;
  wire extra_conn_sig_1;
  wire extra_conn_sig_2;

  // Dummy logic to use the signals connected to the non-existent ports,
  // preventing unused signal warnings.
  assign extra_conn_sig_1 = data_in_a & data_in_b;
  assign extra_conn_sig_2 = ~data_in_a | ~data_in_b;

  // Instantiate child_module with two extra port connections:
  // .non_existent_port_x and .non_existent_port_y.
  // These ports do not exist in the 'child_module' definition,
  // thus triggering two STX_VE_690 violations as required.
  child_module u_child_instance (
    .in_a                (data_in_a),
    .in_b                (data_in_b),
    .out_c               (internal_c),
    .non_existent_port_x (extra_conn_sig_1), // First extra connection
    .non_existent_port_y (extra_conn_sig_2)  // Second extra connection
  );

  // Simple logic to use the output of the instance, preventing unused signal warnings.
  assign result_out = internal_c;

endmodule
