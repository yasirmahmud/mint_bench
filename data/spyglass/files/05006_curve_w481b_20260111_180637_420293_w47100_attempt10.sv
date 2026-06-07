module curve_w481b_20260111_180637_420293_w47100_attempt10;

  reg [7:0] data_accumulator;
  integer init_val_var;    // Variable initialized in the for-loop header but not incremented
  integer step_iter_var;   // Variable initialized and incremented in the for-loop header

  initial begin
    data_accumulator = 8'h00; // Initialize to ensure it's used and prevent W528
    
    // This for-loop is designed to trigger W481b (Unsynthesizable loop: Init variable 'i' is not same as step variable 'j')
    // 'init_val_var' is the 'i' variable (initialized to 0).
    // 'step_iter_var' is the 'j' variable (initialized to 0, used in condition, and stepped).
    // Since 'init_val_var' is not 'step_iter_var', W481b is triggered.
    // Both variables are initialized in the loop header to prevent W480 (Loop variable must be initialized).
    for (init_val_var = 0, step_iter_var = 0; step_iter_var < 5; step_iter_var = step_iter_var + 1) begin
      data_accumulator = data_accumulator + init_val_var + step_iter_var; // Use all variables to prevent W528
    end
    
    // Further use of variables after the loop to ensure they are not flagged as unused by W528
    // (especially for init_val_var and step_iter_var, which persist as they are declared outside the loop)
    data_accumulator = data_accumulator + init_val_var; // Use final value of init_val_var
    data_accumulator = data_accumulator + step_iter_var; // Use final value of step_iter_var
  end

endmodule
