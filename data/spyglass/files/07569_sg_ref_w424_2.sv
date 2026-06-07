module W424_ex2;
 reg global_var;
 function void my_func;
 input dummy_in;
 begin global_var = dummy_in;
 end endfunction initial begin my_func(1'b0);
 end endmodule
