module curve_stx_ve_810_20260111_193749_882554_w47100_attempt9 (
  input [7:0] data_in,
  output [7:0] data_out
);

  // Declare a real variable. Its value will depend on a module input,
  // making it a non-constant expression at elaboration time.
  real dynamic_real_val;

  // Assign a value to the real variable based on 'data_in'.
  // Since 'data_in' is a module input, its value is not known at elaboration,
  // thus 'dynamic_real_val' is a non-constant expression.
  assign dynamic_real_val = $itor(data_in) * 0.5;

  // localparam declarations require their initialization values to be constant expressions.
  // The original design used a non-constant expression for CONVERTED_INT, violating STX_VE_810.
  // To resolve this, CONVERTED_INT is changed from a localparam to a dynamically assigned integer variable.
  // This allows its value to be determined at runtime based on 'data_in' while preserving the functional behavior.
  integer CONVERTED_INT;
  assign CONVERTED_INT = $rtoi(dynamic_real_val);

  // Use the integer variable to compute data_out, maintaining the original logic.
  assign data_out = data_in + CONVERTED_INT;

endmodule
