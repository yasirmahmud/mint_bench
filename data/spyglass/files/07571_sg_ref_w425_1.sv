module W425_ex1;
 reg global_var;
 function integer my_func;
 input dummy_in;
 begin my_func = global_var ? 1 : 0;
 end endfunction initial begin global_var = 1'b1;
 $display("Result: %0d", my_func(0));
 end endmodule
