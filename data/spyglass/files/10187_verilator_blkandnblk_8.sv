module ex8;
  reg h;
  always @* begin
    h = 1'b1;
  end
  always @* begin
    h <= 1'b0;
  end
endmodule
