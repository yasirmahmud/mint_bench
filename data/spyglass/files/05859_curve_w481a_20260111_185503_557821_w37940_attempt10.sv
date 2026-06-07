module curve_w481a_20260111_185503_557821_w37940_attempt10 (
  output reg result_valid
);

  integer loop_idx; // The loop step variable
  reg loop_active; // The loop condition variable
  reg [7:0] processing_data; // Internal data for loop activity

  initial begin
    loop_active = 1'b1; // Initialize loop to be active
    processing_data = 8'h00; // Initialize internal data
    result_valid = 1'b0; // Default output value

    // This 'for' loop is designed to trigger W481a:
    // 1. 'loop_idx' is the step variable (modified in the third part).
    // 2. The condition 'loop_active' does NOT directly use 'loop_idx'.
    // This precisely matches the rule: "step variable 'i' is not used in condition".
    // The loop is set to terminate by modifying 'loop_active' within the loop body
    // based on 'loop_idx', which ensures it's not a W352 (constant true end condition).
    for (loop_idx = 0; loop_active; loop_idx = loop_idx + 1) begin
      processing_data = processing_data + 1; // Perform some operation within the loop
      if (loop_idx >= 10) begin
        loop_active = 1'b0; // Terminate the loop when 'loop_idx' reaches a certain value
      end
      // Additional processing or conditional termination logic can be added here
    end

    // Drive the output based on the loop's outcome
    if (processing_data > 8'h00 && !loop_active) begin
      result_valid = 1'b1; // Set output if the loop completed successfully
    end
  end

endmodule
