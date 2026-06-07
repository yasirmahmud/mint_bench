module example_10(input a, input b, output reg out);
  always @* begin
    if (a == ~b) // Changed '=' to '==' to resolve syntax error and potential logic bug.
      out = 1'b1;
  end
endmodule
