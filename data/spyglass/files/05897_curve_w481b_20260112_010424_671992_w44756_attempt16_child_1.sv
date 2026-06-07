module curve_w481b_20260112_010424_671992_w44756_attempt16 (
  input wire [7:0] data_in,
  output reg [7:0] data_out
);

  // Declare loop control variables as integer to avoid W480 ("Loop index 'X' is not of type integer").
  // 'init_var_0' and 'init_var_1' will be assigned before their loops, serving as constants.
  // 'step_var_0' and 'step_var_1' will be the actual loop counters.
  integer init_var_0;
  integer step_var_0;
  integer init_var_1;
  integer step_var_1;

  // Accumulator registers for loop results. Declared with explicit width to avoid W116/W240.
  reg [7:0] loop_result_0;
  reg [7:0] loop_result_1;

  always @* begin
    // Initialize accumulator registers to prevent latches (W223, W224)
    // 'data_out' is assigned only once at the end to prevent W415a.
    loop_result_0 = 8'd0;
    loop_result_1 = 8'd0;

    // Assign init_var_0 to its constant value for use in the loop body.
    // This fixes W528 as 'init_var_0' is now clearly set and read.
    init_var_0 = 0;

    // --- First W481b violation fixed ---
    // Rule: Unsynthesizable loop: Init variable 'init_var_0' is not same as step variable 'step_var_0'
    // Fix: 'step_var_0' is now the sole loop control variable, initialized, checked, and incremented.
    // 'init_var_0' is used as a constant in the body, preserving functional behavior.
    for (step_var_0 = 0; step_var_0 < 3; step_var_0 = step_var_0 + 1) begin
      // Add explicit casting (8'()) to integer variables to resolve W116 width mismatch warnings.
      loop_result_0 = loop_result_0 + data_in + 8'(init_var_0) + 8'(step_var_0);
    end

    // Assign init_var_1 to its constant value for use in the loop body.
    // This fixes W528 as 'init_var_1' is now clearly set and read.
    init_var_1 = 5;

    // --- Second W481b violation fixed ---
    // Rule: Unsynthesizable loop: Init variable 'init_var_1' is not same as step variable 'step_var_1'
    // Fix: 'step_var_1' is now the sole loop control variable, initialized, checked, and incremented.
    // 'init_var_1' is used as a constant in the body, preserving functional behavior.
    for (step_var_1 = 5; step_var_1 < 8; step_var_1 = step_var_1 + 1) begin
      // Add explicit casting (8'()) to integer variables to resolve W116 width mismatch warnings.
      loop_result_1 = loop_result_1 + data_in - 8'(init_var_1) + 8'(step_var_1);
    end

    // Final assignment to data_out. This single assignment point prevents W415a
    // ("Signal X is being assigned multiple times").
    data_out = loop_result_0 + loop_result_1;

  end // always @*

endmodule
