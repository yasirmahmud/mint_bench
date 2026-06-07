module curve_wrn_51_20260111_193220_088996_w36056_attempt9 (
  input [3:0] a,
  input [3:0] b,
  output reg [39:0] c
);

  // WRN_51: Concatenation with unsized number ( 5 ). Some simulators might not support this.
  // The '5' is an unsized decimal number literal. Its width in a concatenation is ambiguous
  // and typically defaults to 32 bits (integer width) in Verilog-2001. 
  // This directly triggers WRN_51.
  // The output 'c' is sized to accommodate: 'a' (4 bits) + '5' (32 bits) + 'b' (4 bits) = 40 bits,
  // preventing additional width mismatch warnings.
  always @(*) begin
    c = {a, 5, b};
  end

endmodule
