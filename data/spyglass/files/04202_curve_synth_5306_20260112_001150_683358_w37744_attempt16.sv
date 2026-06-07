module curve_synth_5306_20260112_001150_683358_w37744_attempt16 (
  input wire clk,
  input wire rst,
  input wire enable_disable_task,
  output reg [7:0] out_data
);

  reg [7:0] counter;

  // Named always block at the module level
  always @(posedge clk) begin : counter_increment_block
    if (!rst) begin
      counter <= 8'h0;
    end else begin
      counter <= counter + 1'b1;
    end
  end

  // Task at the module level that attempts to disable 'counter_increment_block'
  task disable_control_task;
    begin
      // SYNTH_5306 violation: 'counter_increment_block' is a named always block
      // at the module level. It is not in the lexical scope of 'disable_control_task'.
      // A task cannot disable a named block at the same module level.
      disable counter_increment_block;
    end
  endtask

  // Main control logic to call the task
  always @(posedge clk) begin
    if (!rst) begin
      // Reset out_data
      out_data <= 8'h0;
    end else if (enable_disable_task) begin
      // Call the task that attempts to disable the counter block
      disable_control_task;
    end
    // Output the counter value
    out_data <= counter;
  end

endmodule
