module curve_synth_5306_20260110_181614_attempt10 (
  input clk,
  input rst,
  output reg [7:0] data_out
);

  reg [7:0] counter_reg; // Internal signal to demonstrate logic and avoid unused warnings

  // A named sequential block defined directly within the module scope.
  // This block increments 'counter_reg' on the positive edge of 'clk' unless reset.
  always @(posedge clk or posedge rst) begin : counter_block
    if (rst) begin
      counter_reg <= 8'h00;
    end else begin
      counter_reg <= counter_reg + 1;
    end
  end

  // A task defined at the module level. It attempts to disable 'counter_block'.
  // Since 'counter_block' is not lexically contained within this task,
  // nor is this task an ancestor of 'counter_block', the 'disable' statement
  // is targeting an out-of-scope named block, leading to SYNTH_5306.
  task disable_counter_task;
    begin
      disable counter_block; // SYNTH_5306 violation: 'counter_block' is not in scope of this task.
    end
  endtask

  // An always block that calls the task under a condition.
  // This ensures the task (and thus the disable statement) is part of the design flow.
  always @(negedge clk) begin
    if (!rst) begin
      disable_counter_task(); // Call the task to trigger the disable attempt
    end
  end

  // Connect internal register to output to avoid unused signal warning on data_out.
  assign data_out = counter_reg;

endmodule
