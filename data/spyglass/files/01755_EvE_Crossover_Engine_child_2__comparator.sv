// Helper module definitions to resolve black-box violations
module comparator #(parameter WIDTH = 8) (
  input [WIDTH-1:0] a, b,
  output equal,
  output lower,
  output greater
);
  assign equal = (a == b);
  assign lower = (a < b);
  assign greater = (a > b);
endmodule
