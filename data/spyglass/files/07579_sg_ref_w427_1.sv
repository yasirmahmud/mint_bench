module W427_ex1;
 reg global_var;
 task my_task;
 begin $display("Global var value: %b", global_var);
 end endtask initial begin global_var = 1'b0;
 my_task;
 end endmodule
