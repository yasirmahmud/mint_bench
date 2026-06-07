module curve_wrn_71_20260111_181108_876467_w7792_attempt9 (
  input wire [7:0] in_data,
  output wire [7:0] out_data_a,
  output wire [7:0] out_data_b
);

  // Define parameters for the replication multiplier expression
  // Using a real literal in an expression results in a real value.
  parameter real REAL_DIVIDEND = 5.0;
  parameter int  INT_DIVISOR   = 2;

  // First occurrence of WRN_71:
  // The expression (REAL_DIVIDEND / INT_DIVISOR) evaluates to (5.0 / 2) = 2.5.
  // SpyGlass's WRN_71 rule triggers because the calculated repetition multiplier
  // (2.5) is a real number, not an integer, even though Verilog implicitly truncates it.
  // This effectively prepends 2'b00 to in_data[5:0] to form an 8-bit output.
  assign out_data_a = {{ (REAL_DIVIDEND / INT_DIVISOR) {1'b0} }, in_data[5:0]};

  // Second occurrence of WRN_71:
  // A direct real literal (3.1) is used as the repetition multiplier.
  // This explicitly violates WRN_71 as it is not an integer.
  // This effectively prepends 3'b000 to in_data[4:0] to form an 8-bit output.
  assign out_data_b = {{ 3.1 {1'b0} }, in_data[4:0]};

endmodule
