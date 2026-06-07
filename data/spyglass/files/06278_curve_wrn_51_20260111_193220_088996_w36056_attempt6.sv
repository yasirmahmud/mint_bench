module curve_wrn_51_20260111_193220_088996_w36056_attempt6 (
  input [7:0] in_data,
  output [39:0] out_data
);

  // WRN_51: Concatenation with unsized number ( 0 ). Some simulators might not support this.
  // The '0' is an unsized number. Its width in concatenation is ambiguous.
  // This directly triggers WRN_51.
  // To avoid additional width mismatch warnings, 'out_data' is declared with a width of 40 bits,
  // accommodating 'in_data' (8 bits) plus a potential 32-bit (default integer width) interpretation of the unsized '0'.
  assign out_data = {0, in_data};

endmodule
