module curve_wrn_1041_20260112_001643_177505_w47152_attempt16 (
  input wire in_enable,
  output wire [9:0] out_value
);

  // WRN_1041: Underscore (_) present in the end of a numeric value will be ignored
  // Using a 10-bit decimal parameter with a trailing underscore.
  parameter [9:0] MY_DECIMAL_CONSTANT = 10'd768_;

  assign out_value = in_enable ? MY_DECIMAL_CONSTANT : 10'd0;

endmodule
