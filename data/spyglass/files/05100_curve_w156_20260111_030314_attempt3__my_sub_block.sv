module my_sub_block (
  input wire [4:0] input_data_port, // Port declared with MSB:LSB (index 4 is MSB, 0 is LSB)
  output wire [4:0] output_data_port
);
  // Simple pass-through logic to use the input and drive the output
  assign output_data_port = input_data_port;
endmodule
