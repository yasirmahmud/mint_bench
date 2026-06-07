module ex20;
  reg t;
  always @* begin
    t = 1'b1;
  end
  initial begin
    #1 t <= 1'b0;
  end
endmodule
