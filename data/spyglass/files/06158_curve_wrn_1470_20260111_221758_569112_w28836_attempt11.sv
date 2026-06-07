module curve_wrn_1470_20260111_221758_569112_w28836_attempt11 (
  input wire in_a_bit,
  input wire in_b_bit,
  input wire in_c_bit,
  input wire in_d_bit,
  input wire in_e_bit,
  input wire in_f_bit,
  output wire [2:0] out_vec0,
  output wire [1:0] out_vec1,
  output wire [3:0] out_vec2
);

  // WRN_1470 #1: This assignment pattern uses explicit integer keys (0, 2)
  // which is a SystemVerilog construct not supported in Verilog-2001.
  assign out_vec0 = '{0: in_a_bit, 2: in_b_bit, default: 1'b0};

  // WRN_1470 #2: Another instance of the unsupported array pattern keys,
  // assigning to a smaller vector and using an input for the default value.
  assign out_vec1 = '{1: in_c_bit, default: in_d_bit};

  // WRN_1470 #3: A third distinct usage, demonstrating different key order
  // and target vector size, still unsupported in Verilog-2001.
  assign out_vec2 = '{3: in_e_bit, 0: in_f_bit, default: 1'b1};

endmodule
