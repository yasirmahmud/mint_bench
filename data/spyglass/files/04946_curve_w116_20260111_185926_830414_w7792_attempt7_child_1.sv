module curve_w116_20260111_185926_830414_w7792_attempt7 #(
  parameter WIDTH = 11
) (
  input wire [WIDTH-1:0] data_in,
  output wire out_bit_0,
  output wire out_bit_1,
  output wire out_bit_2,
  output wire out_bit_3,
  output wire out_bit_4,
  output wire out_bit_5,
  output wire out_bit_6,
  output wire out_bit_7,
  output wire out_bit_8,
  output wire out_bit_9
);

  // Parameter WIDTH must be at least 3 for the right operand to be multi-bit.
  // The rule description specifically mentions 1-bit versus 10-bit for the operands
  // of the '&' operator, so WIDTH=11 aligns perfectly with this (WIDTH-1=10, WIDTH-2:0 = 9:0).

  // W116 violation: Operands of the bitwise AND (&) operator have mismatched widths.
  // The left expression 'data_in[WIDTH-1]' has a width of 1 bit.
  // The right expression '~data_in[WIDTH-2:0]' has a width of (WIDTH-1) bits.
  // For WIDTH = 11, this means data_in[10] (1-bit) is ANDed with ~data_in[9:0] (10-bits).
  // Each of the following 10 assignment statements will trigger one occurrence of W116.
  assign out_bit_0 = data_in[WIDTH-1] & ~data_in[WIDTH-2:0];
  assign out_bit_1 = data_in[WIDTH-1] & ~data_in[WIDTH-2:0];
  assign out_bit_2 = data_in[WIDTH-1] & ~data_in[WIDTH-2:0];
  assign out_bit_3 = data_in[WIDTH-1] & ~data_in[WIDTH-2:0];
  assign out_bit_4 = data_in[WIDTH-1] & ~data_in[WIDTH-2:0];
  assign out_bit_5 = data_in[WIDTH-1] & ~data_in[WIDTH-2:0];
  assign out_bit_6 = data_in[WIDTH-1] & ~data_in[WIDTH-2:0];
  assign out_bit_7 = data_in[WIDTH-1] & ~data_in[WIDTH-2:0];
  assign out_bit_8 = data_in[WIDTH-1] & ~data_in[WIDTH-2:0];
  assign out_bit_9 = data_in[WIDTH-1] & ~data_in[WIDTH-2:0];

endmodule
