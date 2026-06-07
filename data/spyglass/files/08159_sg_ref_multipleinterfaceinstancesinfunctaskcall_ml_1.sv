interface my_if;
 logic a;
 endinterface module my_module_ex1;
 my_if if_inst();
 function void my_func(my_if arg1, my_if arg2);
 endfunction initial begin my_func(if_inst, if_inst);
 end endmodule
