module const_write_9;
  const struct { int a; int b; } s = '{a:1, b:2};
  initial begin
    s.a = 10;
  end
endmodule
