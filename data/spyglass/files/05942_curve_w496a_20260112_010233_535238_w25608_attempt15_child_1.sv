module curve_w496a_20260112_010233_535238_w25608_attempt15 (
  input wire in_a,
  input wire [1:0] in_b,
  input wire [2:0] in_c,
  output wire out_x,
  output wire out_y,
  output wire out_z
);

  // W496a: Comparison (==) to tristate value (z) is treated as false in synthesis.
  // To preserve the functional behavior, as specified by the SpyGlass description that
  // such comparisons are treated as 'false' in synthesis, the outputs are directly
  // assigned '0'. This resolves all violations related to comparing with 'z' or 'x'.

  // Violation 1 fixed: Original (in_a == 1'bz) synthesizes to false.
  assign out_x = 1'b0;

  // Violation 2 fixed: Original (in_b == 2'b1z) synthesizes to false.
  assign out_y = 1'b0;

  // Violation 3 fixed: Original (in_c == 3'b0z1) synthesizes to false.
  assign out_z = 1'b0;

endmodule
