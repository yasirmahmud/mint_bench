module mod_ex1;
 parameter P = 10;
 task my_task;
  reg task_P_value; // Declare a local variable within the task scope
 begin
  task_P_value = P; // Optionally initialize with the parameter's value
  task_P_value = 20; // Assign to the local variable, as parameters cannot be modified procedurally
  $display("Task local variable task_P_value after assignment: %0d", task_P_value); // Read the variable to resolve W528
 end
 endtask
endmodule
