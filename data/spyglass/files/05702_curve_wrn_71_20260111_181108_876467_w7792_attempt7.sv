module curve_wrn_71_20260111_181108_876467_w7792_attempt7 (
  input wire [7:0] in_data,
  output wire [7:0] out_data_a,
  output wire [7:0] out_data_b
);

  // Define a real parameter. When subtracted from a real literal (3.0),
  // the result will be a real number, which is not an integer.
  real parameter MY_BURST_SIZE_LOG2 = 1.5; // Example: 3.0 - 1.5 = 1.5

  // First occurrence:
  // The expression (3.0 - MY_BURST_SIZE_LOG2) evaluates to 1.5.
  // Although Verilog truncates this to 1 for the replication count,
  // SpyGlass's WRN_71 rule triggers because the multiplier's value
  // is not an integer (it's a real number).
  assign out_data_a = {{ (3.0 - MY_BURST_SIZE_LOG2) {1'b0} }, in_data[6:0]};

  // Second occurrence:
  // A similar construction to trigger another WRN_71 violation.
  assign out_data_b = {{ (3.0 - MY_BURST_SIZE_LOG2) {1'b0} }, in_data[6:0]};

endmodule
