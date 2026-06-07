module curve_w287b_20260111_194449_406742_w53504_attempt8 (
  input  input_a,
  input  input_b,
  output output_sum
);

  // Declare a dummy wire for the unused carry_out port to resolve W287b violation
  wire carry_out_unused;

  // Instantiate sub-module
  math_unit u_adder (
    .a         (input_a),
    .b         (input_b),
    .sum_out   (output_sum),
    .carry_out (carry_out_unused) // W287b violation fixed: connected to a dummy wire
  );

endmodule
