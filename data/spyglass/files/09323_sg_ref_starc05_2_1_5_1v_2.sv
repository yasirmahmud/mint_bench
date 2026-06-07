module my_module_ex2 (input cond1, input cond2, input cond3, input cond4, input cond5, input cond6, input [7:0] val1, input [7:0] val2, input [7:0] val3, input [7:0] val4, input [7:0] val5, input [7:0] val6, input [7:0] default_val, output [7:0] out);
 assign out = cond1 ? val1 : (cond2 ? val2 : (cond3 ? val3 : (cond4 ? val4 : (cond5 ? val5 : (cond6 ? val6 : default_val))))));
 endmodule
