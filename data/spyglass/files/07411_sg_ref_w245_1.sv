module w245_ex1(input a, input b, output reg out);
 always @(a || b) begin out = a & b;
 end endmodule
