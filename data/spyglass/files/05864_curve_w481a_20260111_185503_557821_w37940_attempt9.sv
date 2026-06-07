module curve_w481a_20260111_185503_557821_w37940_attempt9 (
  output reg termination_output_flag
);

  integer loop_iterator;

  initial begin
    termination_output_flag = 1'b0;

    // This 'for' loop triggers W481a:
    // The step variable 'loop_iterator' is incremented in the third part.
    // The loop condition 'termination_output_flag == 1'b0' does NOT directly use 'loop_iterator'.
    // This directly matches the rule description: "step variable 'i' is not used in condition".
    // The loop is designed to terminate by modifying 'termination_output_flag'
    // based on 'loop_iterator' inside the loop, which prevents a W352 (constant true end condition) violation.
    for (loop_iterator = 0; termination_output_flag == 1'b0; loop_iterator = loop_iterator + 1) begin
      if (loop_iterator > 7) begin
        termination_output_flag = 1'b1; // 'termination_output_flag' is set here, eventually terminating the loop.
      end
    end
    // Assign the final value to ensure the output is driven, or if the loop never runs.
    termination_output_flag = termination_output_flag;
  end

endmodule
