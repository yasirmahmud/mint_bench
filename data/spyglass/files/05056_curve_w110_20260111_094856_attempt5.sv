module curve_w110_20260111_094856_attempt5 (
  input [1:0] in_a,
  input       enable,
  output      out_z
);

  // W110: Incompatible width for port 'in_a' and its connected net.
  // The 'bufif1' gate primitive expects the 'input' and 'output' ports
  // to have matching widths. Here, 'in_a' is 2-bit, but 'out_z' is 1-bit,
  // leading to an incompatible width violation for 'in_a'.
  bufif1 (out_z, in_a, enable);

endmodule
