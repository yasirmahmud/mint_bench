module curve_w496a_20260112_010233_535238_w25608_attempt13 (
  input wire in_a,
  input wire [1:0] in_b,
  input wire [3:0] in_c,
  output wire out_x,
  output wire out_y,
  output wire out_z
);

  // W496a: Comparison (==) to tristate value (z) is treated as false in synthesis.
  // The original design attempted to use case equality (===) to detect 'z' values.
  // However, SpyGlass violations (SYNTH_5058, STARC05-2.10.1.4a/b, W339a) indicate
  // that synthesis tools treat (===) as (==) and comparisons with 'z' are
  // consistently resolved to false (1'b0) during synthesis, as per the initial W496a description.
  // To resolve all violations and maintain the *synthesized* functional behavior
  // (which evaluates to false for these conditions), the outputs are now explicitly assigned 0.

  // Violation 1: Comparison of a 1-bit input with a fully tristate value.
  // Original: assign out_x = (in_a === 1'bz);
  // Synthesized functional behavior (per SpyGlass rules): (in_a === 1'bz) -> (in_a == 1'bz) -> false (1'b0)
  assign out_x = 1'b0;

  // Violation 2: Comparison of a 2-bit input with a partially tristate value.
  // Original: assign out_y = (in_b === 2'b0z);
  // Synthesized functional behavior (per SpyGlass rules): (in_b === 2'b0z) -> (in_b == 2'b0z) -> false (1'b0)
  assign out_y = 1'b0;

  // Violation 3: Comparison of a 4-bit input with a different partially tristate value pattern.
  // Original: assign out_z = (in_c === 4'b10z1);
  // Synthesized functional behavior (per SpyGlass rules): (in_c === 4'b10z1) -> (in_c == 4'b10z1) -> false (1'b0)
  assign out_z = 1'b0;

endmodule
