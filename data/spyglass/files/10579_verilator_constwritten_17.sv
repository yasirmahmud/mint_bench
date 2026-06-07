module const_write_17;
  const int counter = 0;
  initial begin
    fork
      counter = 1;
    join
  end
endmodule
