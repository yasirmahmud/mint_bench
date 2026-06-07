module star_ex2;
 reg global_sig;
 function integer my_func;
 input a;
 begin my_func = a + global_sig;
 end endfunction;
 endmodule
