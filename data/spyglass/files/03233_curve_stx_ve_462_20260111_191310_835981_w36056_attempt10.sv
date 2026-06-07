module curve_stx_ve_462_20260111_191310_835981_w36056_attempt10 (
  output wire [7:0] out_0,
  output wire [7:0] out_1,
  output wire [7:0] out_2,
  output wire [7:0] out_3
);

  // Declare an unpacked array of 4 elements, each 8-bit wide.
  wire [7:0] my_unpacked_data [0:3];

  // STX_VE_462 violation: Illegal assignment, expecting assignment pattern.
  // In Verilog-2001, assigning a packed concatenation directly to an
  // unpacked array is not permitted. The right-hand side `{8'h11, 8'h22, 8'h33, 8'h44}`
  // forms a packed 32-bit vector, which cannot be directly assigned to the
  // unpacked array 'my_unpacked_data' (which is conceptually 4 separate 8-bit wires).
  assign my_unpacked_data = {8'h11, 8'h22, 8'h33, 8'h44}; // Triggers STX_VE_462

  // Use elements of the unpacked array to avoid unused wire warnings.
  assign out_0 = my_unpacked_data[0];
  assign out_1 = my_unpacked_data[1];
  assign out_2 = my_unpacked_data[2];
  assign out_3 = my_unpacked_data[3];

endmodule
