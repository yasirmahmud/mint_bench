module curve_wrn_63_20260111_181258_824244_w47100_attempt9 (
  input [7:0] in_a,
  input [7:0] in_b,
  output [7:0] out_a,
  output [7:0] out_b
);

  // First instance of WRN_63: Division by zero using a constant literal.
  // Input 'in_a' is used, preventing W240 for 'in_a'.
  assign out_a = in_a / 8'd0;

  // Second instance of WRN_63: Division by zero using a constant expression
  // that evaluates to zero at compile/elaboration time (8'd5 - 8'd5 = 8'd0).
  // Input 'in_b' is used, preventing W240 for 'in_b'.
  assign out_b = in_b / (8'd5 - 8'd5);

endmodule
