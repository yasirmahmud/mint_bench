module const_write_12;
  int x;
  initial begin
    x = 1;
    if (1) x = 2;
  end
endmodule
