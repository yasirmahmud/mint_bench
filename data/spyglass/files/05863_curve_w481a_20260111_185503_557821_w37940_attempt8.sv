module curve_w481a_20260111_185503_557821_w37940_attempt8 ();

  integer loop_iterator;
  reg termination_condition_met;

  initial begin
    termination_condition_met = 1'b0;
    $display("Starting loop for W481a violation...");

    // This 'for' loop triggers W481a.
    // 'loop_iterator' is the step variable, incremented in the third part.
    // The loop condition '!termination_condition_met' does NOT directly use 'loop_iterator'.
    // This matches the rule description: "step variable 'i' is not used in condition".
    // The loop is made to terminate by modifying 'termination_condition_met'
    // based on 'loop_iterator' inside the loop, preventing a W352 (constant true end condition) violation.
    for (loop_iterator = 0; !termination_condition_met; loop_iterator = loop_iterator + 1) begin
      if (loop_iterator > 7) begin
        termination_condition_met = 1'b1; // 'termination_condition_met' is set here, eventually terminating the loop.
      end
      // Use loop_iterator to prevent W528 (unused signal) and show progress.
      $display("Inside loop: loop_iterator = %d, termination_condition_met = %b", loop_iterator, termination_condition_met);
      if (loop_iterator > 100) begin // Failsafe to prevent infinite simulation in case of unexpected logic
        termination_condition_met = 1'b1;
      end
    end
    $display("Loop finished. Final termination_condition_met = %b", termination_condition_met);
  end

endmodule
