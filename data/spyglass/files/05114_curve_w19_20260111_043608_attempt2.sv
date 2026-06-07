module curve_w19_20260111_043608_attempt2 (
  output wire [4:0] out_val
);

  // W19: Constant 5'd32 will be truncated.
  // The decimal value 32 (binary 100000) requires 6 bits,
  // but it is specified with 5 bits (5'd32), leading to truncation of the MSB.
  assign out_val = 5'd32;

endmodule
