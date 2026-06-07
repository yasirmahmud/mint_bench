module curve_wrn_1041_20260110_134408_attempt4 (
  input wire [3:0] in_val,
  output wire [3:0] out_val
);

  // WRN_1041: Underscore (_) present in the end of a numeric value will be ignored
  // This example uses an unsized decimal literal with a trailing underscore.
  parameter OFFSET = 10_;

  assign out_val = in_val + OFFSET;

endmodule
