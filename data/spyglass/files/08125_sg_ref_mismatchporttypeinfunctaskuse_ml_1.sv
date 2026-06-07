module top_ex1;
 wire [3:0] actual_output;
 integer dummy_ret;
 function integer my_func;
 output reg [7:0] formal_output;
 input integer in_val;
 begin formal_output = in_val + 1;
 my_func = in_val * 2;
 end endfunction assign dummy_ret = my_func(actual_output, 5);
 endmodule
