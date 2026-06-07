module curve_w426_20260111_194409_827502_w37940_attempt10 (
    input a,
    output reg out_data
);

  // This task directly modifies the module-level 'out_data'.
  // This direct assignment to a global variable from within a task
  // is the direct cause of the W426 violation.
  task set_output_from_task;
    out_data = ~a; // W426: Global variable 'out_data' should not be 'set' in task
  endtask

  // Call the task from a combinational always block.
  // This ensures 'out_data' is assigned, using input 'a'.
  always @(a) begin
    set_output_from_task;
  end

endmodule
