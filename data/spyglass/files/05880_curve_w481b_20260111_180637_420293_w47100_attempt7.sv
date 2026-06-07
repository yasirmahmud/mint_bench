module curve_w481b_20260111_180637_420293_w47100_attempt7;
  // Loop indices declared as integer to avoid W480 ("Loop index 'X' is not of type integer")
  integer i_init, j_step;
  integer k_init, l_step;

  // A register to hold the result of the loops.
  // This variable is written to and read from, preventing W528 ("Variable 'result' set but not read").
  reg [7:0] result;

  initial begin
    // Initialize result to avoid potential W528 if it were only conditionally written
    result = 8'h00;

    // First unsynthesizable loop: W481b triggered because i_init != j_step
    // Both 'i_init' and 'j_step' are explicitly used within the loop body
    // to prevent W528 for 'i_init'. 'j_step' is used in condition and step.
    for (i_init = 0; j_step < 10; j_step = j_step + 1) begin
      result = result + i_init + j_step;
    end

    // Second unsynthesizable loop: W481b triggered because k_init != l_step
    // Both 'k_init' and 'l_step' are explicitly used within the loop body
    // to prevent W528 for 'k_init'. 'l_step' is used in condition and step.
    for (k_init = 5; l_step < 15; l_step = l_step + 2) begin
      result = result + k_init - l_step;
    end
  end

endmodule
