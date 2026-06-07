macromodule my_macro_ex2(in1, out1);
 input in1;
 output out1;
 assign out1 = in1;
 endmacromodule module top_ex2();
 wire a, b;
 my_macro_ex2 T1(.in1(a), .out1(b));
 endmodule
