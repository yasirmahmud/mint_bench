module example_05(input [1:0] a, input [1:0] b, output reg [1:0] out);
  always @* begin
    if (out = a + b)
      out = a;
  end
endmodule
