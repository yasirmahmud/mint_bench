module curve_stx_ve_690_20260110_151207_attempt2 (
  input wire clk,
  input wire data_in_primary,
  output wire data_out_final
);

  wire internal_link;

  // Instantiating child_module with an extra connection.
  // '.extra_connection_port' does not exist in 'child_module's definition,
  // triggering the STX_VE_690 violation.
  child_module u_child (
    .input_data(data_in_primary),
    .output_result(internal_link),
    .extra_connection_port(clk) // This port does not exist in child_module
  );

  // Use all signals to avoid other warnings
  assign data_out_final = internal_link;

endmodule
