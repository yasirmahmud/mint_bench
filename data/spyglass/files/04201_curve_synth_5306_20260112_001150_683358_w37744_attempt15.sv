module curve_synth_5306_20260112_001150_683358_w37744_attempt15 (
  input wire clk,
  input wire rst,
  input wire enable_task,
  output reg [7:0] data_out
);

  reg [7:0] internal_data;

  // Task 1: A task that increments a register
  task update_data_task;
    begin
      internal_data = internal_data + 1'b1;
    end
  endtask

  // Task 2: This task attempts to disable 'update_data_task'
  task disable_task_caller;
    begin
      // SYNTH_5306 violation: 'update_data_task' is a module-level task and is
      // not in the lexical scope of 'disable_task_caller'. A task cannot
      // disable another task at the same module level.
      disable update_data_task;
    end
  endtask

  always @(posedge clk) begin
    if (!rst) begin
      internal_data <= 8'h0;
    end else if (enable_task) begin
      // Call the task that attempts to disable another task
      disable_task_caller;
    end
    data_out <= internal_data;
  end

endmodule
