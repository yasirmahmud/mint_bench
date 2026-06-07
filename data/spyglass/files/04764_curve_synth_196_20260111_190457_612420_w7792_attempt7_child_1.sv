module curve_synth_196_20260111_190457_612420_w7792_attempt7 (
  input wire clk,
  input wire condition_in
);

  // Define a task. The 'wait' statement has been removed as it is not synthesizable.
  // SpyGlass reports 'wait' constructs are ignored for synthesis (SYNTH_78).
  // Therefore, the synthesized functional behavior of the original task was effectively empty.
  task my_wait_task;
    // No synthesizable equivalent for the 'wait' construct within a task that preserves its blocking behavior.
  endtask

  // Call the task. After removing the non-synthesizable 'wait',
  // this always block now calls an empty task on each positive clock edge.
  // This preserves the synthesized functional behavior, as the 'wait' would have been ignored by synthesis.
  always @(posedge clk) begin
    my_wait_task();
  end

endmodule
