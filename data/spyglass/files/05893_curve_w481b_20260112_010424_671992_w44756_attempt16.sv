module curve_w481b_20260112_010424_671992_w44756_attempt16 (
  input wire [7:0] data_in,
  output reg [7:0] data_out
);

  // Declare loop control variables as integer to avoid W480 ("Loop index 'X' is not of type integer").
  integer init_var_0;
  integer step_var_0;
  integer init_var_1;
  integer step_var_1;

  // Accumulator registers for loop results. Declared with explicit width to avoid W116/W240.
  reg [7:0] loop_result_0;
  reg [7:0] loop_result_1;

  always @* begin
    // Initialize output and accumulator registers to prevent latches (W223, W224)
    // and ensure all `reg`s are driven in all execution paths.
    data_out = 8'd0;
    loop_result_0 = 8'd0;
    loop_result_1 = 8'd0;

    // --- First W481b violation (expected 1 of 2) ---
    // Rule: Unsynthesizable loop: Init variable 'init_var_0' is not same as step variable 'step_var_0'
    // 'init_var_0' is initialized in the for-loop header.
    // 'step_var_0' is used for the loop condition and for the step increment.
    // Both 'init_var_0' and 'step_var_0' are used within the loop body to prevent W528
    // ("Variable 'X' set but not read").
    for (init_var_0 = 0; step_var_0 < 3; step_var_0 = step_var_0 + 1) begin
      loop_result_0 = loop_result_0 + data_in + init_var_0 + step_var_0;
    end

    // --- Second W481b violation (expected 2 of 2) ---
    // Rule: Unsynthesizable loop: Init variable 'init_var_1' is not same as step variable 'step_var_1'
    // 'init_var_1' is initialized in the for-loop header.
    // 'step_var_1' is used for the loop condition and for the step increment.
    // Both 'init_var_1' and 'step_var_1' are used within the loop body to prevent W528.
    for (init_var_1 = 5; step_var_1 < 8; step_var_1 = step_var_1 + 1) begin
      loop_result_1 = loop_result_1 + data_in - init_var_1 + step_var_1;
    end

    // Final assignment to data_out. This single assignment point prevents W415a
    // ("Signal X is being assigned multiple times").
    data_out = loop_result_0 + loop_result_1;

  end // always @*

endmodule
