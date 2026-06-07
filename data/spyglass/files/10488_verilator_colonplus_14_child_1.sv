module test14;
  logic [7:0] vector_a;
  logic [7:0] vector_b;
  assign vector_a[0 +: 4] = vector_b[4 +: 4];
endmodule
