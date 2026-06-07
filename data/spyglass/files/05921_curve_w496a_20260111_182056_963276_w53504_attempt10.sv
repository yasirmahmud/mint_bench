module curve_w496a_20260111_182056_963276_w53504_attempt10 (
  input wire data_in,
  output wire data_out
);

  // W496a: Comparison (==) to tristate value (z) is treated as false in synthesis
  // This direct assignment using a comparison with '1'bz' aims to trigger only W496a.
  // In synthesis, the expression (data_in == 1'bz) will always evaluate to false, regardless of data_in's value,
  // which is the behavior targeted by W496a. This approach uses an 'assign' statement
  // to be distinct from previous 'always' block attempts and to minimize other rule triggers.
  assign data_out = (data_in == 1'bz);

endmodule
