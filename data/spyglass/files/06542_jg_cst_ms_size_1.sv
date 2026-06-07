module TruncationExample1 (
  output reg [2:0] out_val
);

  // Constant 3'd10: Value 10 (binary 1010) requires 4 bits,
  // but is specified with 3 bits, causing truncation.
  assign out_val = 3'd10;

endmodule
