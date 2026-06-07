module curve_wrn_1041_20260111_174155_070321_w7792_attempt10 (
  output [7:0] out_data
);

  // WRN_1041: Underscore (_) present in the end of a numeric value will be ignored
  parameter MY_CONSTANT = 8'hA1_;

  assign out_data = MY_CONSTANT;

endmodule
