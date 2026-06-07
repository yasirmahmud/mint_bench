module curve_synth_196_20260111_070206_attempt5 (
  input wire clk,
  input wire rst_n,
  input wire enable_task,
  input wire data_in,
  output reg data_out
);

  // Task definition that includes an event control statement, triggering SYNTH_196.
  task my_event_controlled_task;
    input task_enable_i;
    output reg task_flag_o; // Output to ensure the task has an observable effect

    begin
      if (task_enable_i) begin
        // SYNTH_196 violation: Event control statement inside a task.
        // This placement within an 'if' block makes it distinct.
        @(posedge clk); // This line causes the SYNTH_196 violation.
        task_flag_o = 1'b1; // Assign value after event
      end else begin
        task_flag_o = 1'b0;
      end
    end
  endtask

  reg task_output_flag; // Internal signal to capture task output

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 1'b0;
      task_output_flag <= 1'b0;
    end else begin
      // Call the task. Its internal event control will trigger the violation.
      my_event_controlled_task(enable_task, task_output_flag);
      // Use data_in and task_output_flag to prevent unused signal warnings
      data_out <= data_in ^ task_output_flag;
    end
  end

endmodule
