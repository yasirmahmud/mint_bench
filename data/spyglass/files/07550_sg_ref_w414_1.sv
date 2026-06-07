module W414_ex1(input in1, in2, in3, in4, output reg out1, out2);
 always @* begin out1 <= in1 & in2;
 out2 = in3 & in4;
 end endmodule
