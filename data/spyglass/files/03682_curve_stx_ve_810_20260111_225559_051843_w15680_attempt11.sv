module curve_stx_ve_810_20260111_225559_051843_w15680_attempt11 (
  input wire [3:0] gain_width_in, // Used to create a non-constant exponent
  input wire [7:0] data_in,
  output wire [7:0] data_out
);

  // Declare a real variable. Its value will depend on 'gain_width_in',
  // which is an input and thus non-constant at elaboration time.
  // This makes 'non_constant_power_term' a non-constant expression.
  real non_constant_power_term;
  assign non_constant_power_term = 2.0 ** ($itor(gain_width_in) - 1.0);

  // STX_VE_810 violation: A 'localparam' requires its initializer to be a
  // constant expression. However, 'non_constant_power_term' (derived from
  // 'gain_width_in') makes the argument to $rtoi non-constant.
  localparam integer SCALED_OFFSET = $rtoi(0.607252959138945 * non_constant_power_term);

  // Use the localparam to avoid unused signal warnings
  assign data_out = data_in + SCALED_OFFSET;

endmodule
