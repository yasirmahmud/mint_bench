module example_02(input a, input b, output reg out);
  always @* begin
    if (out = a + b)
      out = 1'b1;
  end
endmodule
