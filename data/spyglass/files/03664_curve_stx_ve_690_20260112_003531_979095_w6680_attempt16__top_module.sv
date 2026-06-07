module top_module (
  input wire sys_clk,
  input wire sys_rst,
  input wire [7:0] sys_data_in_a,
  input wire [7:0] sys_data_in_b,
  output wire [7:0] sys_data_out_a,
  output wire [7:0] sys_data_out_b
);

  wire [7:0] internal_data_a;
  wire [7:0] internal_data_b;
  wire       extra_signal_a; // Signal to be connected to a non-existent port on instance A
  wire       extra_signal_b; // Signal to be connected to a non-existent port on instance B

  // Dummy logic to use the signals that will be connected to non-existent ports,
  // preventing unused signal warnings (STX_USP).
  assign extra_signal_a = sys_clk ^ sys_rst;
  assign extra_signal_b = sys_data_in_a[0] | sys_data_in_b[0];

  // Instantiate simple_module with an extra, non-existent port connection.
  // The port '.undefined_port_1' does not exist in 'simple_module'.
  // This will trigger one STX_VE_690 violation.
  simple_module u_instance_a (
    .clk              (sys_clk),
    .rst              (sys_rst),
    .data_in          (sys_data_in_a),
    .data_out         (internal_data_a),
    .undefined_port_1 (extra_signal_a)
  );

  // Instantiate simple_module again with a different extra, non-existent port connection.
  // The port '.undefined_port_2' does not exist in 'simple_module'.
  // This will trigger a second STX_VE_690 violation.
  // Two distinct instances with extra connections are needed to satisfy "Total occurrences (from summary): 2".
  simple_module u_instance_b (
    .clk              (sys_clk),
    .rst              (sys_rst),
    .data_in          (sys_data_in_b),
    .data_out         (internal_data_b),
    .undefined_port_2 (extra_signal_b)
  );

  // Use the outputs of the instantiated modules to prevent unused signal warnings.
  assign sys_data_out_a = internal_data_a;
  assign sys_data_out_b = internal_data_b;

endmodule
