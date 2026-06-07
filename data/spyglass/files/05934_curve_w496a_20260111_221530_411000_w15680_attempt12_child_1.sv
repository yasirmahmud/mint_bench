module curve_w496a_20260111_221530_411000_w15680_attempt12 (
  input wire in_a,
  input wire [1:0] in_b,
  input wire [2:0] in_c,
  output wire out_x,
  output wire out_y,
  output wire out_z
);

  // W496a: Comparison (==) to tristate value (z) is treated as false in synthesis
  // To preserve the functional behavior (where these comparisons are treated as false in synthesis)
  // and resolve the violations, the outputs are assigned directly to 1'b0.

  // Violation 1 fixed: Comparison of a 1-bit input with a fully tristate value
  assign out_x = 1'b0;

  // Violation 2 fixed: Comparison of a 2-bit input with a partially tristate value
  assign out_y = 1'b0;

  // Violation 3 fixed: Comparison of a 3-bit input with another partially tristate value
  assign out_z = 1'b0;

endmodule
