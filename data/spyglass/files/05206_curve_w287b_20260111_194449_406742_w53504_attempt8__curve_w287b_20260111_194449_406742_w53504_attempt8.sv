module curve_w287b_20260111_194449_406742_w53504_attempt8 (
  input  input_a,
  input  input_b,
  output output_sum
);

  // Instantiate sub-module, leaving one output port unconnected
  math_unit u_adder (
    .a         (input_a),
    .b         (input_b),
    .sum_out   (output_sum),
    .carry_out () // W287b violation: Instance output port 'carry_out' is not connected
  );

endmodule
