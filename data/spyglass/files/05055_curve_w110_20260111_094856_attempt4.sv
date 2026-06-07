module curve_w110_20260111_094856_attempt4 (
  input [1:0] in_a,
  input       in_b,
  output      out_z
);

  // W110: Incompatible width for port 'in_a' and its connected net.
  // The 'xor' gate primitive expects single-bit connections for its inputs.
  // Connecting a multi-bit 'in_a' to it causes a width mismatch violation for 'in_a'.
  xor (out_z, in_a, in_b);

endmodule
