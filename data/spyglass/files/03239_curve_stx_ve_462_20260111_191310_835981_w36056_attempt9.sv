module curve_stx_ve_462_20260111_191310_835981_w36056_attempt9 (
  input wire clk,
  input wire [3:0] in_data,
  output wire [3:0] out_0,
  output wire [3:0] out_1,
  output wire [3:0] out_2,
  output wire [3:0] out_3,
  output wire [3:0] out_4,
  output wire [3:0] out_5,
  output wire [3:0] out_6,
  output wire [3:0] out_7
);

  // Declare an unpacked array of 8 elements, each 4-bit wide.
  wire [3:0] my_unpacked_array [0:7];

  // STX_VE_462 violation: Illegal assignment, expecting assignment pattern.
  // In Verilog-2001, assigning a replication or concatenation directly to an
  // unpacked array is not permitted. The right-hand side `{8{in_data}}`
  // forms a packed 32-bit vector, which cannot be directly assigned to the
  // unpacked array 'my_unpacked_array' (which is conceptually 8 separate 4-bit wires).
  assign my_unpacked_array = {8{in_data}}; // Triggers STX_VE_462

  // Use elements of the unpacked array to avoid unused wire warnings.
  assign out_0 = my_unpacked_array[0];
  assign out_1 = my_unpacked_array[1];
  assign out_2 = my_unpacked_array[2];
  assign out_3 = my_unpacked_array[3];
  assign out_4 = my_unpacked_array[4];
  assign out_5 = my_unpacked_array[5];
  assign out_6 = my_unpacked_array[6];
  assign out_7 = my_unpacked_array[7];

endmodule
