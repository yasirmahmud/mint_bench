module curve_w481a_20260111_223512_720659_w49296_attempt11 (
  input wire start_process,
  output reg [7:0] final_output
);

  reg [3:0] index_var;
  reg condition_active;
  reg [7:0] data_accumulator;

  // This always block describes combinatorial logic.
  always @* begin
    // Default assignments to prevent latches.
    final_output = 8'h00;
    index_var = 4'h0;
    data_accumulator = 8'h0;
    condition_active = start_process; // Initialize the loop condition variable from an input.

    // The step variable 'index_var' is NOT used in the loop condition 'condition_active'.
    // This structural pattern specifically triggers the W481a violation.
    // The loop is guaranteed to terminate because 'condition_active' is modified
    // inside the loop based on 'index_var', preventing a W352 (constant true end condition) violation.
    for (index_var = 4'h0; condition_active; index_var = index_var + 1) begin
      data_accumulator = data_accumulator + index_var; // Perform some data processing.

      // Terminate the loop after a certain number of iterations.
      if (index_var >= 4'd6) begin // Loop for index_var from 0 to 6 (7 iterations)
        condition_active = 1'b0; // Modify the loop condition variable to terminate.
      end
      
      // Failsafe for loop termination if index_var were to somehow exceed expected range.
      if (index_var == 4'hF) begin
        condition_active = 1'b0;
      end
    end
    
    final_output = data_accumulator; // Assign the accumulated result.
  end

endmodule
