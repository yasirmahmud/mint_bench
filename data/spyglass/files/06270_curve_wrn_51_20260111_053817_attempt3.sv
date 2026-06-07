module curve_wrn_51_20260111_053817_attempt3 (
  input [7:0] in_data,
  output [8:0] out_data
);

  // WRN_51: Concatenation with unsized number (0). Some simulators might not support this.
  // The literal '0' is unsized, triggering the violation.
  assign out_data = {in_data, 0};

endmodule
