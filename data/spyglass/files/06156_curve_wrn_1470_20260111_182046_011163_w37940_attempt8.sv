module curve_wrn_1470_20260111_182046_011163_w37940_attempt8 (
  input wire in_a,
  input wire in_b,
  output wire [3:0] out_vec
);

  // Declare a 4-bit packed wire vector.
  wire [3:0] my_vector;

  // WRN_1470: The construct 'array pattern keys in assignment patterns
  // '{ 0:val ,1:1'b0} ' is not supported in some tools.
  // This continuous assignment uses a SystemVerilog assignment pattern
  // with explicit integer keys (0, 2) and a 'default' key to assign to a packed vector.
  // This construct is not supported in Verilog-2001 and will trigger WRN_1470.
  assign my_vector = '{0: in_a, 2: in_b, default: 1'b0};

  // Assign to output to avoid unused signal warnings for my_vector
  assign out_vec = my_vector;

endmodule
