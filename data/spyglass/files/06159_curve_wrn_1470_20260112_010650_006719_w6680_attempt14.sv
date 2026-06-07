module curve_wrn_1470_20260112_010650_006719_w6680_attempt14 (
    input in_a,
    input in_b,
    input in_c,
    input in_d,
    input in_e,
    input in_f,
    output [3:0] out_vec0,
    output [4:0] out_vec1,
    output [2:0] out_vec2
);

  // WRN_1470 #1: This assignment pattern uses explicit integer keys (0, 1)
  // and a 'default' key, a SystemVerilog construct not supported in Verilog-2001.
  assign out_vec0 = '{0: in_a, 1: in_b, default: 1'b0};

  // WRN_1470 #2: Another instance of the unsupported array pattern, assigning
  // to a 5-bit vector with a specific key and an input signal as default.
  assign out_vec1 = '{2: in_c, default: in_d};

  // WRN_1470 #3: A third instance, targeting a 3-bit vector, with distinct keys (1, 0)
  // and a constant '1' as the default value, demonstrating multiple occurrences of WRN_1470.
  assign out_vec2 = '{1: in_e, 0: in_f, default: 1'b1};

endmodule
