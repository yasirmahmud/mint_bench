module curve_wrn_59_20260110_135421_attempt3;
  reg my_signal;

  task my_sim_task;
    // WRN_59: System function ($countdrivers) specified when a system task was expected in this context
    integer dummy_count_drivers; // Declare a local variable to store the function result
    dummy_count_drivers = $countdrivers(my_signal); // Assign the system function's result to a variable
  endtask

endmodule
