module curve_synth_196_20260111_190457_612420_w7792_attempt7 (
  input wire clk,
  input wire condition_in
);

  // Define a task that contains an event control statement
  task my_wait_task;
    // This 'wait' statement inside a task will trigger SYNTH_196
    wait(condition_in);
  endtask

  // Call the task to ensure it's elaborated and analyzed by SpyGlass
  always @(posedge clk) begin
    my_wait_task();
  end

endmodule
