module curve_w481b_20260112_010424_671992_w44756_attempt15 (
  input wire [7:0] data_in,
  output reg [7:0] data_out
);

  // Loop control variables. Declared as reg [7:0] to control width and avoid W116.
  reg [7:0] init_var_0;
  reg [7:0] step_var_0;
  reg [7:0] init_var_1;
  reg [7:0] step_var_1;

  // Accumulator registers for loop results.
  reg [7:0] loop_sum_0;
  reg [7:0] loop_sum_1;

  always @* begin
    // Default assignments to prevent latches and to ensure all `reg`s are driven.
    init_var_0 = 8'd0;
    step_var_0 = 8'd0; // Initialize step_var_0 for its first read in the loop condition
    init_var_1 = 8'd0;
    step_var_1 = 8'd0; // Initialize step_var_1 for its first read in the loop condition
    loop_sum_0 = 8'd0;
    loop_sum_1 = 8'd0;
    data_out = 8'd0;   // Default output assignment, final assignment will override.

    // --- First W481b violation (expected 1 of 2) ---
    // Rule: Unsynthesizable loop: Init variable 'init_var_0' is not same as step variable 'step_var_0'
    // 'init_var_0' is initialized in the for-loop header, but 'step_var_0' is used for the condition and step.
    // Both variables are used within the loop body to prevent W528.
    // All arithmetic operands are explicitly 8-bit to prevent W116.
    for (init_var_0 = 8'd0; step_var_0 < 8'd3; step_var_0 = step_var_0 + 8'd1) begin
      loop_sum_0 = loop_sum_0 + ({7'b0, data_in[0]}) + init_var_0 + step_var_0;
    end

    // --- Second W481b violation (expected 2 of 2) ---
    // Rule: Unsynthesizable loop: Init variable 'init_var_1' is not same as step variable 'step_var_1'
    // 'init_var_1' is initialized in the for-loop header, but 'step_var_1' is used for the condition and step.
    // Both variables are used within the loop body to prevent W528.
    // All arithmetic operands are explicitly 8-bit to prevent W116.
    for (init_var_1 = 8'd5; step_var_1 < 8'd4; step_var_1 = step_var_1 + 8'd1) begin
      loop_sum_1 = loop_sum_1 + ({1'b0, data_in[7:1]}) - init_var_1 + step_var_1;
    end

    // Final assignment to data_out, ensuring all bits of data_in are used and data_out is always driven.
    data_out = loop_sum_0 + loop_sum_1 + data_in;
  end

endmodule
