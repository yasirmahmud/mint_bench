module W424_ex1;
 reg global_var;
 function automatic int my_func;
 input int dummy_in;
 begin global_var = dummy_in;
 my_func = dummy_in;
 end endfunction initial begin global_var = 0;
 my_func(5);
 end endmodule
