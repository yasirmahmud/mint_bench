module curve_w481a_20260111_044106_attempt4;

  integer loop_step_var;      // The step variable for the loop
  integer condition_ctrl_var; // A variable used in the loop condition

  initial begin
    condition_ctrl_var = 0;

    // W481a: The step variable 'loop_step_var' is not used in the loop condition 'condition_ctrl_var < 5'.
    // The loop condition depends on 'condition_ctrl_var', which is modified inside the loop,
    // but 'loop_step_var' itself does not appear in the conditional expression. This makes
    // the loop potentially unsynthesizable or difficult to analyze regarding its termination
    // based on the step variable.
    // FIX: Changed the loop condition to use 'loop_step_var' directly. This preserves the functional
    // behavior (number of iterations and final variable values) while resolving the W481a violation.
    for (loop_step_var = 0; loop_step_var < 5; loop_step_var = loop_step_var + 1) begin // Original condition: condition_ctrl_var < 5
      $display("Iteration: loop_step_var = %0d, condition_ctrl_var = %0d", loop_step_var, condition_ctrl_var);
      condition_ctrl_var = condition_ctrl_var + 1; // 'condition_ctrl_var' is updated here, ensuring loop termination
                                                  // Its value still mirrors 'loop_step_var' during the loop execution.
    end

    $display("Loop finished. Final loop_step_var = %0d, Final condition_ctrl_var = %0d", loop_step_var, condition_ctrl_var);
  end

endmodule
