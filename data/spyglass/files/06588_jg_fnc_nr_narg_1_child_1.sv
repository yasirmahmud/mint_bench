module FNC_NR_NARG_example1();

  function automatic int my_func(input int a, input int b);
    return a + b;
  endfunction

  initial begin
    int result;
    // Calling my_func with the correct number of arguments (expected 2, got 2)
    result = my_func(5, 0); // Added a second argument to resolve the FNC_NR_NARG violation
    $display("Result: %0d", result);
  end

endmodule
