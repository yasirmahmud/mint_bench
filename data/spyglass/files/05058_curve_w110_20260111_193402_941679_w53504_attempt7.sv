module curve_w110_20260111_193402_941679_w53504_attempt7 (
  input [1:0] in_a, 
  input       in_b, 
  output      out_z
);

  // W110 violation: The 'or' primitive expects 1-bit inputs for in_a. 
  // Port 'in_a' (2 bits) is connected to a 1-bit expected input port of the primitive.
  or (out_z, in_a, in_b);

endmodule
