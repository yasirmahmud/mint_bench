module example_06(input a, input b, output reg out);
  always @* begin
    case (a = b)
      1'b1: out = 1'b1;
      default: out = 1'b0;
    endcase
  end
endmodule
