module curve_wrn_59_20260110_135421_attempt3;
  reg my_signal;

  task my_sim_task;
    // WRN_59: System function ($countdrivers) specified when a system task was expected in this context
    $countdrivers(my_signal);
  endtask

endmodule
