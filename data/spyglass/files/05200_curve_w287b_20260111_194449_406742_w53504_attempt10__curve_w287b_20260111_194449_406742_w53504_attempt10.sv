module curve_w287b_20260111_194449_406742_w53504_attempt10 (
  input in_a,
  input in_b,
  output out_sum_val
);

  // Instantiate half_adder, leaving its 'o_carry' output port unconnected to trigger W287b
  half_adder u_ha (
    .i_a     (in_a),
    .i_b     (in_b),
    .o_sum   (out_sum_val),
    .o_carry () // W287b violation: Instance output port 'o_carry' is not connected
  );

endmodule
