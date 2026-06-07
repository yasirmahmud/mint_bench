module another_module (
  input wire in_a,
  input wire in_b,
  output wire out_c
);
  // This is a redefinition of another_module
  assign out_c = in_a | in_b;
endmodule
