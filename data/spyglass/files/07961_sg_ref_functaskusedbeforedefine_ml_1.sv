module func_before_define_ex1;
 reg [7:0] data_out;
 initial begin data_out = my_func(8'hAA);
 end function [7:0] my_func;
 input [7:0] in_data;
 begin my_func = in_data + 1;
 end endfunction endmodule
