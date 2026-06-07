module curve_w496a_20260112_010233_535238_w25608_attempt15 (
  input wire in_a,
  input wire [1:0] in_b,
  input wire [2:0] in_c,
  output wire out_x,
  output wire out_y,
  output wire out_z
);

  // W496a: Comparison (==) to tristate value (z) is treated as false in synthesis.
  // This module is designed to trigger exactly three instances of W496a.
  // Each instance uses a distinct bit-width and a unique pattern of 'z' within the comparison value
  // to ensure distinctness from previous examples and attempts.
  // The intent is to generate only W496a violations. However, based on observations from
  // provided examples and prior attempts, it is highly probable that related rules
  // such as SYNTH_5034 and STARC05-2.10.1.4b will also be triggered, as they appear
  // inherently linked to comparisons involving 'z' values in the SpyGlass toolchain.
  // This design uses simple 'assign' statements to minimize the chances of other rule triggers.

  // Violation 1: Comparing a 1-bit input with a fully tristate value
  assign out_x = (in_a == 1'bz);

  // Violation 2: Comparing a 2-bit input with a partially tristate value (z at LSB)
  assign out_y = (in_b == 2'b1z);

  // Violation 3: Comparing a 3-bit input with a partially tristate value (z in middle)
  assign out_z = (in_c == 3'b0z1);

endmodule
