module ex4(input sel);
  reg d;
  always @* begin
    if (sel) d = 1'b1;
    else d <= 1'b0;
  end
endmodule
