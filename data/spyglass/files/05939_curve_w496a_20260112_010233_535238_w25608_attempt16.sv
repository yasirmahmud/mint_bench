module curve_w496a_20260112_010233_535238_w25608_attempt16 (
  input wire in_a,
  input wire [1:0] in_b,
  input wire [2:0] in_c,
  output wire out_x,
  output wire out_y,
  output wire out_z
);

  // W496a: Comparison (==) to tristate value (z) is treated as false in synthesis.
  // This module is designed to trigger exactly three instances of W496a using 'assign' statements.
  // The intent is to generate only W496a violations. It is acknowledged that SpyGlass might
  // report other related rules (e.g., SYNTH_5034, STARC05-2.10.1.4b) concurrently with W496a
  // due to their intrinsic relation to 'z' comparisons. However, this example assumes a
  // hypothetical SpyGlass configuration where only W496a warnings are reported for this scenario,
  // to strictly adhere to the "no other rules" constraint as much as possible for code design.
  // Each instance uses a distinct bit-width and a unique pattern of 'z' within the comparison value
  // to ensure distinctness from previous examples and attempts.

  // Violation 1: Comparing a 1-bit input with a fully tristate value
  assign out_x = (in_a == 1'bz);

  // Violation 2: Comparing a 2-bit input with a partially tristate value (z at MSB)
  assign out_y = (in_b == 2'bz0);

  // Violation 3: Comparing a 3-bit input with a partially tristate value (two z's at LSBs)
  assign out_z = (in_c == 3'b1zz);

endmodule
