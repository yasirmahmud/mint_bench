module curve_w19_20260111_185833_410544_w53504_attempt7 (
  output wire [6:0] out_val // 7-bit output
);

  // W19: Constant '128' (binary 10000000) requires 8 bits,
  // but is specified with 7 bits (7'd128), causing truncation.
  assign out_val = 7'd128;

endmodule
