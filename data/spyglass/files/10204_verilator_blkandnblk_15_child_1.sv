module ex15;
  reg o;

  // Fix: The original function contained both blocking and non-blocking assignments
  // to a global variable 'o', which is non-standard, leads to non-deterministic
  // behavior (BLKANDNBLK), and is not synthesizable. Functions should be purely
  // combinational, use only blocking assignments, and should not have side effects
  // on module-level variables.
  // Assuming the intent was for the function to return the 'val' input (as blocking
  // assignments take precedence for immediate reads), the function is simplified.
  function automatic [0:0] my_func;
    input val;
    begin
      my_func = val; // Return the input value directly
    end
  endfunction

  initial begin
    o = my_func(1'b1);
    // The initial block remains for simulation purposes and is expected to be
    // ignored for synthesis (SYNTH_5143 warning), which is acceptable for test benches.
  end
endmodule
