module curve_wrn_1024_20260111_193923_499283_w37940_attempt9 (
  input wire signed [7:0] in_data,
  output wire signed [7:0] out_data
);

  // WRN_1024: 'in_data' is already declared as signed, so passing it to $signed() is redundant.
  assign out_data = $signed(in_data);

endmodule
