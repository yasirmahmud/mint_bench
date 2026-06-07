module module_tsk_nr_asgv_1;
  reg global_signal_a;

  task my_task_assign_global;
    // This task assigns to global_signal_a, which is declared outside the task.
    global_signal_a = 1'b1;
  endtask

  initial begin
    global_signal_a = 1'b0;
    my_task_assign_global();
    $display("global_signal_a = %b", global_signal_a);
  end
endmodule
