module curve_synth_196_20260111_070206_attempt3 (
  input clk,
  input reset_n,
  input data_in,
  output reg data_out
);

  reg [7:0] internal_data_reg; // Declare a reg to be used as an output from the task

  // Task definition that includes an event control statement, triggering SYNTH_196.
  task my_data_transfer_task;
    input [7:0] in_val;
    output [7:0] out_val; // This will connect to internal_data_reg

    // SYNTH_196 violation: Event control statement inside a task.
    // This specific form has the event control directly preceding a procedural assignment.
    @(posedge clk) out_val = in_val;
  endtask

  // An always block to instantiate and use the task
  always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      data_out <= 1'b0;
      internal_data_reg <= 8'h00; // Initialize internal register
    end else begin
      // Call the task. The second argument (internal_data_reg) will be updated by the task.
      my_data_transfer_task({7'b0, data_in}, internal_data_reg);
      data_out <= internal_data_reg[0]; // Example usage of the task's effect
    end
  end

endmodule
