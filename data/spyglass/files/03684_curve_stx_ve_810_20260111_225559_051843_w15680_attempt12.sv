module curve_stx_ve_810_20260111_225559_051843_w15680_attempt12 (
  input wire [3:0] gp_gain_width, // Input for the non-constant real expression
  input wire [7:0] data_in,
  output wire [7:0] data_out
);

  // Declare a real variable. Its value will depend on 'gp_gain_width',
  // which is an input and thus non-constant at elaboration time.
  // This makes 'non_constant_expression_arg' a non-constant real value.
  real non_constant_expression_arg;
  assign non_constant_expression_arg = 0.607252959138945 * (2.0 ** ($itor(gp_gain_width) - 1.0));

  // STX_VE_810 violation: A 'parameter' requires its initializer to be a
  // constant expression. However, 'non_constant_expression_arg' (derived from
  // 'gp_gain_width') makes the argument to $rtoi non-constant.
  parameter integer SCALED_PARAM = $rtoi(non_constant_expression_arg); // Violation occurs here

  // Use the parameter to avoid unused signal warnings and ensure connectivity.
  assign data_out = data_in + SCALED_PARAM;

endmodule
