module curve_w19_20260111_043608_attempt5 (
  output wire [2:0] truncated_val
);

  // W19: Constant 3'b1111 will be truncated.
  // The binary value 1111 (decimal 15) requires 4 bits to represent.
  // However, it is specified as a 3-bit constant (3'b1111),
  // causing truncation of its most significant bit (the 4th bit).
  assign truncated_val = 3'b1111;

endmodule
