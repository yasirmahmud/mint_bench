module top_not_violation (
  input [1:0] in_a,
  output out_z
);
  not (out_z, in_a);
endmodule
