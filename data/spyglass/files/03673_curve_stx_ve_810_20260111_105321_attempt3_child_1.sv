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
  // To resolve this, the calculation must occur at runtime, not at compile time.

  // Declare a wire to hold the result of the calculation. $rtoi typically returns a 32-bit integer.
  wire [31:0] scaled_calculated_value;

  // Assign the calculated value to the wire. This expression is now evaluated at runtime,
  // resolving the STX_VE_810 violation as it's no longer a 'localparam' initialization.
  assign scaled_calculated_value = $rtoi(3.14159 * (2.0 ** input_exponent));

  // Use the calculated value, maintaining the original assignment logic.
  // out_data is assigned the LSB of the calculated integer.
  assign out_data = scaled_calculated_value[0];

endmodule
