module sub_module (
  input wire [3:0] data_in, // Port declared with MSB:LSB ordering (index 3 is MSB, 0 is LSB)
  output wire [3:0] data_out
);
  // Use data_in to avoid unused signal warnings.
  assign data_out = data_in;
endmodule
