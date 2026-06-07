module example_10(input a, input b, output reg out);
  always @* begin
    if (a = ~b)
      out = 1'b1;
  end
endmodule
