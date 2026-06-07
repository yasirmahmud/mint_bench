module curve_w426_20260111_194409_827502_w37940_attempt8 (
    input some_input,
    output out_signal
);

  // Declare a module-level register that will be modified by a task.
  reg internal_data;

  // This task modifies the global variable 'internal_data'.
  // This directly triggers the W426 violation: "Global variable 'internal_data' should not be 'set' in task".
  task assign_internal_data;
    internal_data = some_input; // W426 violation occurs here with blocking assignment
  endtask

  // Call the task from a combinational always block.
  always @(*) begin
    assign_internal_data;
  end

  // Connect the internal register to an output to prevent unused signal warning.
  assign out_signal = internal_data;

endmodule
