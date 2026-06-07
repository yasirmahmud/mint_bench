module example_04;
  reg e;
  reg f;
  always @* begin
    e = #1 f;
  end
endmodule
