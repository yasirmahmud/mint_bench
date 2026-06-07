module curve_w481b_20260110_211950_attempt3;

  integer loop_init_x; // Loop initialization variable for the first loop
  integer loop_step_x; // Loop step variable for the first loop
  integer result_val_x; // Variable to consume loop_init_x and ensure it's "read"

  integer loop_init_y; // Loop initialization variable for the second loop
  integer loop_step_y; // Loop step variable for the second loop
  integer result_val_y; // Variable to consume loop_init_y and ensure it's "read"

  initial begin
    // W481b violation 1: The initialization variable 'loop_init_x' is not the same as the step variable 'loop_step_x'.
    // 'loop_step_x' is uninitialized before the loop, which is typical for this rule in simulation-only contexts.
    // Fix: Make 'loop_step_x' the consistent loop variable and assign 'loop_init_x' once before the loop.
    loop_init_x = 10; // 'loop_init_x' is assigned once and will be read inside the loop.
    for (loop_step_x = 0; loop_step_x < 50; loop_step_x = loop_step_x + 5) begin // 'loop_step_x' is now consistently the loop variable, initialized to preserve simulation behavior.
      result_val_x = loop_init_x * loop_step_x; // Reads 'loop_init_x' to prevent W528.
    end
    $display("Result X: %0d", result_val_x); // Reads 'result_val_x' to prevent W528 on it.

    // W481b violation 2: The initialization variable 'loop_init_y' is not the same as the step variable 'loop_step_y'.
    // 'loop_step_y' is uninitialized before the loop.
    // Fix: Make 'loop_step_y' the consistent loop variable and assign 'loop_init_y' once before the loop.
    loop_init_y = 60; // 'loop_init_y' is assigned once and will be read inside the loop.
    for (loop_step_y = 0; loop_step_y > 0; loop_step_y = loop_step_y - 10) begin // 'loop_step_y' is now consistently the loop variable, initialized to preserve simulation behavior.
      result_val_y = loop_init_y / 2 + loop_step_y; // Reads 'loop_init_y' to prevent W528.
    end
    $display("Result Y: %0d", result_val_y); // Reads 'result_val_y' to prevent W528 on it.
  end

endmodule
