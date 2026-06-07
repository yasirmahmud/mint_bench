interface my_if;
 logic data;
endinterface

module top_ex2;
 my_if if_inst();

 task my_func(my_if arg1, my_if arg2);
  // Task body is empty as in original design
 endtask

 initial begin
  my_func(if_inst, if_inst);
 end
endmodule
