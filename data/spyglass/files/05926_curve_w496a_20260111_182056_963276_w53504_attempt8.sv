module curve_w496a_20260111_182056_963276_w53504_attempt8 (
  input wire a,
  output wire out
);

  assign out = (a == 1'bz); // W496a: Comparison (==) to tristate value (z) is treated as false in synthesis

endmodule
