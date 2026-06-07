module example_01(input a, input b, output reg out);
  always @* begin
    if (out = a)
      out = b;
  end
endmodule
