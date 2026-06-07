module curve_stx_ve_627_20260110_225629_attempt4;

  // Function requiring three integer input arguments
  function automatic integer calculate_sum;
    input integer val1;
    input integer val2;
    input integer val3;
    calculate_sum = val1 + val2 + val3;
  endfunction

  integer sum_result; // Correct declaration for an integer variable

  initial begin
    // Violation 1: Calling calculate_sum with only two arguments (expected three)
    sum_result = calculate_sum(10, 20);
    $display("Sum 1: %0d", sum_result);

    // Violation 2: Calling calculate_sum with only two arguments (expected three)
    sum_result = calculate_sum(30, 40);
    $display("Sum 2: %0d", sum_result);

    // Violation 3: Calling calculate_sum with only two arguments (expected three)
    sum_result = calculate_sum(50, 60);
    $display("Sum 3: %0d", sum_result);

    $finish;
  end

endmodule
