module curve_wrn_1041_20260112_001643_177505_w47152_attempt15 (
  input wire [15:0] in_data,
  output wire [15:0] out_data
);

  // WRN_1041: Underscore (_) present in the end of a numeric value will be ignored
  // Using a 16-bit binary localparam with a trailing underscore.
  localparam [15:0] MY_MASK = 16'b1010101010101010_;

  assign out_data = in_data & MY_MASK;

endmodule
