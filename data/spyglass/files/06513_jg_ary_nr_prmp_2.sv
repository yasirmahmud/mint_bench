module top_and_violation (
  input [1:0] in_a,
  input in_b,
  output out_z
);
  and (out_z, in_a, in_b);
endmodule
