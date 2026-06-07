module curve_w116_20260111_185926_830414_w7792_attempt8 #(
  parameter DATA_WIDTH = 11
) (
  input wire [DATA_WIDTH-1:0] data_in,
  output wire out_0,
  output wire out_1,
  output wire out_2,
  output wire out_3,
  output wire out_4,
  output wire out_5,
  output wire out_6,
  output wire out_7,
  output wire out_8,
  output wire out_9
);

  // W116 violation: Operands of the bitwise AND (&) operator have mismatched widths.
  // The rule states: "left expression: "TC[(width - 1)]" width 1 should match right expression: "(~TC[(width - 2):0] )" width 10."
  // For DATA_WIDTH = 11, the left operand 'data_in[DATA_WIDTH-1]' (i.e., data_in[10]) has a width of 1 bit.
  // The right operand '~data_in[DATA_WIDTH-2:0]' (i.e., ~data_in[9:0]) has a width of 10 bits.
  // This exact mismatch is generated 10 times to meet the 'Total occurrences: 10' requirement.
  assign out_0 = data_in[DATA_WIDTH-1] & ~data_in[DATA_WIDTH-2:0];
  assign out_1 = data_in[DATA_WIDTH-1] & ~data_in[DATA_WIDTH-2:0];
  assign out_2 = data_in[DATA_WIDTH-1] & ~data_in[DATA_WIDTH-2:0];
  assign out_3 = data_in[DATA_WIDTH-1] & ~data_in[DATA_WIDTH-2:0];
  assign out_4 = data_in[DATA_WIDTH-1] & ~data_in[DATA_WIDTH-2:0];
  assign out_5 = data_in[DATA_WIDTH-1] & ~data_in[DATA_WIDTH-2:0];
  assign out_6 = data_in[DATA_WIDTH-1] & ~data_in[DATA_WIDTH-2:0];
  assign out_7 = data_in[DATA_WIDTH-1] & ~data_in[DATA_WIDTH-2:0];
  assign out_8 = data_in[DATA_WIDTH-1] & ~data_in[DATA_WIDTH-2:0];
  assign out_9 = data_in[DATA_WIDTH-1] & ~data_in[DATA_WIDTH-2:0];

endmodule
