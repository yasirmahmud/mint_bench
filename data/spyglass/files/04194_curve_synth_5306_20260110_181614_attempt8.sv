module curve_synth_5306_20260110_181614_attempt8 (
  input clk,
  input rst,
  output reg [7:0] counter_out
);

  reg [7:0] counter; // Declared and used to avoid implicit net and unused signal

  // Define a module-level task. Tasks are callable from anywhere in the module.
  task increment_counter_task;
    input [7:0] increment_value;
    begin // This block is implicitly named 'increment_counter_task' when the task is called
      counter <= counter + increment_value; // Use the task input and update internal 'counter'
    end
  endtask

  // This always block calls the task, making it active during its execution.
  always @(posedge clk) begin : main_sequential_block // Named block for clarity, though not directly disabled
    if (rst) begin
      counter <= 8'h00; // Reset counter synchronously
    end else begin
      increment_counter_task(1); // Call the task to increment counter by 1
    end
  end

  // This separate always block attempts to disable the 'increment_counter_task'.
  // According to Verilog scope rules for 'disable', a task or named block
  // must be currently active and within the lexical scope of the 'disable'
  // statement or any of its enclosing block statements/tasks/functions.
  // Since 'increment_counter_task' is called within 'main_sequential_block'
  // (a parallel always block), it is not within the lexical scope of *this*
  // always block's statements for the purpose of a 'disable' statement.
  // This triggers the SYNTH_5306 violation.
  always @(negedge clk) begin
    if (!rst) begin
      disable increment_counter_task; // SYNTH_5306 violation: 'increment_counter_task' is not in the lexical scope of this disable statement
    end
  end

  assign counter_out = counter; // Assign to output to avoid unused signal warnings

endmodule
