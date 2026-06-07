module curve_w426_20260111_101958_attempt3 (
    input wire clk,
    output reg data_register
);

  // SpyGlass Rule W426: Global variable 'data_register' should not be 'set' in task
  task update_data;
    // This non-blocking assignment to a module-level 'reg' inside a task
    // is the direct cause of the W426 violation.
    data_register <= 1'b0;
  endtask

  // The task is called within a sequential 'always' block.
  // Using a non-blocking assignment ('<=') in the task, called from a sequential block,
  // prevents the W336 violation encountered in the previous attempt (which used blocking assignment).
  always @(posedge clk) begin
    update_data;
  end

endmodule
