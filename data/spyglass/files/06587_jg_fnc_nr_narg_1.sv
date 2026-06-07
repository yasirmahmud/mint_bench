module FNC_NR_NARG_example1();

  function automatic int my_func(input int a, input int b);
    return a + b;
  endfunction

  initial begin
    int result;
    // Calling my_func with too few arguments (expected 2, got 1)
    result = my_func(5);
    $display("Result: %0d", result);
  end

endmodule
