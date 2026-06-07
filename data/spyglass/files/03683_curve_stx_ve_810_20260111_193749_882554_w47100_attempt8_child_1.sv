module curve_stx_ve_810_20260111_193749_882554_w47100_attempt8 (
  input [7:0] data_in,
  output [7:0] data_out
);

  // Declare a real variable. Its value will depend on a module input,
  // making it a non-constant expression at elaboration time.
  real non_constant_real;

  // Assign a value to the real variable based on 'data_in'.
  // Since 'data_in' is a module input, its value is not known at elaboration,
  // thus 'non_constant_real' is a non-constant expression.
  assign non_constant_real = $itor(data_in) / 2.0;

  // The condition of a generate-if statement must be a constant expression
  // that can be evaluated during elaboration.
  // To resolve STX_VE_810, the conditional logic must be moved out of the
  // generate block, as the condition involves a non-constant expression.
  // This can be achieved using a continuous assignment with a conditional operator.
  assign data_out = ($rtoi(non_constant_real) > 10) ? (data_in + 1) : (data_in - 1);

endmodule
