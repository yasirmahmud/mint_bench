module mux_2to1 #(parameter WIDTH = 8) (
  input [WIDTH-1:0] a, b,
  input select,
  output [WIDTH-1:0] out
);
  assign out = select ? b : a;
endmodule
