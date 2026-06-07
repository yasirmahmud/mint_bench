module FNC_NR_NARG_example2();

  task automatic my_task(input int val);
    $display("Task received: %0d", val);
  endtask

  initial begin
    // Calling my_task with the correct number of arguments (expected 1, got 1)
    my_task(10);
  end

endmodule
