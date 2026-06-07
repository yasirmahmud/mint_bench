module IndexSelectOnConcat_ex2(input a, input b, output out);
 assign out = {a, b}[0];
 endmodule
