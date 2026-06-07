module curve_wrn_1470_20260112_010650_006719_w6680_attempt15 (
    input data_in_a,
    input data_in_b,
    input data_in_c,
    input data_in_d,
    input data_in_e,
    input data_in_f,
    output [2:0] output_vec_A,
    output [4:0] output_vec_B,
    output [1:0] output_vec_C
);

  // WRN_1470 #1: This continuous assignment uses a SystemVerilog assignment pattern
  // with explicit integer keys (2, 0) and a 'default' key, which is not supported in Verilog-2001.
  assign output_vec_A = '{2: data_in_a, 0: data_in_b, default: 1'b0};

  // WRN_1470 #2: Another instance of the unsupported array pattern key construct.
  // This assignment uses a single explicit key and a default value derived
  // from an input signal, targeting a 5-bit vector.
  assign output_vec_B = '{3: data_in_c, default: data_in_d};

  // WRN_1470 #3: A third distinct instance of the array pattern key construct.
  // This assignment varies the key order (1, 0) and uses a constant '1' for the default value,
  // targeting a 2-bit vector, to demonstrate multiple occurrences of the violation.
  assign output_vec_C = '{1: data_in_e, 0: data_in_f, default: 1'b1};

endmodule
