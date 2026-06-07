module logic_gate (
  input wire in_a,
  input wire in_b,
  output wire out_c
);
  assign out_c = in_a & in_b;
endmodule
