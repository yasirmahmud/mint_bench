module mod_ex1;
 parameter P = 10;
 task my_task;
  reg task_P_value; // Declare a local variable within the task scope
 begin
  task_P_value = P; // Optionally initialize with the parameter's value
  task_P_value = 20; // Assign to the local variable, as parameters cannot be modified procedurally
 end
 endtask
endmodule
