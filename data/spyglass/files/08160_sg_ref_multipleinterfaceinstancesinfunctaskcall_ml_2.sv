interface my_if;
 logic data;
 endinterface module top_ex2;
 my_if if_inst();
 function void my_func(my_if arg1, my_if arg2);
 endfunction initial begin my_func(if_inst, if_inst);
 end endmodule
