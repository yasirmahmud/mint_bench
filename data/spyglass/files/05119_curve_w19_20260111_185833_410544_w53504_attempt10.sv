module curve_w19_20260111_185833_410544_w53504_attempt10 (
  output reg [7:0] out_val
);

  // W19: Constant 'h100' (decimal 256, binary 9'b1_0000_0000)
  // requires 9 bits to represent its full value.
  // However, it is specified with 8 bits (8'h100),
  // causing truncation of the most significant bit.
  always @(*) begin
    out_val = 8'h100;
  end

endmodule
