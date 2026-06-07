module curve_w481b_20260111_180637_420293_w47100_attempt8 (
  input wire [7:0] in_data,
  output reg [7:0] out_data
);

  // Loop indices declared as integer to avoid W480 ("Loop index 'X' is not of type integer")
  integer i_init_0, j_step_0;
  integer k_init_1, l_step_1;

  // A register to hold the result of the loops. It is used to prevent W528 ("Variable 'result' set but not read").
  reg [7:0] intermediate_result;

  // Using an always @* block to describe combinational logic, specifically to avoid
  // the SYNTH_5143 warning ("Initial block is ignored for synthesis") often associated
  // with 'initial' blocks that typically house W481b violations.
  // W481b is expected to trigger due to the inherently unsynthesizable nature
  // of the loop structure itself, regardless of whether it's in an 'initial' or 'always' block.
  always @* begin
    intermediate_result = 8'h00; // Initialize to avoid latches and ensure defined combinational output

    // First unsynthesizable loop:
    // W481b triggered because the initialization variable 'i_init_0' is not the same
    // as the step variable 'j_step_0'.
    // Both 'i_init_0' and 'j_step_0' are explicitly used within the loop body
    // to prevent W528 ("Variable 'X' set but not read") for these variables.
    for (i_init_0 = 0; j_step_0 < 5; j_step_0 = j_step_0 + 1) begin
      intermediate_result = intermediate_result + i_init_0 + j_step_0;
    end

    // Second unsynthesizable loop:
    // W481b triggered because the initialization variable 'k_init_1' is not the same
    // as the step variable 'l_step_1'.
    // Both 'k_init_1' and 'l_step_1' are explicitly used within the loop body
    // to prevent W528 ("Variable 'X' set but not read") for these variables.
    for (k_init_1 = 10; l_step_1 < 15; l_step_1 = l_step_1 + 1) begin
      intermediate_result = intermediate_result + k_init_1 - l_step_1;
    end

    // Final output assignment, ensuring 'intermediate_result' and 'in_data' are used,
    // and that 'out_data' is fully assigned to prevent a latch.
    out_data = intermediate_result + in_data;
  end

endmodule
