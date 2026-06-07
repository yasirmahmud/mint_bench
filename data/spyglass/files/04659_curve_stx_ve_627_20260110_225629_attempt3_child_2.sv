module curve_stx_ve_627_20260110_225629_attempt3 (
  output integer result_out // Declared as output to resolve W528 by ensuring the variable is considered 'read'
);

  // Function requiring four integer input arguments
  function automatic integer calculate_product;
    input integer in_a;
    input integer in_b;
    input integer in_c;
    input integer in_d;
    calculate_product = in_a * in_b * in_c * in_d;
  endfunction

  // The original 'integer result_reg;' declaration caused W528 as the $display statements
  // were not recognized as a 'read' by the linter in a synthesis context.
  // By making 'result_out' an output port, the variable's value is made externally observable,
  // satisfying the linting rule W528.

  initial begin
    // Assign results directly to the output port 'result_out'
    result_out = calculate_product(1, 2, 3, 1); // Fourth argument added in a previous step
    $display("Product 1: %0d", result_out);

    result_out = calculate_product(4, 5, 6, 1); // Fourth argument added in a previous step
    $display("Product 2: %0d", result_out);

    result_out = calculate_product(7, 8, 9, 1); // Fourth argument added in a previous step
    $display("Product 3: %0d", result_out);

    $finish;
  end

endmodule
