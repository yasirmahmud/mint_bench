module curve_w496a_20260111_221530_411000_w15680_attempt12 (
  input wire in_a,
  input wire [1:0] in_b,
  input wire [2:0] in_c,
  output wire out_x,
  output wire out_y,
  output wire out_z
);

  // W496a: Comparison (==) to tristate value (z) is treated as false in synthesis
  // This module triggers exactly 3 instances of W496a by using 'assign' statements
  // to compare inputs with different bit-width tristate values (1'bz, 2'b0z, 3'b1z1).
  // This approach is distinct from previous attempts that primarily used 'always' blocks
  // and also from examples with a single assign statement or all 1'bz comparisons.

  // Violation 1: Comparison of a 1-bit input with a fully tristate value
  assign out_x = (in_a == 1'bz);

  // Violation 2: Comparison of a 2-bit input with a partially tristate value
  assign out_y = (in_b == 2'b0z);

  // Violation 3: Comparison of a 3-bit input with another partially tristate value
  assign out_z = (in_c == 3'b1z1);

endmodule
