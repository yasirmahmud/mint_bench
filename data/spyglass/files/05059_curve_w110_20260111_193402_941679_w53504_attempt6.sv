module curve_w110_20260111_193402_941679_w53504_attempt6 (
  input [1:0] in_a, // Port 'in_a' is 2 bits wide
  output out_z
);

  // W110 violation: The 'not' primitive expects a 1-bit input.
  // Port 'in_a' (2 bits) is connected to this 1-bit expected net.
  not (out_z, in_a);

endmodule
