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

  // STX_VE_810 violation fix: A 'parameter' must be initialized with a
  // constant expression. Since 'non_constant_expression_arg' is derived from
  // an input, it is non-constant. To preserve functional behavior, we must
  // make this a dynamic calculation using a 'wire' or 'logic' rather than a 'parameter'.
  // We declare 'scaled_value' as an integer wire and assign the result of $rtoi to it.
  integer scaled_value; // Use 'integer' type to match the behavior of $rtoi returning an integer.
  assign scaled_value = $rtoi(non_constant_expression_arg);

  // Use the dynamically calculated value in the output assignment.
  assign data_out = data_in + scaled_value;

endmodule
