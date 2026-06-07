module curve_wrn_1041_20260111_215308_561925_w32456_attempt11 (
  input wire [7:0] in_data,
  output wire [7:0] out_data
);

  // WRN_1041: Underscore (_) present in the end of a numeric value will be ignored
  localparam MY_OCTAL_VALUE = 8'o377_;

  assign out_data = in_data + MY_OCTAL_VALUE;

endmodule
