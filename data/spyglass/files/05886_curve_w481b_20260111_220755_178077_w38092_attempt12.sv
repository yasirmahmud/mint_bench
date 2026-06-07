module curve_w481b_20260111_220755_178077_w38092_attempt12 (
  input wire [7:0] data_in, // Added an input to ensure more logic and prevent other potential unused signal warnings
  output reg [7:0] result
);

  reg [7:0] temp_accumulator_a;
  reg [7:0] temp_accumulator_b;
  
  // Using integer type for loop variables to avoid W480 (Loop index 'X' is not of type integer).
  integer init_idx_a, step_idx_a;
  integer init_idx_b, step_idx_b;

  // This always @* block implements combinational logic.
  // The 'for' loops contained within are specifically crafted to trigger the W481b violation
  // because the initialization variable differs from the stepping variable.
  always @* begin
    temp_accumulator_a = 8'd0; // Initialize to prevent W528 (variable set but not read)
    temp_accumulator_b = 8'd0; // Initialize to prevent W528

    // First unsynthesizable loop (W481b):
    // 'init_idx_a' is initialized, but 'step_idx_a' is used for the condition and step.
    // Both variables are used within the loop body to prevent W528 for 'init_idx_a'.
    for (init_idx_a = 0; step_idx_a < 2; step_idx_a = step_idx_a + 1) begin
      temp_accumulator_a = temp_accumulator_a + data_in + init_idx_a + step_idx_a; // Use data_in, init_idx_a, and step_idx_a
    end

    // Second unsynthesizable loop (W481b):
    // 'init_idx_b' is initialized, but 'step_idx_b' is used for the condition and step.
    // Both variables are used within the loop body to prevent W528 for 'init_idx_b'.
    for (init_idx_b = 5; step_idx_b < 3; step_idx_b = step_idx_b + 1) begin
      temp_accumulator_b = temp_accumulator_b + data_in - init_idx_b + step_idx_b; // Use data_in, init_idx_b, and step_idx_b
    end

    // Combine results from both loops and assign to output to ensure temp_accumulators are used and avoid W528
    result = temp_accumulator_a + temp_accumulator_b;
  end

endmodule
