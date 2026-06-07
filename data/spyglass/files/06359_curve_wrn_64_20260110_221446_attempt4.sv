module curve_wrn_64_20260110_221446_attempt4 (
  input wire [7:0] data_in,
  output wire [7:0] out_high_oob,
  output wire [7:0] out_low_oob
);

  // WRN_64 violation 1: Part-select high index 9 is out-of-range for 'data_in[7:0]'.
  // The valid range is [0:7]. The part-select width is (9 - 2 + 1) = 8 bits.
  assign out_high_oob = data_in[9:2];

  // WRN_64 violation 2: Part-select low index -2 is out-of-range for 'data_in[7:0]'.
  // The valid range is [0:7]. The part-select width is (5 - (-2) + 1) = 8 bits.
  assign out_low_oob = data_in[5:-2];

endmodule
