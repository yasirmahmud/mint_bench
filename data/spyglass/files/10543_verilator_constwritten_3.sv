module const_write_3;
  const real pi = 3.14;
  initial begin
    #10 pi = 3.14159;
  end
endmodule
