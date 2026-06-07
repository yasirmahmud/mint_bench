module curve_w499_mod (
  input sel_in,
  output integer result_out
);

  // Function definition: my_func_w499 returns an integer value.
  // This function will trigger W499 because not all execution paths
  // assign the function's entire return value.
  function integer my_func_w499;
    input select_arg;
    begin
      // Only in this 'if' branch is the function value assigned.
      if (select_arg == 1'b1) begin
        my_func_w499 = 32'd10;
      end
      // In the implicit 'else' branch (when select_arg is 0 or X/Z),
      // 'my_func_w499' is not assigned at all.
      // This lack of assignment in all branches for an integer function
      // triggers the W499 violation.
    end
  endfunction

  // Assign the module output by calling the function.
  assign result_out = my_func_w499(sel_in);

endmodule
