module top_ex1(input wire in_1bit, output wire out_1bit);
 function [0:0] my_func;
 input [1:0] func_in;
 my_func = func_in[0];
 endfunction assign out_1bit = my_func(in_1bit);
 endmodule
