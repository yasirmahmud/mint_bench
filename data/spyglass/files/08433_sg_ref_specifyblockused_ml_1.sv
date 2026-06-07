module SpecifyBlockUsed_ex1(in1, out1);
 input in1;
 output out1;
 assign out1 = in1;
 specify (in1 => out1) = 1;
 endspecify endmodule
