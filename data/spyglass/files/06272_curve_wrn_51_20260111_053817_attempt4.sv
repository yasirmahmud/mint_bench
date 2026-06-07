module curve_wrn_51_20260111_053817_attempt4 (
  input [7:0] in_a,
  output [8:0] out_b
);

  // WRN_51: Concatenation with unsized number (1). Some simulators might not support this.
  // The literal '1' is unsized, triggering the violation.
  assign out_b = {1, in_a};

endmodule
