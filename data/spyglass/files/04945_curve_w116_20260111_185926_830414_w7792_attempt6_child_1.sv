module curve_w116_20260111_185926_830414_w7792_attempt6 (
  input wire [DATA_WIDTH-1:0] data_in,
  output wire [DATA_WIDTH-2:0] out_val
);

  parameter DATA_WIDTH = 11; // Moved parameter declaration here to resolve STX_VE_606 violations

  // Parameter DATA_WIDTH must be greater than 2 for the rule to apply
  // as specified (1-bit vs multi-bit for the right operand).
  // E.g., if DATA_WIDTH = 11, then DATA_WIDTH-1 = 10, DATA_WIDTH-2 = 9.

  // W116 violation:
  // The left expression 'data_in[DATA_WIDTH-1]' has a width of 1 bit.
  // The right expression '~data_in[DATA_WIDTH-2:0]' has a width of (DATA_WIDTH-1) bits.
  // For DATA_WIDTH = 11, this means 1-bit (data_in[10]) is ANDed with 10-bits (~data_in[9:0]).
  // SpyGlass will flag this width mismatch for the bitwise AND operator.
  assign out_val = data_in[DATA_WIDTH-1] & ~data_in[DATA_WIDTH-2:0];

endmodule
