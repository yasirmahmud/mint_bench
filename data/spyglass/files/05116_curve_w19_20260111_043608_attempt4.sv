module curve_w19_20260111_043608_attempt4 (
  output wire [4:0] truncated_val
);

  // W19: Constant 5'd32 will be truncated.
  // The decimal value 32 (binary 10_0000) requires 6 bits to represent.
  // However, it is specified as a 5-bit constant (5'd32), causing truncation of its MSB (the 6th bit).
  assign truncated_val = 5'd32;

endmodule
