module curve_stx_ve_810_20260111_105321_attempt3(
  input [3:0] input_exponent, // A non-constant input for the exponent
  output wire out_data
);

  // SpyGlass STX_VE_810 rule triggers when a non-constant expression
  // is used where a constant expression is required.
  // 'localparam' requires its initialization expression to be constant.
  // Here, 'input_exponent' is an input, thus it is a non-constant value.
  // The expression '3.14159 * (2.0 ** input_exponent)' is therefore non-constant,
  // and $rtoi of a non-constant expression is also non-constant.

  localparam integer SCALED_CONST = $rtoi(3.14159 * (2.0 ** input_exponent)); // STX_VE_810 violation

  // Use SCALED_CONST to avoid unused signal warnings
  assign out_data = SCALED_CONST[0];

endmodule
