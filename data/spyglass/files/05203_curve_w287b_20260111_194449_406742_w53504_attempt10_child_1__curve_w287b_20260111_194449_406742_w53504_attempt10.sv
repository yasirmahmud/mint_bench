module curve_w287b_20260111_194449_406742_w53504_attempt10 (
  input in_a,
  input in_b,
  output out_sum_val
);

  // Declare a wire to connect the unused 'o_carry' output of half_adder
  wire dummy_o_carry;

  // Instantiate half_adder, connecting its 'o_carry' output port to a dummy wire to resolve W287b
  half_adder u_ha (
    .i_a     (in_a),
    .i_b     (in_b),
    .o_sum   (out_sum_val),
    .o_carry (dummy_o_carry) // Connected to resolve W287b violation
  );

endmodule
