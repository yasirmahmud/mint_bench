module TruncationExample2 (
  output reg [3:0] out_data
);

  // Constant 4'b11111: Value 11111 (decimal 31) requires 5 bits,
  // but is specified with 4 bits, causing truncation.
  localparam MY_TRUNCATED_CONST = 4'b11111;

  assign out_data = MY_TRUNCATED_CONST;

endmodule
