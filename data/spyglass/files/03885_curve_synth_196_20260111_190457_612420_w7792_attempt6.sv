module curve_synth_196_20260111_190457_612420_w7792_attempt6 (
  input wire clk
);

  // Define a task that contains an event control statement
  task my_event_trigger_task;
    // This event control statement inside a task will trigger SYNTH_196
    @(posedge clk);
  endtask

  // Call the task to ensure it's elaborated and analyzed
  always @(posedge clk) begin
    my_event_trigger_task();
  end

endmodule
