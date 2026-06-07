module curve_wrn_64_20260110_221446_attempt6 (
  input wire [7:0] data_in,
  output wire [1:0] out_high_oob,
  output wire [1:0] out_low_oob,
  output wire       dummy_out_bit
);

  // WRN_64 violation 1 (occurrence 1/2):
  // Part-select [8:7] is out-of-range for 'data_in[7:0]'.
  // The high index (8) is greater than the declared maximum index (7).
  // The low index (7) is within the declared range [0:7].
  assign out_high_oob = data_in[8:7];

  // WRN_64 violation 2 (occurrence 2/2):
  // Part-select [0:-1] is out-of-range for 'data_in[7:0]'.
  // The high index (0) is within the declared range [0:7].
  // The low index (-1) is less than the declared minimum index (0).
  assign out_low_oob = data_in[0:-1];

  // Dummy assignment to ensure 'data_in' is fully read and avoid 'W240' (Input declared but not read).
  assign dummy_out_bit = data_in[7];

endmodule
