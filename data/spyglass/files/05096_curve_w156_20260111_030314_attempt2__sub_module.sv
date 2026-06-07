module sub_module (
  input [3:0] data_in, // Port declared with MSB:LSB (index 3 is MSB, 0 is LSB)
  output wire [3:0] data_out
);
  // Simple pass-through logic to use the input and drive the output
  assign data_out = data_in;
endmodule
