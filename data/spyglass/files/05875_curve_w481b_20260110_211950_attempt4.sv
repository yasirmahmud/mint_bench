module curve_w481b_20260110_211950_attempt4 (
  output reg [7:0] final_result_1, // To ensure loop_init_idx_1 is considered "read"
  output reg [7:0] final_result_2  // To ensure loop_init_idx_2 is considered "read"
);

  // Variables for the first W481b violation
  reg [3:0] loop_init_idx_1; // The 'i' variable for the first loop
  reg [3:0] loop_step_cnt_1; // The 'j' variable for the first loop

  // Variables for the second W481b violation
  reg [3:0] loop_init_idx_2; // The 'i' variable for the second loop
  reg [3:0] loop_step_cnt_2; // The 'j' variable for the second loop

  initial begin
    // --- First W481b violation --- 
    // Initialize loop_step_cnt_1 to avoid W480: "Variable 'loop_step_cnt_1' not initialized before use."
    loop_step_cnt_1 = 0;

    // W481b violation occurs here: Init variable 'loop_init_idx_1' is not the same as step variable 'loop_step_cnt_1'
    for (loop_init_idx_1 = 1; loop_step_cnt_1 < 8; loop_step_cnt_1 = loop_step_cnt_1 + 1) begin
      // Using loop_init_idx_1 in an assignment to an output reg helps prevent W528 ("set but not read").
      final_result_1 = loop_init_idx_1 * loop_step_cnt_1;
    end
    // Final assignment to ensure loop_init_idx_1's value is propagated to an output for synthesis analysis.
    final_result_1 = loop_init_idx_1;


    // --- Second W481b violation --- 
    // Initialize loop_step_cnt_2 to avoid W480
    loop_step_cnt_2 = 0;

    // W481b violation occurs here: Init variable 'loop_init_idx_2' is not the same as step variable 'loop_step_cnt_2'
    for (loop_init_idx_2 = 10; loop_step_cnt_2 < 15; loop_step_cnt_2 = loop_step_cnt_2 + 3) begin
      // Using loop_init_idx_2 in an assignment to an output reg helps prevent W528.
      final_result_2 = loop_init_idx_2 + loop_step_cnt_2;
    end
    // Final assignment to ensure loop_init_idx_2's value is propagated to an output for synthesis analysis.
    final_result_2 = loop_init_idx_2;
  end

endmodule
