module W424_ex1;
 reg global_var;

 // Fix for W424: Function should not set a global variable.
 // The function is made pure, returning its input value.
 function automatic int my_func;
  input int dummy_in;
  begin
  // global_var = dummy_in; // Removed to resolve W424
  my_func = dummy_in;
  end
 endfunction

 initial begin
  global_var = 0;
  // Fix for WRN_1455: Invalid void function call of function with non-void return type.
  // The return value of my_func is now assigned to global_var.
  global_var = my_func(5);
  // Fix for W528: Variable 'global_var' set but not read.
  // Adding a display statement to read the variable for simulation.
  $display("Time: %0t, global_var after my_func(5) call: %0d", $time, global_var);
 end

endmodule
