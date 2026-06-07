module curve_w481a_20260111_044106_attempt5 (
  input wire [3:0] in_limit,          // Input to determine the number of loop iterations
  output reg [3:0] processed_count    // Output to show the number of completed iterations
);

  integer i;                           // Step variable for the loop
  reg [3:0] current_iteration_limit; // A local variable to control loop termination

  // This always block describes combinational logic.
  always @* begin
    // Initialize the loop condition control variable from the input.
    current_iteration_limit = in_limit;
    
    // Default assignment to avoid implicit latches if the loop doesn't execute
    // or for the initial state before loop processing.
    processed_count = 0;

    // W481a: The step variable 'i' is not used in the loop condition 'current_iteration_limit > 0'.
    // The loop's termination is controlled by 'current_iteration_limit', which is modified
    // inside the loop, ensuring it will terminate. However, SpyGlass flags this as a potential issue
    // because the step variable 'i' itself does not appear in the condition, making the loop's
    // termination independent of the explicit step variable progression.
    // Synthesis tools will typically unroll this loop into combinational logic.
    for (i = 0; current_iteration_limit > 0; i = i + 1) begin
      current_iteration_limit = current_iteration_limit - 1; // Decrement the control variable
      processed_count = processed_count + 1;                 // Increment processed count in each iteration
    end
  end

endmodule
