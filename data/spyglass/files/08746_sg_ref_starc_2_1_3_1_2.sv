module my_module_ex2(input [0:0] in_1bit, output [2:0] out_3bit);
 function [2:0] my_func;
 input [2:0] in_arg;
 my_func = in_arg;
 endfunction assign out_3bit = my_func(in_1bit << 3);
 endmodule
