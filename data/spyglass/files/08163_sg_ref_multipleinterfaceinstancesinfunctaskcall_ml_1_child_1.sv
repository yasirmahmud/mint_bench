interface my_if;
 logic a;
endinterface;

module my_module_ex1;
 my_if if_inst();

 task my_func(my_if arg1, my_if arg2);
  // Task body would go here if needed
 endtask;

 initial begin
  my_func(if_inst, if_inst);
 end
endmodule
