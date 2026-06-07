// carry_follower implements the carry propagation logic: C_out = G | (P & C_in)
module carry_follower (
  input a,   // Generate (G)
  input b,   // Carry_in (C_i)
  input cin, // Propagate (P)
  output cout // Carry_out (C_i+1)
);
  assign cout = a | (b & cin);
endmodule
