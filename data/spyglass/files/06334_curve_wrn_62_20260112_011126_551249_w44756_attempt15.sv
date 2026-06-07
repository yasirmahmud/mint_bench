module curve_wrn_62_20260112_011126_551249_w44756_attempt15 (
  input [1:0] val_a,
  input [1:0] val_b,
  input [3:0] data_bus,
  output out_signal
);

  // WRN_62 violation: The bit-wise OR operator '|' is followed by a reduction OR
  // '|data_bus' without the reduction OR being enclosed in its own set of parentheses.
  // The left-hand operand '(val_a == val_b)' is a 1-bit comparison result,
  // preventing W116 (width mismatch) as the right-hand operand '|data_bus' is also 1-bit.
  assign out_signal = (val_a == val_b) | |data_bus;

endmodule
