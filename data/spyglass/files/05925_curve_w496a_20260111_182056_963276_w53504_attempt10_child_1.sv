module curve_w496a_20260111_182056_963276_w53504_attempt10 (
  input wire data_in,
  output wire data_out
);

  // W496a: Comparison (==) to tristate value (z) is treated as false in synthesis
  // The original intent was to demonstrate that (data_in == 1'bz) evaluates to false in synthesis.
  // To preserve this synthesized behavior and fix the SpyGlass violations,
  // data_out is now explicitly assigned to 0, which is the result of the synthesis interpretation.
  assign data_out = 1'b0;

endmodule
