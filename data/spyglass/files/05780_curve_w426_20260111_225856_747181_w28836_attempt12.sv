module curve_w426_20260111_225856_747181_w28836_attempt12 ();

  // Declare a module-level (global) register.
  reg [3:0] global_data_reg;

  // Define a task that attempts to modify the global_data_reg.
  // This direct assignment to a module-scoped variable from within a task
  // is the direct cause of the W426 violation.
  task set_global_data;
    global_data_reg = 4'hA; // W426: Global variable 'global_data_reg' should not be 'set' in task
  endtask

  // Call the task from an initial block.
  // Using an initial block avoids inferring sequential logic, thereby preventing
  // rules like W336 (blocking assignment in sequential block) which occurred in previous attempts.
  initial begin
    global_data_reg = 4'h0; // Initial assignment for clarity, immediately overwritten by task
    set_global_data;        // This task call causes the W426 violation
  end

endmodule
