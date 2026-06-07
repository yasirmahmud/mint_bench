module nmos_example (
  input in_a,
  output out_z
);
  nmos (out_z, in_a, 1'b1);
endmodule
