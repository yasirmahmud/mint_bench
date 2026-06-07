module curve_wrn_64_20260110_221446_attempt1 (
  input wire [7:0] in_data, // An 8-bit input vector (indices 0 to 7)
  output wire out_bit_high, // Output for high index access
  output wire out_bit_low   // Output for low index access
);

  // WRN_64 violation 1: Part-select is out-of-range (index 8 is too high for [7:0])
  assign out_bit_high = in_data[8];

  // WRN_64 violation 2: Part-select is out-of-range (index -1 is too low for [7:0])
  assign out_bit_low = in_data[-1];

endmodule
