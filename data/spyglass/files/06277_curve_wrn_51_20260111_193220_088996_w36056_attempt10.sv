module curve_wrn_51_20260111_193220_088996_w36056_attempt10 (
  input [7:0] data_in,
  output reg [47:0] result
);

  // WRN_51: Concatenation with unsized number ( 10 ). Some simulators might not support this.
  // The '10' is an unsized decimal number literal within a concatenation.
  // In Verilog-2001, unsized decimal numbers in concatenation typically default to 32 bits (integer width).
  // This ambiguity in width is what triggers WRN_51.
  // The output 'result' is sized to accommodate: 'data_in' (8 bits) + '10' (32 bits) + 'data_in' (8 bits) = 48 bits.
  // This precise sizing prevents any additional width mismatch warnings, ensuring only WRN_51 is triggered.
  always @(*) begin
    result = {data_in, 10, data_in};
  end

endmodule
