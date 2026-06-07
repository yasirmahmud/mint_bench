module curve_w496a_20260112_010233_535238_w25608_attempt16 (
  input wire in_a,
  input wire [1:0] in_b,
  input wire [2:0] in_c,
  output wire out_x,
  output wire out_y,
  output wire out_z
);

  // W496a: Comparison (==) to tristate value (z) is treated as false in synthesis.
  // The original design explicitly included comparisons to 'z' to demonstrate W496a violations.
  // As synthesis treats these comparisons as always false, the functional behavior
  // (i.e., the output always being '0' when synthesized) is preserved by explicitly
  // assigning '0' to the outputs, while resolving the linting violations.

  // Violation 1 fixed: Replaced comparison with 'z' with its synthesized equivalent (false).
  assign out_x = 1'b0;

  // Violation 2 fixed: Replaced comparison with 'z0' with its synthesized equivalent (false).
  assign out_y = 1'b0;

  // Violation 3 fixed: Replaced comparison with '1zz' with its synthesized equivalent (false).
  assign out_z = 1'b0;

endmodule
