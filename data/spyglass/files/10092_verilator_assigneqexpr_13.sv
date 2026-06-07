module example_13(input a, input b, output reg out);
  assign out = (a = b << 1) ? 1'b1 : 1'b0;
endmodule
