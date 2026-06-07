module curve_wrn_64_20260110_221446_attempt5 (
  input wire [7:0] data_in,
  output wire [2:0] out_high_oob,
  output wire [2:0] out_low_oob
);

  // WRN_64 violation 1: Part-select [10:8] is out-of-range for 'data_in[7:0]'.
  // Both high (10) and low (8) indices are out of the declared range [0:7].
  // The part-select width is (10 - 8 + 1) = 3 bits.
  assign out_high_oob = data_in[10:8];

  // WRN_64 violation 2: Part-select [-1:-3] is out-of-range for 'data_in[7:0]'.
  // Both high (-1) and low (-3) indices are out of the declared range [0:7].
  // The part-select width is (-1 - (-3) + 1) = 3 bits.
  assign out_low_oob = data_in[-1:-3];

endmodule
