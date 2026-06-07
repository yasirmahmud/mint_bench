module curve_wrn_1041_20260110_134408_attempt3 (
  input wire [7:0] in_data,
  output wire [7:0] out_data
);

  // WRN_1041: Underscore (_) present in the end of a numeric value will be ignored
  // This example uses a sized hexadecimal literal with a trailing underscore.
  wire [7:0] my_constant = 8'hA1_;

  assign out_data = in_data + my_constant;

endmodule
