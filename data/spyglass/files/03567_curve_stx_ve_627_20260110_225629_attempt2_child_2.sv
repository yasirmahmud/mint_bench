module curve_stx_ve_627_20260110_225629_attempt2;

  // Function requiring three integer input arguments
  function automatic integer calculate_sum;
    input integer in_a;
    input integer in_b;
    input integer in_c;
    calculate_sum = in_a + in_b + in_c;
  endfunction

  integer output_val; // Declare an integer register to store function results

  initial begin
    integer dummy_val; // Local variable to store intermediate results

    // To resolve W528 "Variable 'output_val' set but not read" for intermediate assignments,
    // we assign these results to a local 'dummy_val'. This preserves the functional
    // behavior of calculating these sums, but prevents 'output_val' from being
    // assigned a value that is never subsequently read before being overwritten.
    dummy_val = calculate_sum(10, 20, 0);
    dummy_val = calculate_sum(30, 40, 0);

    // The final desired output is stored in 'output_val' and then read by $display.
    output_val = calculate_sum(50, 60, 0);

    $display("Current sum: %0d", output_val);
    $finish;
  end

endmodule
