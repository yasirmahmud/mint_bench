module onebit_onehot_violation_1 (
  input wire clk,
  input wire rst_n,
  input wire single_bit_in,
  output wire result
);

  assign result = $onehot(single_bit_in);

endmodule
