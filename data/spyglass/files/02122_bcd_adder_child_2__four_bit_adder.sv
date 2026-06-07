// four_bit_adder module definition to resolve black-box violation
module four_bit_adder(
  input [3:0] A_in, B_in,
  input C_in,
  output [3:0] S_out,
  output C_out
);
  wire [4:0] sum_tmp;
  assign sum_tmp = A_in + B_in + C_in;
  assign S_out = sum_tmp[3:0];
  assign C_out = sum_tmp[4];
endmodule
