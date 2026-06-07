module curve_wrn_1470_20260111_182046_011163_w37940_attempt6 (
  input wire i_val,
  output wire [3:0] o_vec
);

  // WRN_1470: The construct 'array pattern keys in assignment patterns
  // '{ 0:val ,1:1'b0} ' is not supported in some tools.
  // This assignment pattern using explicit index keys and 'default'
  // is a SystemVerilog feature and will trigger WRN_1470 when compiled as Verilog-2001.
  assign o_vec = '{1: i_val, default: 1'b0};

endmodule
