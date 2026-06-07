module curve_synth_196_20260111_224544_578207_w28836_attempt12 (
  input clk,
  input rst_n,
  input task_trigger_in, // Input to control the 'wait' in the task
  output reg module_output // Module output for general use
);

  // Task containing an event control statement.
  // This will trigger the SYNTH_196 violation.
  task my_violating_task;
    input task_input_arg; // Task input to be used in the 'wait' condition
    
    // SYNTH_196 violation: The 'wait' statement is an event control within a task.
    // This is distinct from previous examples that used @(posedge clk) or @(negedge clk).
    // This example specifically fixes the syntax and multiple driver issues of attempt 11.
    wait (task_input_arg == 1'b1); // Wait until 'task_input_arg' becomes true
    
    // No further action in the task for minimality and to avoid other violations.
  endtask

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      module_output <= 1'b0;
    end else begin
      // Call the task. The task itself contains the SYNTH_196 violation.
      // We pass 'task_trigger_in' to the task to ensure it's used and avoid unused signal warnings.
      // The task's blocking nature (due to 'wait') will suspend this always block's execution
      // until the wait condition is met, leading to the synthesis issue.
      my_violating_task(task_trigger_in);
      
      // Drive 'module_output' based on an input to avoid latches and ensure it's always driven.
      // This signal is not directly affected by the task's completion to prevent multiple driver issues.
      module_output <= task_trigger_in;
    end
  end

endmodule
