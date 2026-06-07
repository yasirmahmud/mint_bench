module curve_stx_ve_462_20260111_223237_186320_w38092_attempt11 (
  input wire [3:0] in_pattern,
  output wire out_bit_array_0,
  output wire out_bit_array_1,
  output wire out_bit_array_2,
  output wire out_bit_array_3
);

  // Declare an unpacked array of 1-bit wires. In Verilog-2001,
  // this is treated as 'wire unpacked_bits_0, unpacked_bits_1, ...'.
  wire unpacked_bits [0:3];

  // This assignment attempts to assign a packed 4-bit vector (from replication)
  // to an unpacked array of 4 individual 1-bit wires. Verilog-2001 does not
  // support direct assignment of a packed type to an unpacked array. Such
  // assignments require SystemVerilog (with 'set_option enableSV09 yes')
  // using an assignment pattern (e.g., '{in_pattern[0], in_pattern[0], ...}').
  assign unpacked_bits = {4{in_pattern[0]}}; // Triggers STX_VE_462

  // Use the elements of the unpacked array to avoid unused signal warnings.
  assign out_bit_array_0 = unpacked_bits[0];
  assign out_bit_array_1 = unpacked_bits[1];
  assign out_bit_array_2 = unpacked_bits[2];
  assign out_bit_array_3 = unpacked_bits[3];

endmodule
