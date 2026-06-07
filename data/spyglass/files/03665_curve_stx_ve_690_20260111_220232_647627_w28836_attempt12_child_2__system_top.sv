// Top module instantiating basic_processor with extra connections
module system_top (
  input wire sys_clk,
  input wire sys_reset,
  input wire [7:0] system_data_in,
  output wire [7:0] system_data_out
);

  wire [7:0] internal_data_bus;

  // This instantiation previously triggered STX_VE_690 violations.
  // The extra connections '.extra_control_signal' and '.debug_register'
  // have been removed to resolve the linting violations.
  // Inputs 'clk' and 'reset' were removed from basic_processor's interface
  // and instantiation as they were declared but not read (W240 violations),
  // and are not required for the module's combinational functionality.
  basic_processor u_processor (
    .data_in    (system_data_in),
    .data_out   (internal_data_bus)
  );

  assign system_data_out = internal_data_bus;

endmodule
