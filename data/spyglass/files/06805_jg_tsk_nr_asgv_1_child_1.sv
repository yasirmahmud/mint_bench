module module_tsk_nr_asgv_1;
  reg global_signal_a;

  // Fix for W426: Changed the task to a function to avoid direct assignment
  // to a global variable within the task/function body. The function now
  // returns the value, which is then assigned to the global variable outside.
  function reg get_value_for_global;
    get_value_for_global = 1'b1; // Assign to the function's return value
  endfunction

  initial begin
    global_signal_a = 1'b0;
    // Call the function and assign its return value to global_signal_a.
    // This resolves the linting violation W426 by not setting a global
    // variable directly within the task/function.
    global_signal_a = get_value_for_global();
    $display("global_signal_a = %b", global_signal_a);
  end
endmodule
