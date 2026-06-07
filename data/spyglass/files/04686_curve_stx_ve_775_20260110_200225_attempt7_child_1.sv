module curve_stx_ve_775_20260110_200225_attempt7 (
  input wire clk,
  input wire reset,
  output reg my_reg_a,
  output reg my_reg_b
);

  // STX_VE_775: Initial statement not allowed in this scope. -- RESOLVED
  // An 'initial' block is a top-level procedural statement and cannot be nested inside an 'always' block.
  always @(posedge clk) begin
    // The 'initial' block was removed as it is not allowed inside an 'always' block.
    // The reset condition already handles the intended initialization of my_reg_a.
    if (reset) begin
      my_reg_a <= 1'b0;
    end else begin
      my_reg_a <= 1'b1;
    end
  end

  // STX_VE_775: Initial statement not allowed in this scope. -- RESOLVED
  // An 'initial' block cannot be nested inside a 'task'.
  task my_task();
    // The 'initial' block was removed as it is not allowed inside a 'task'.
    // The direct assignment within the task now correctly specifies its behavior when called.
    my_reg_b = 1'b0;
  endtask

  // Call the task from an 'always' block to ensure it is used.
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      // Reset behavior for my_reg_b. This handles the initialization.
      my_reg_b <= 1'b0;
    end else begin
      my_task(); // Calling the task.
    end
  end

endmodule
