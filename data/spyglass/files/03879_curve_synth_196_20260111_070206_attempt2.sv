module curve_synth_196_20260111_070206_attempt2 (
  input clk
);

  // Task definition that includes an event control statement, triggering SYNTH_196.
  task my_violation_task;
    // SYNTH_196 violation: Event control statement inside a task
    @(posedge clk); // This line causes the violation.
  endtask

  // An initial block to ensure the task is referenced (called),
  // preventing it from being optimized out as unused by some tools.
  // This block itself is unsynthesizable but does not trigger SYNTH_196.
  initial begin
    my_violation_task;
  end

endmodule
