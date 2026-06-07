module sub_module_w156_attempt9 (
  input [7:0] data_in, // Standard MSB-to-LSB indexing for the port
  output [7:0] data_out
);
  // Assigning input to output to ensure data_in is used and avoid unused signal warnings
  assign data_out = data_in;
endmodule
