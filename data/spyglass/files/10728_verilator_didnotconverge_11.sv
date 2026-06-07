module osc11;
  wire a, b;
  assign a = (a & b) | (~a & ~b);
  assign b = a;
endmodule
