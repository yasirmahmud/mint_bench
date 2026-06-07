module curve_stx_ve_462_20260111_191310_835981_w36056_attempt8 (
  input wire clk, // Dummy input to avoid empty module warnings
  output wire [15:0] out_element0,
  output wire [15:0] out_element1,
  output wire [15:0] out_element2
);

  // Declare an unpacked array of 3 elements, each 16-bit wide.
  // In Verilog-2001, continuous assignments to unpacked arrays require
  // assigning to individual elements, not the entire array using a concatenation.
  wire [15:0] unpacked_data_vec [0:2];

  // STX_VE_462 violation: Illegal assignment, expecting assignment pattern.
  // Assigning a bit-stream concatenation of values directly to the unpacked array
  // 'unpacked_data_vec' is not allowed in Verilog-2001. SystemVerilog (with SV09 option)
  // supports such assignments using an assignment pattern (e.g., '{16'h1111, 16'h2222, 16'h3333}').
  assign unpacked_data_vec = {16'h1111, 16'h2222, 16'h3333}; // Triggers STX_VE_462

  // Use elements of the unpacked array to avoid unused wire warnings for these elements.
  assign out_element0 = unpacked_data_vec[0];
  assign out_element1 = unpacked_data_vec[1];
  assign out_element2 = unpacked_data_vec[2];

endmodule
