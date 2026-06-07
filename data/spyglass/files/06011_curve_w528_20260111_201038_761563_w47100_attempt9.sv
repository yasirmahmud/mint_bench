module curve_w528_20260111_201038_761563_w47100_attempt9 (
  input wire data_in,
  output wire data_out
);

  // Declare a wire that will be assigned a value but never read.
  wire unused_combinational_var;

  // 'unused_combinational_var' is assigned (set) here.
  assign unused_combinational_var = data_in & 1'b1;

  // 'data_out' uses 'data_in' to ensure 'data_in' is not unused.
  assign data_out = data_in;

  // 'unused_combinational_var' is never read by any other logic,
  // leading to a W528 violation.

endmodule
