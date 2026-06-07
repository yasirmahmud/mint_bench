module module_ex2(input a, output reg b, output reg global_sig);
 function integer my_func;
 input [7:0] data_in;
 begin global_sig = data_in + 1;
 my_func = data_in * 2;
 end endfunction always @(*) begin b = my_func(a);
 end endmodule
