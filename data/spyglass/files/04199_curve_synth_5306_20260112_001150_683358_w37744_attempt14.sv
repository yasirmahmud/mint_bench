module curve_synth_5306_20260112_001150_683358_w37744_attempt14 (
  input wire clk,
  input wire rst,
  input wire enable_counter,
  input wire trigger_disable_action,
  output reg [7:0] counter_out
);

  reg [7:0] my_counter;

  // This is a named block for a synchronous counter
  always @(posedge clk) begin : synchronous_counter_block
    if (!rst) begin
      my_counter <= 8'h00;
    end else if (enable_counter) begin
      my_counter <= my_counter + 1'b1;
    end
  end

  // A module-level task that attempts to disable a block
  task disable_target_task;
    begin
      // SYNTH_5306 violation: 'synchronous_counter_block' is not in the lexical scope
      // of 'disable_target_task'. The task cannot disable a named block defined
      // within a separate always statement at the same module level.
      disable synchronous_counter_block;
    end
  endtask

  // This always block calls the task
  always @(posedge clk) begin
    if (trigger_disable_action) begin
      disable_target_task; // Call the task which contains the 'disable' statement
    end
    counter_out <= my_counter;
  end

endmodule
