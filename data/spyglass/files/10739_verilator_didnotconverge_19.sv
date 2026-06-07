module osc19;
  wire a, b, c;
  assign a = b & c;
  assign b = a;
  assign c = 1'b1;
endmodule
