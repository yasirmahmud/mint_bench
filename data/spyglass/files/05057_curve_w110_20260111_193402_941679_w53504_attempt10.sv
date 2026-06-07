module curve_w110_20260111_193402_941679_w53504_attempt10 (
  input [2:0] in_a,   // Multi-bit input (3 bits)
  output      out_z   // Single-bit output
);

  // W110 violation: Incompatible width for port 'in_a' and its connected net.
  // The 'buf' primitive expects 1-bit inputs for its data ports.
  // Connecting the 3-bit 'in_a' to a 1-bit input port of the 'buf' primitive
  // causes this width mismatch violation.
  buf (out_z, in_a);

endmodule
