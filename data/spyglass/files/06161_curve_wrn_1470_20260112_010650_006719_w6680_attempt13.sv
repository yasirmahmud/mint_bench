module curve_wrn_1470_20260112_010650_006719_w6680_attempt13 (
    input in_a,
    input in_b,
    input in_c,
    input in_d,
    output [3:0] out_vec0,
    output [2:0] out_vec1,
    output [4:0] out_vec2
);

  // WRN_1470 #1: This assignment pattern uses explicit integer keys (0, 2)
  // and a 'default' key, which is a SystemVerilog construct not supported in Verilog-2001.
  assign out_vec0 = '{0: in_a, 2: in_b, default: 1'b0};

  // WRN_1470 #2: Another instance of the unsupported array pattern, assigning
  // to a 3-bit vector with a different key and a constant '1' as default.
  assign out_vec1 = '{1: in_c, default: 1'b1};

  // WRN_1470 #3: A third instance, targeting a 5-bit vector, with distinct keys (4, 0)
  // and an input signal ('in_b') serving as the default value, demonstrating
  // multiple occurrences of WRN_1470.
  assign out_vec2 = '{4: in_d, 0: in_a, default: in_b};

endmodule
