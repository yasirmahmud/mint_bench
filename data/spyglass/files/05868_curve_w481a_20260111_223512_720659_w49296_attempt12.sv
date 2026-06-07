module curve_w481a_20260111_223512_720659_w49296_attempt12 (
  input wire start_signal,
  output reg [7:0] final_output_value
);

  reg loop_termination_flag;
  integer loop_counter; // Declared as integer to avoid W480

  // This always block describes combinatorial logic.
  always @* begin
    // Default assignments to prevent latches and potential W415a for 'final_output_value'.
    final_output_value = 8'h00;
    loop_counter = 0;
    
    // Initialize the loop condition variable. It does not directly depend on 'loop_counter'.
    loop_termination_flag = start_signal;

    // The step variable 'loop_counter' is NOT used in the loop condition 'loop_termination_flag'.
    // This structural pattern specifically triggers the W481a violation.
    // The loop is guaranteed to terminate because 'loop_termination_flag' is modified
    // inside the loop based on 'loop_counter', preventing a W352 (constant true end condition) violation.
    for (loop_counter = 0; loop_termination_flag; loop_counter = loop_counter + 1) begin
      // Terminate the loop after a certain number of iterations.
      // This modification ensures termination and avoids W352.
      if (loop_counter >= 10) begin 
        loop_termination_flag = 1'b0; // Modify the loop condition variable to terminate.
      end
      // No iterative assignments to 'reg' variables within the loop body to avoid W415a and latches.
      // 'loop_counter' is used in the 'if' condition, ensuring it is read and not unused (W528).
    end
    
    // After the loop, assign the final value of 'loop_counter' to the output.
    // This ensures 'loop_counter' is used and 'final_output_value' is assigned only once (avoiding W415a).
    final_output_value = loop_counter; 
    
    // 'loop_termination_flag' is used in the loop condition itself, avoiding W528.
  end

endmodule
