module curve_wrn_51_20260111_193220_088996_w36056_attempt7 (
  input [3:0] in_a,
  input [3:0] in_b,
  output [39:0] out_data
);

  // WRN_51: Concatenation with unsized number ( 5 ). Some simulators might not support this.
  // The '5' is an unsized decimal number literal. Its width in a concatenation is ambiguous
  // and typically defaults to 32 bits (integer width) in Verilog.
  // This directly triggers WRN_51.
  // The output 'out_data' is sized to accommodate: in_a (4 bits) + '5' (32 bits) + in_b (4 bits) = 40 bits,
  // preventing additional width mismatch warnings.
  assign out_data = {in_a, 5, in_b};

endmodule
