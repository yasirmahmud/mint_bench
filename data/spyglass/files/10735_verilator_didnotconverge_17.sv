module osc17;
  wire a, b;
  always @* begin
    a = ~b;
    b = ~a;
  end
endmodule
