module curve_synth_196_20260111_190457_612420_w7792_attempt9 (
  input wire clk,
  input wire en
);

  // Define a task that contains an event control statement.
  task my_event_task;
    // This event control statement inside a task is the target for SYNTH_196.
    // Tasks are not meant to contain event controls for synthesizable logic.
    // This statement is isolated to trigger only SYNTH_196.
    @(posedge clk); // SYNTH_196 violation expected here
  endtask

  // Call the task from a sequential always block to ensure it is elaborated
  // and its contents are analyzed by SpyGlass.
  always @(posedge clk) begin
    if (en) begin
      my_event_task(); // Call the task; 'en' ensures the input is used.
    end
  end

endmodule
