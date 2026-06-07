module curve_wrn_1041_20260110_134408_attempt5 (
  input wire [7:0] in_val,
  output wire [7:0] out_val
);

  // WRN_1041: Underscore (_) present in the end of a numeric value will be ignored
  // This example uses a sized hexadecimal literal with a trailing underscore.
  localparam [7:0] CONST_VALUE = 8'hFF_;

  assign out_val = in_val + CONST_VALUE;

endmodule
