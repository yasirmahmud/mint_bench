module ex1;
  reg a;
  always @* begin
    a = 1'b1;
    a <= 1'b0;
  end
endmodule
