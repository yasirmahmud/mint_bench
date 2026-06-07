module top_ex2 (input [1:0] in_data, output [1:0] out_data);
 function [1:0] my_func;
 input [0:0] arg_in;
 begin my_func = arg_in;
 end endfunction assign out_data = my_func(in_data);
 endmodule
