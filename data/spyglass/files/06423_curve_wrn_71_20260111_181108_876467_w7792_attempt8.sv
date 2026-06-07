module curve_wrn_71_20260111_181108_876467_w7792_attempt8 (
  input wire [7:0] in_data,
  output wire [7:0] out_data_a,
  output wire [7:0] out_data_b
);

  // Define an integer parameter as per Verilog-2001 standards.
  parameter MY_INT_PARAM = 2;

  // First occurrence of WRN_71:
  // The expression (3.5 - MY_INT_PARAM) evaluates to (3.5 - 2.0) = 1.5.
  // Because 3.5 is a real literal, the subtraction results in a real number (1.5).
  // Although Verilog will implicitly truncate 1.5 to 1 for the replication count,
  // SpyGlass's WRN_71 rule triggers because the *value* of the repetition multiplier
  // (1.5) is not an integer, even if its final effect is an integer truncation.
  // This provides 1 bit of '0' prepended to in_data[6:0], forming an 8-bit output.
  assign out_data_a = {{ (3.5 - MY_INT_PARAM) {1'b0} }, in_data[6:0]};

  // Second occurrence of WRN_71:
  // A similar construction to trigger another WRN_71 violation, ensuring 2 total occurrences.
  assign out_data_b = {{ (3.5 - MY_INT_PARAM) {1'b0} }, in_data[6:0]};

endmodule
