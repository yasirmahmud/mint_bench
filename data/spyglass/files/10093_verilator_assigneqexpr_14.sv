module example_14(input a, input b, output reg out);
  always @* begin
    if (a = b >> 1)
      out = 1'b1;
  end
endmodule
