module curve_synth_196_20260111_224544_578207_w28836_attempt11 (
  input wire clk,
  input wire rst_n,
  input wire task_trigger_in, // Input to control the 'wait' in the task
  output reg task_output_reg // Module output to show task influence
);

  // Task containing an event control statement.
  // This will trigger the SYNTH_196 violation.
  task my_violating_task;
    input wire condition_check; // Input for the wait condition
    output reg completion_flag; // Output from task to signal completion
    
    // SYNTH_196 violation: The 'wait' statement is an event control within a task.
    // This is distinct from previous examples that used @(posedge clk) or @(negedge clk).
    wait (condition_check == 1'b1); // Wait until 'condition_check' becomes true
    
    // After the wait, set the completion flag.
    completion_flag = 1'b1; // Blocking assignment within task
  endtask

  // Local variable to capture the task's completion status.
  reg task_internal_completion;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      task_output_reg <= 1'b0;
      task_internal_completion <= 1'b0; // Reset the internal flag
    end else begin
      // Call the task, passing module input and capturing task output.
      // The actual violation is in the task definition.
      my_violating_task(task_trigger_in, task_internal_completion);
      
      // Assign module output based on task's completion status.
      // This ensures 'task_output_reg' is always driven from this 'always' block,
      // avoiding latches and multiple drivers. It also ensures all inputs/outputs are used.
      task_output_reg <= task_internal_completion;
    end
  end

endmodule
