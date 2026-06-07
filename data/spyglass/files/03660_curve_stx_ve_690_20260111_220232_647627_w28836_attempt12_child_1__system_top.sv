// Top module instantiating basic_processor with extra connections
module system_top (
  input wire sys_clk,
  input wire sys_reset,
  input wire [7:0] system_data_in,
  output wire [7:0] system_data_out
);

  wire [7:0] internal_data_bus;
  // Removed dummy_signal_a and dummy_signal_b as they are no longer connected
  // to the basic_processor instance and would become unused.

  // This instantiation previously triggered STX_VE_690 violations.
  // The extra connections '.extra_control_signal' and '.debug_register'
  // have been removed to resolve the linting violations.
  basic_processor u_processor (
    .clk        (sys_clk),
    .reset      (sys_reset),
    .data_in    (system_data_in),
    .data_out   (internal_data_bus)
  );

  assign system_data_out = internal_data_bus;
  // Removed assignments to dummy_signal_a and dummy_signal_b
  // as the signals themselves are no longer needed after removing the extra port connections.

endmodule
