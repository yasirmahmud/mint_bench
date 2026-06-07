module curve_wrn_71_20260111_181108_876467_w7792_attempt10 (
  input wire [7:0] in_value,
  output wire [10:0] out_a,
  output wire [9:0] out_b
);

  // Define parameters for the first repetition multiplier expression
  // Using a real parameter in an expression can lead to a real result.
  parameter real NUMERATOR_A = 7.0;
  parameter int  DENOMINATOR_A = 2;

  // First occurrence of WRN_71:
  // The expression (NUMERATOR_A / DENOMINATOR_A) evaluates to (7.0 / 2) = 3.5.
  // SpyGlass's WRN_71 rule triggers here because the repetition multiplier
  // (3.5) is a real number, not an integer, even though Verilog will implicitly
  // truncate it to 3 for the replication. The rule reports on the non-integer *type* of the multiplier.
  assign out_a = {{ (NUMERATOR_A / DENOMINATOR_A) {1'b0} }, in_value[7:0]};

  // Second occurrence of WRN_71:
  // A direct real literal (2.7) is used as the repetition multiplier.
  // This explicitly violates WRN_71 as it is not an integer value.
  // Verilog will implicitly truncate it to 2 for the replication.
  assign out_b = {{ 2.7 {1'b0} }, in_value[7:0]};

endmodule
