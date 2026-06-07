module curve_wrn_1470_20260110_232532_attempt2 (
  input in_bit_a,
  input [1:0] in_vec_b,
  input [2:0] in_vec_c,
  output [3:0] out_pattern0,
  output [3:0] out_pattern1,
  output [3:0] out_pattern2
);

  // WRN_1470 (1/3): Using array pattern keys for vector assignment
  assign out_pattern0 = '{0: in_bit_a, default: 1'b0};

  // WRN_1470 (2/3): Using array pattern keys with multiple explicit assignments
  assign out_pattern1 = '{0: in_vec_b[0], 1: in_vec_b[1], default: 1'b0};

  // WRN_1470 (3/3): Using array pattern keys with a larger vector and mixed order
  assign out_pattern2 = '{2: in_vec_c[2], 0: in_vec_c[0], default: 1'b0};

endmodule
