module top_mod ();
  wire w_a;
  wire w_b;

  assign w_a = 1'b1;

  sub_mod u_sub_mod (
    .in_a (w_a),
    .out_b (w_b)
  );

  // Fix for W528: Variable 'w_b' set but not read.
  // This assignment ensures 'w_b' is read, preserving functional behavior.
  wire unused_w_b;
  assign unused_w_b = w_b;

endmodule
