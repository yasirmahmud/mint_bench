module curve_w481b_20260112_010424_671992_w44756_attempt15 (
  input wire [7:0] data_in,
  output reg [7:0] data_out
);

  // Loop control variables. Changed to integer to resolve W480.
  // The original 'init_var_0' and 'init_var_1' were constant values within their loops
  // and are now replaced by direct constants in the loop body to preserve behavior.
  integer step_var_0;
  integer step_var_1;

  // Accumulator registers for loop results.
  // These are now assigned only once after the respective loops to resolve W415a.
  reg [7:0] loop_sum_0;
  reg [7:0] loop_sum_1;

  always @* begin
    // Declare local temporary accumulators to resolve W415a.
    // These local regs accumulate values within the loops.
    reg [7:0] current_loop_sum_0;
    reg [7:0] current_loop_sum_1;

    // Initialize local accumulators.
    current_loop_sum_0 = 8'd0;
    current_loop_sum_1 = 8'd0;

    // Removed default assignments for module-level loop_sum_0/1 to resolve W415a,
    // as they are now assigned once after their loops from local accumulators.
    // Removed default assignment for data_out (previous line 24) to resolve W415a.
    // data_out is always driven by the final assignment at the end of the block.

    // --- First W481b violation fixed ---
    // Original rule: Unsynthesizable loop: Init variable 'init_var_0' is not same as step variable 'step_var_0'
    // Fix: 'step_var_0' is now the sole loop control variable, initialized in the loop header.
    // Its type is changed to 'integer' to resolve W480. The original 'init_var_0' value (8'd0)
    // is now a constant in the loop body to preserve functional behavior.
    for (step_var_0 = 8'd0; step_var_0 < 8'd3; step_var_0 = step_var_0 + 8'd1) begin
      current_loop_sum_0 = current_loop_sum_0 + ({7'b0, data_in[0]}) + 8'd0 + step_var_0;
    end
    // Assign the final accumulated value to the module-level register to resolve W415a.
    loop_sum_0 = current_loop_sum_0;

    // --- Second W481b violation fixed ---
    // Original rule: Unsynthesizable loop: Init variable 'init_var_1' is not same as step variable 'step_var_1'
    // Fix: 'step_var_1' is now the sole loop control variable, initialized in the loop header.
    // Its type is changed to 'integer' to resolve W480. The original 'init_var_1' value (8'd5)
    // is now a constant in the loop body to preserve functional behavior.
    // Note: 'step_var_1' is initialized to 8'd0 here, matching its original sequence (0, 1, 2, 3).
    for (step_var_1 = 8'd0; step_var_1 < 8'd4; step_var_1 = step_var_1 + 8'd1) begin
      current_loop_sum_1 = current_loop_sum_1 + ({1'b0, data_in[7:1]}) - 8'd5 + step_var_1;
    end
    // Assign the final accumulated value to the module-level register to resolve W415a.
    loop_sum_1 = current_loop_sum_1;

    // Final assignment to data_out, ensuring all bits of data_in are used and data_out is always driven.
    data_out = loop_sum_0 + loop_sum_1 + data_in;
  end

endmodule
