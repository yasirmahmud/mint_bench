module my_sub_block (
  output wire [4:0] data_out // Port declared with MSB:LSB ordering (index 4 is MSB, 0 is LSB)
);
  // Drive the output to ensure it is used and avoid W528 (variable set but not read).
  assign data_out = 5'b10101;
endmodule
