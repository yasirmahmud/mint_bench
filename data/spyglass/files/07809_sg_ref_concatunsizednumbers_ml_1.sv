module ConcatUnsizedNumbers_ex1(input in1, output [32:0] out);
 assign out = {in1, 1};
 endmodule
