module my_module (in_a, out_b);
  input in_a;
  output out_b;
  input in_a; // Redeclaration of in_a
  assign out_b = in_a;
endmodule
