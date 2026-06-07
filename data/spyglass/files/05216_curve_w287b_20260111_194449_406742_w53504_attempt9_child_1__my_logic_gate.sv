module my_logic_gate (
  input i_a,
  input i_b,
  output o_and,
  output o_xor
);
  assign o_and = i_a & i_b;
  assign o_xor = i_a ^ i_b;
endmodule
