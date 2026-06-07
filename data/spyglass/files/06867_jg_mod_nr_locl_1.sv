module mod_nr_locl_example_1;

  function automatic int my_adder_func(input int a, input int b);
    int sum_local = 0; // Violation: Local variable 'sum_local' initialized in function
    sum_local = a + b;
    return sum_local;
  endfunction

  initial begin
    int result;
    result = my_adder_func(5, 3);
    $display("Result: %0d", result);
  end

endmodule
