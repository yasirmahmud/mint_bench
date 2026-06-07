module my_module_1 (
  input a,
  output b,
  input c
);

  input a;
  input c; // 'c' is declared before 'b' here, but 'b' was before 'c' in the port list
  output b;

  assign b = a & c;

endmodule
