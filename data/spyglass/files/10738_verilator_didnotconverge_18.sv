module osc18;
  wire a, b;
  assign a = b;
  assign b = a;
  initial $monitor("a=%b, b=%b", a, b);
endmodule
