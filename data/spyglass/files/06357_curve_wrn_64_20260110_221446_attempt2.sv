module curve_wrn_64_20260110_221446_attempt2 (
  input wire [3:0] data_in,      // A 4-bit input vector (indices 0 to 3)
  output wire [3:0] part_select_high_out, // Output for part-select with high out-of-range index
  output wire [3:0] part_select_low_out   // Output for part-select with low out-of-range index
);

  // WRN_64 violation 1: Part-select is out-of-range (high index 4 is too high for [3:0])
  // The range [4:1] is 4 bits wide. Output also 4 bits wide.
  assign part_select_high_out = data_in[4:1];

  // WRN_64 violation 2: Part-select is out-of-range (low index -1 is too low for [3:0])
  // The range [2:-1] is 4 bits wide. Output also 4 bits wide.
  assign part_select_low_out = data_in[2:-1];

endmodule
