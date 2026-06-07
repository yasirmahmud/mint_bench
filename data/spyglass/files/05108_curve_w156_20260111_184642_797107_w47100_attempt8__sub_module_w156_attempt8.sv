module sub_module_w156_attempt8 (
  input [0:7] data_in, // Input port defined with LSB-to-MSB indexing
  output [7:0] data_out // Output port defined with MSB-to-LSB indexing
);
  // Assigning input to output to ensure data_in is used and avoid unused signal warnings
  assign data_out = data_in;
endmodule
