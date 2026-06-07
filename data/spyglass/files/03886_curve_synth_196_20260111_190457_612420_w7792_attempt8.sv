module curve_synth_196_20260111_190457_612420_w7792_attempt8 (
  input wire clk,
  input wire rst_n,
  input wire [7:0] in_data,
  output reg [7:0] out_data_q
);

  // A module-level register that the task will attempt to update
  reg [7:0] task_driven_reg;

  // Define a task that contains an event control statement
  task my_event_task;
    // Input argument for the task, local to the task
    input [7:0] t_in_data;

    // This event control statement inside a task is the target for SYNTH_196.
    // It attempts to wait for a clock edge within the task's execution context,
    // which is not synthesizable for tasks.
    @(posedge clk) begin // SYNTH_196 violation expected here
      task_driven_reg = t_in_data;
    end
  endtask

  // Call the task from a sequential always block.
  // This ensures the task is elaborated and its content is analyzed by SpyGlass.
  // The task itself contains the problematic event control.
  always @(posedge clk) begin
    if (!rst_n) begin
      // No reset action for task calling logic, just ensure call happens
    end else begin
      my_event_task(in_data); // Pass input data to the task
    end
  end

  // To avoid 'unused signal' warnings for task_driven_reg and to show its effect,
  // pipeline its value to an output register.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      out_data_q <= 8'b0;
    end else begin
      out_data_q <= task_driven_reg;
    end
  end

endmodule
