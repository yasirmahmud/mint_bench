module top_mod ();
  wire [0:0] w_a;
  wire w_b;

  assign w_a = 1'b1;

  sub_mod u_sub_mod (
    .in_a (w_a), // Mismatch: sub_mod.in_a is 2 bits, w_a is 1 bit
    .out_b (w_b)
  );
endmodule
