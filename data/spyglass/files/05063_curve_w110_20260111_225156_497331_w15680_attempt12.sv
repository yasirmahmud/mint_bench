module curve_w110_20260111_225156_497331_w15680_attempt12 (
  input [1:0] in_a,
  input       in_b,
  output      out_z
);

  // W110 violation: The 'and' primitive expects 1-bit inputs for its data ports.
  // Connecting the 2-bit 'in_a' to a 1-bit expected input port of the primitive
  // will cause a width mismatch violation for port 'in_a'.
  and (out_z, in_a, in_b);

endmodule
