// Definition for four_bit_adder to resolve the black-box error.
// The port order is chosen to match the positional instantiations in BCD_adder.
module four_bit_adder(
  input [3:0] A_in,
  input [3:0] B_in,
  input C_in,
  output [3:0] S_out,
  output C_out
);
  wire c[3:0]; // Internal carries for each bit
  
  // Bit 0 Full Adder
  assign S_out[0] = A_in[0] ^ B_in[0] ^ C_in;
  assign c[0] = (A_in[0] & B_in[0]) | (C_in & (A_in[0] ^ B_in[0]));

  // Bit 1 Full Adder
  assign S_out[1] = A_in[1] ^ B_in[1] ^ c[0];
  assign c[1] = (A_in[1] & B_in[1]) | (c[0] & (A_in[1] ^ B_in[1]));

  // Bit 2 Full Adder
  assign S_out[2] = A_in[2] ^ B_in[2] ^ c[1];
  assign c[2] = (A_in[2] & B_in[2]) | (c[1] & (A_in[2] ^ B_in[2]));

  // Bit 3 Full Adder
  assign S_out[3] = A_in[3] ^ B_in[3] ^ c[2];
  assign C_out = (A_in[3] & B_in[3]) | (c[2] & (A_in[3] ^ B_in[3]));
endmodule
