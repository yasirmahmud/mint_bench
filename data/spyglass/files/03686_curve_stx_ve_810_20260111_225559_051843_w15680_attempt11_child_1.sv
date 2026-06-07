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

  // STX_VE_810 violation fix:
  // A 'localparam' requires its initializer to be a constant expression.
  // Since 'non_constant_power_term' is derived from an input 'gain_width_in',
  // the expression for SCALED_OFFSET is non-constant.
  // To preserve functional behavior (i.e., dynamic calculation of SCALED_OFFSET),
  // we convert it from a 'localparam' to a reg-type 'integer' variable
  // and assign its value combinatorially using an always @* block.
  integer SCALED_OFFSET; // Declared as a reg-type integer variable

  always @* begin
    SCALED_OFFSET = $rtoi(0.607252959138945 * non_constant_power_term);
  end

  // Use SCALED_OFFSET in the assignment
  assign data_out = data_in + SCALED_OFFSET;

endmodule
