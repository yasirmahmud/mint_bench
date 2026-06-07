module curve_stx_ve_810_20260111_193749_882554_w47100_attempt6 (
  input [7:0] a,
  output [7:0] b
);

  // Declare a real variable. This can hold non-constant values.
  real r_input_scaled;
  
  // Assign a value to the real variable that depends on the module input 'a'.
  // Since 'a' is an input, its value is not constant at elaboration time.
  // Thus, 'r_input_scaled' becomes a non-constant expression.
  assign r_input_scaled = $itor(a) * 0.5; 

  // Attempt to define a localparam using the $rtoi system function
  // with 'r_input_scaled' as its argument. Since 'r_input_scaled'
  // is a non-constant expression, this will trigger STX_VE_810,
  // as localparam definitions require constant expressions.
  localparam integer SCALED_INT_VAL = $rtoi(r_input_scaled);

  // Use the output and localparam to avoid unused warnings.
  assign b = a + SCALED_INT_VAL;

endmodule
