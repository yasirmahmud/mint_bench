module curve_w110_20260111_094856_attempt1 (
  input [1:0] in_a,
  input       in_b,
  output      out_z
);

  // W110: Incompatible width for port 'in_a' and its connected net.
  // The 'or' gate expects single-bit connections when its output 'out_z' is single-bit.
  // Connecting a multi-bit 'in_a' to it causes a width mismatch violation for 'in_a'.
  or (out_z, in_a, in_b);

endmodule
