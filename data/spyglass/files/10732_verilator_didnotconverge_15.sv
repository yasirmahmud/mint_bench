module osc15;
  wire a, b, c, d;
  assign a = ~b;
  assign b = ~c;
  assign c = ~d;
  assign d = ~a;
endmodule
