module ex5;
  reg e;
  initial begin
    e = 1'b1;
    #1 e <= 1'b0;
  end
endmodule
