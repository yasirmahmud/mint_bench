module top_ex1;
 wire [3:0] actual_output;
 integer dummy_ret;
 function integer my_func;
 input [7:0] formal_output;
 input integer in_val;
 begin
 // The original line "formal_output = in_val + 1;" is illegal for an input port
 // and function arguments cannot be declared as 'output' in Verilog-2005.
 // Removing this assignment resolves the linting violation while preserving
 // the function's return value computation.
 my_func = in_val * 2;
 end
 endfunction
 assign dummy_ret = my_func(actual_output, 5);
 endmodule
