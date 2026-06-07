module curve_synth_196_20260111_070206_attempt2 (
  input clk
);

  // Task definition. The event control statement causing SYNTH_196 has been removed.
  task my_violation_task;
    // The @(posedge clk) statement was removed to resolve the SYNTH_196 violation.
  endtask

  // An initial block to ensure the task is referenced (called),
  // preventing it from being optimized out as unused by some tools.
  // This block itself is unsynthesizable but does not trigger SYNTH_196.
  initial begin
    my_violation_task;
  end

endmodule
