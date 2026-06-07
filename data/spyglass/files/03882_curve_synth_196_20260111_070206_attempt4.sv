module curve_synth_196_20260111_070206_attempt4 (
  input wire clk,
  input wire rst_n,
  input wire data_in,
  output reg data_out
);

  // Task definition that includes an event control statement, triggering SYNTH_196.
  task my_processing_task;
    // SYNTH_196 violation: Event control statement inside a task.
    // A bare event control statement is sufficient to trigger the rule.
    @(negedge rst_n); // This line causes the SYNTH_196 violation.
  endtask

  // An always block to instantiate and use the task
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 1'b0;
    end else begin
      // Call the task. Its internal event control will trigger the violation.
      my_processing_task();
      data_out <= data_in; // Simple assignment to use data_in and data_out
    end
  end

endmodule
