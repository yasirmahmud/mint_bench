module curve_stx_ve_690_20260110_151207_attempt1 (
  input wire sys_clk,
  input wire data_in,
  output wire data_out
);

  wire intermediate_signal;

  // Instantiating child_module with an extra connection.
  // '.non_existent_port' does not exist in 'child_module's definition,
  // triggering the STX_VE_690 violation.
  child_module u_child (
    .in_a(data_in),
    .out_b(intermediate_signal),
    .non_existent_port(sys_clk) 
  );

  // Use all signals to avoid other warnings
  assign data_out = intermediate_signal;

endmodule
