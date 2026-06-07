// four_bit_adder module definition
module four_bit_adder (input [3:0] A_in, B_in, input Cin_in, output [3:0] Sum_out, output Cout_out);
  // Implementation of a 4-bit ripple-carry adder
  wire c[3:0]; // internal carries
  
  full_adder FA0 (Sum_out[0], c[0], A_in[0], B_in[0], Cin_in);
  full_adder FA1 (Sum_out[1], c[1], A_in[1], B_in[1], c[0]);
  full_adder FA2 (Sum_out[2], c[2], A_in[2], B_in[2], c[1]);
  full_adder FA3 (Sum_out[3], c[3], A_in[3], B_in[3], c[2]);
  
  assign Cout_out = c[3];
endmodule
