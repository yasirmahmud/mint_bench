module curve_synth_196_20260111_190457_612420_w7792_attempt10 (
  input wire clk,
  input wire rst_n,
  input wire data_in,
  output reg data_out_reg
);

  // Define a task that explicitly contains an event control statement.
  // This structure is designed to trigger SYNTH_196, as tasks should not have event controls.
  task my_event_task(input bit some_input);
    // This is the event control statement that causes the SYNTH_196 violation.
    // It uses 'negedge clk', making it distinct from previous examples that might use 'posedge clk'.
    @(negedge clk); // SYNTH_196 violation expected here
    
    // The input argument 'some_input' is used to avoid an unused signal warning
    // for the task's argument itself, keeping the module clean.
    if (some_input) begin
      // This block is illustrative and does not cause other violations.
      // No assignments to module outputs or internal regs are made here to prevent multiple driver issues.
    end
  endtask

  // The task is called from a standard synthesizable sequential always block.
  // This ensures the task's contents are elaborated and analyzed by SpyGlass.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out_reg <= 1'b0; // Standard reset logic for the output register
    end else begin
      my_event_task(data_in); // Call the task, which contains the SYNTH_196 violation
      // data_out_reg is assigned independently in this always block, ensuring
      // no multiple drivers or mixed assignments with the task.
      data_out_reg <= data_in; // Example data path, ensuring data_in and data_out_reg are used
    end
  end

endmodule
