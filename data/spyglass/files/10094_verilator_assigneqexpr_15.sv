module example_15(input [1:0] a, input [1:0] b, output reg out);
  always @* begin
    if (a[0] = b[1])
      out = 1'b1;
  end
endmodule
