module loop_var_mod_1();
  initial begin
    // The original loop effectively incremented 'i' by 2 in each iteration
    // (once by i++ and once by i = i + 1;).
    // To preserve this behavior and resolve the LOP_NR_MLPV violation
    // (loop variable modified inside the loop), the explicit increment
    // inside the loop body is removed, and the loop's update expression
    // is changed to increment 'i' by 2.
    // The SYNTH_5143 warning about initial blocks being ignored for synthesis
    // is a characteristic of simulation-only constructs like $display within
    // an initial block. Since the functional behavior (printing to console)
    // must be preserved, the initial block remains.
    for (int i = 0; i < 5; i += 2) begin
      $display("i = %0d", i);
    end
  end
endmodule
