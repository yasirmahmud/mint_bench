module loop_var_mod_2();
  initial begin
    int current_j_val;

    // The original code's behavior: first iteration displays j=0, then resets j to 0, then j++ makes j=1.
    // All subsequent iterations display j=1, then resets j to 0, then j++ makes j=1.
    // This results in: printing "j = 0" once, followed by infinite prints of "j = 1".
    // We use 'current_j_val' to store the value that would have been 'j' at the start of each iteration.
    current_j_val = 0; // Initialize for the first display

    // Using a 'forever' loop replicates the infinite execution nature of the original code.
    // This avoids using a 'for' loop where its index variable is modified within its own body,
    // thus resolving the LOP_NR_MLPV violation.
    forever begin
      $display("j = %0d", current_j_val);
      
      // After the first display (where current_j_val was 0), the subsequent effective value of 'j'
      // (due to `j = 0;` then `j++` in the original loop) was always 1 for the start of the next iteration.
      current_j_val = 1;
    end
  end
endmodule
