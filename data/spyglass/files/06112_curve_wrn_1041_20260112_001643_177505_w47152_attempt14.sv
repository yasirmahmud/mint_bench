module curve_wrn_1041_20260112_001643_177505_w47152_attempt14 (
  input wire in_enable,
  output wire [3:0] out_value
);

  // WRN_1041: Underscore (_) present in the end of a numeric value will be ignored
  // Using an unsized decimal literal with a trailing underscore in an expression.
  assign out_value = in_enable ? 12_ : 4'd5; 

endmodule
