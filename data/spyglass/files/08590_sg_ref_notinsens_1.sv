module notin_sens_ex1(in1, in2, out1);
 input in1, in2;
 output out1;
 reg out1;
 always @(in1) out1 = in1 & in2;
 endmodule
