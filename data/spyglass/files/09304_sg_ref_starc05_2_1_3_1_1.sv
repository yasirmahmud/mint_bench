module top_ex1(input [3:0] data_in, output [1:0] data_out);
 function [1:0] my_func;
 input [1:0] in_arg;
 begin my_func = in_arg;
 end endfunction assign data_out = my_func(data_in);
 endmodule
