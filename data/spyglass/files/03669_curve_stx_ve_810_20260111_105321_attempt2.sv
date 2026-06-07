module curve_stx_ve_810_20260111_105321_attempt2(
  input [7:0] data_width_input, // A non-constant input
  output wire out_signal
);

  // SpyGlass STX_VE_810 rule triggers when a non-constant expression
  // is used where a constant expression is required.
  // A 'localparam' requires its initialization expression to be constant.
  // Here, 'data_width_input' is an input, thus it is a non-constant value.
  // The expression '1.0 * (data_width_input - 1)' is therefore non-constant,
  // and $rtoi of a non-constant expression is also non-constant.

  localparam integer SCALED_VALUE = $rtoi(1.0 * (data_width_input - 1)); // STX_VE_810 violation

  // Use SCALED_VALUE to avoid unused signal warnings
  assign out_signal = SCALED_VALUE[0];

endmodule
