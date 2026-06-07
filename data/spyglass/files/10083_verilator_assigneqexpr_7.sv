module example_07(input a, input b, output reg out);
  always @* begin
    while (a = b) begin
      out = 1'b1;
      break;
    end
  end
endmodule
