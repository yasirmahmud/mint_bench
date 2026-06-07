module curve_wrn_1470_20260111_182046_011163_w37940_attempt10 (
  input wire in_a,
  input wire in_b,
  input wire in_c,
  output wire [2:0] out_vec0,
  output wire [2:0] out_vec1,
  output wire [2:0] out_vec2
);

  // WRN_1470 #1: The construct 'array pattern keys in assignment patterns
  // '{ 0:val ,1:1'b0} ' is not supported in some tools.
  // This continuous assignment uses a SystemVerilog assignment pattern
  // with explicit integer keys and a 'default' key to assign to a packed vector.
  assign out_vec0 = '{0: in_a, 2: in_b, default: 1'b0};

  // WRN_1470 #2: Another instance of the unsupported array pattern key construct.
  // This assignment uses a different set of explicit keys and a default value
  // derived from an input signal.
  assign out_vec1 = '{1: in_b, default: in_c};

  // WRN_1470 #3: A third distinct instance of the array pattern key construct.
  // This assignment varies the key order and the default value to demonstrate
  // multiple occurrences of the violation.
  assign out_vec2 = '{2: in_c, 0: in_a, default: 1'b1};

endmodule
