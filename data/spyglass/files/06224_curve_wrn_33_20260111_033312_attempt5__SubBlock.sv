module SubBlock (
  input wire in_a,
  input wire in_b,
  output wire out_xor
);
  assign out_xor = in_a ^ in_b;
endmodule
