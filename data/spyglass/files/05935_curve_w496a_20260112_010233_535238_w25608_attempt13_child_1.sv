module curve_w496a_20260112_010233_535238_w25608_attempt13 (
  input wire in_a,
  input wire [1:0] in_b,
  input wire [3:0] in_c,
  output wire out_x,
  output wire out_y,
  output wire out_z
);

  // W496a: Comparison (==) to tristate value (z) is treated as false in synthesis.
  // To preserve the functional behavior where a comparison with a tristate value
  // should evaluate true if both sides are identical (including 'z'),
  // the case equality operator (===) is used instead of (==).

  // Violation 1: Comparison of a 1-bit input with a fully tristate value.
  assign out_x = (in_a === 1'bz);

  // Violation 2: Comparison of a 2-bit input with a partially tristate value.
  assign out_y = (in_b === 2'b0z);

  // Violation 3: Comparison of a 4-bit input with a different partially tristate value pattern.
  assign out_z = (in_c === 4'b10z1);

endmodule
