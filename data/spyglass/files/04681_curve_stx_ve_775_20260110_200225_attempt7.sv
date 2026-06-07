module curve_stx_ve_775_20260110_200225_attempt7 (
  input wire clk,
  input wire reset,
  output reg my_reg_a,
  output reg my_reg_b
);

  // STX_VE_775: Initial statement not allowed in this scope.
  // An 'initial' block is a top-level procedural statement and cannot be nested inside an 'always' block.
  always @(posedge clk) begin
    initial begin // Expected STX_VE_775 (1 of 2 occurrences)
      my_reg_a = 1'b0; // This assignment is part of the illegally placed 'initial' block.
    end
    // Legal sequential logic for my_reg_a, outside the 'initial' block.
    if (reset) begin
      my_reg_a <= 1'b0;
    end else begin
      my_reg_a <= 1'b1;
    end
  end

  // STX_VE_775: Initial statement not allowed in this scope.
  // An 'initial' block cannot be nested inside a 'task'.
  task my_task();
    initial begin // Expected STX_VE_775 (2 of 2 occurrences)
      my_reg_b = 1'b0; // This assignment is part of the illegally placed 'initial' block.
    end
    // Legal logic within the task (executed when task is called).
    my_reg_b = 1'b0; // Example assignment to make task syntactically complete.
  endtask

  // Call the task from an 'always' block to ensure it is used.
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      // Reset behavior for my_reg_b when task is called, to avoid multi-driver if initial block is ignored.
      my_reg_b <= 1'b0;
    end else begin
      my_task(); // Calling the task containing the illegal 'initial' block.
    end
  end

endmodule
