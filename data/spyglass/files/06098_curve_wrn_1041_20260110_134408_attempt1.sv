module curve_wrn_1041_20260110_134408_attempt1 (
  input wire [7:0] in_data,
  output wire [7:0] out_data
);

  // WRN_1041: Underscore (_) present in the end of a numeric value will be ignored
  localparam ADD_CONSTANT = 5_;

  assign out_data = in_data + ADD_CONSTANT;

endmodule
