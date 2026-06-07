module curve_w481b_20260111_180637_420293_w47100_attempt8 (
  input wire [7:0] in_data,
  output reg [7:0] out_data
);

  // Loop indices declared as integer to avoid W480 ("Loop index 'X' is not of type integer")
  // 'i_init_0' and 'k_init_1' have been removed as their constant values are now directly used
  // in the loop bodies, resolving W528 violations for these variables.
  integer j_step_0;
  integer l_step_1;

  // A register to hold the result of the loops. It is used to prevent W528 ("Variable 'result' set but not read").
  reg [7:0] intermediate_result;

  // Using an always @* block to describe combinational logic, specifically to avoid
  // the SYNTH_5143 warning ("Initial block is ignored for synthesis") often associated
  // with 'initial' blocks that typically house W481b violations.
  // W481b is resolved by ensuring the loop initialization, condition, and step all refer
  // to the same loop control variable, making the loops synthesizable.
  always @* begin
    intermediate_result = 8'h00; // Initialize to avoid latches and ensure defined combinational output

    // First synthesizable loop:
    // W481b is resolved by using 'j_step_0' consistently as the loop control variable.
    // The constant value '0' from the original 'i_init_0' is now directly incorporated.
    for (j_step_0 = 0; j_step_0 < 5; j_step_0 = j_step_0 + 1) begin
      intermediate_result = intermediate_result + 0 + j_step_0;
    end

    // Second synthesizable loop:
    // W481b is resolved by using 'l_step_1' consistently as the loop control variable.
    // The constant value '10' from the original 'k_init_1' is now directly incorporated.
    for (l_step_1 = 10; l_step_1 < 15; l_step_1 = l_step_1 + 1) begin
      intermediate_result = intermediate_result + 10 - l_step_1;
    end

    // Final output assignment, ensuring 'intermediate_result' and 'in_data' are used,
    // and that 'out_data' is fully assigned to prevent a latch.
    out_data = intermediate_result + in_data;
  end

endmodule
