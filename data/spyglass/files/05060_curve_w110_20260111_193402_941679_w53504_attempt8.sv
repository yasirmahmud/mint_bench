module curve_w110_20260111_193402_941679_w53504_attempt8 (
  input [1:0] in_a,   // Multi-bit input (2 bits)
  input       in_b,   // Single-bit input
  output      out_z   // Single-bit output
);

  // W110 violation: Incompatible width for port 'in_a' and its connected net.
  // The 'nand' primitive expects 1-bit inputs for its data ports.
  // Connecting the 2-bit 'in_a' to a 1-bit input port of the 'nand' primitive
  // causes this width mismatch violation.
  nand (out_z, in_a, in_b);

endmodule
