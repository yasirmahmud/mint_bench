module FNC_NR_NARG_example2();

  task automatic my_task(input int val);
    $display("Task received: %0d", val);
  endtask

  initial begin
    // Calling my_task with too many arguments (expected 1, got 2)
    my_task(10, 20);
  end

endmodule
