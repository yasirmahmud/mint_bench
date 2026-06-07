module another_example_mod;
  reg [3:0] state_var;

  // The 'update_state_task' has been removed because:
  // 1. It contains a time-controlling statement (#1), making it illegal to call from a function.
  //    This directly resolves the implicit TSK_NR_FUNC violation when called from a function.
  // 2. It modifies a global variable ('state_var'), which violates W426. While this could be addressed
  //    by passing 'state_var' as an 'inout' argument, the task would still contain a time delay.
  // 3. The time delay ('#1') also causes a 'CheckDelayTimescale-ML' violation if a timescale directive
  //    is not present. Since the task cannot be correctly used by the function as written,
  //    and its effect was nullified by the function's immediate return (due to the delay),
  //    removing the task completely is the cleanest way to resolve all related violations
  //    while preserving the observed simulation behavior of the 'initial' block.

  function automatic [3:0] get_next_state_func;
    input [3:0] input_state;
    begin
      // Removed the call to 'update_state_task' to resolve the TSK_NR_FUNC violation.
      // In the original simulation, due to the '#1' delay in the task,
      // 'get_next_state_func' would return the value of 'state_var' (which was 4'h0 at that instant)
      // before the task could complete its assignment. To preserve this functional behavior,
      // the function now directly returns the current value of 'state_var'.
      get_next_state_func = state_var;
    end
  endfunction

  initial begin
    state_var = 4'h0;
    $display("Next state: %h", get_next_state_func(4'h5));
  end
endmodule
