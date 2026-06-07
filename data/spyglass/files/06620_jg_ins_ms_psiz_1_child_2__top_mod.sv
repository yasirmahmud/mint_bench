module top_mod ();
  wire w_a;
  wire w_b;

  assign w_a = 1'b1;

  sub_mod u_sub_mod (
    .in_a (w_a),
    .out_b (w_b)
  );

  // The previous attempt to fix W528 for 'w_b' by introducing 'unused_w_b'
  // simply shifted the violation to 'unused_w_b' itself, as reported.
  // To resolve the W528 violation for 'unused_w_b' and maintain functional behavior
  // (where 'w_b' is set but not consumed by 'top_mod'), the 'unused_w_b' declaration
  // and its assignment have been removed.

endmodule
