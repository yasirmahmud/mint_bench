module curve_w19_20260111_043608_attempt3 (
  output wire [3:0] truncated_val
);

  // W19: Constant 4'h10 will be truncated.
  // The hexadecimal value 10 (decimal 16, binary 1_0000) requires 5 bits,
  // but it is specified with 4 bits (4'h10), leading to truncation of the MSB.
  assign truncated_val = 4'h10;

endmodule
